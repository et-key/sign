# Sign — メモリ操作系仕様書（Project-Arena / Shared / Pin）

この文書は Sign 言語におけるメモリ操作プリミティブ（前置/中置演算子による allocation / deref / update / export）と、それに伴うメモリ戦略（project-arena / shared-heap / pinned-area）、およびローダ／ランタイムでの取り扱いを定義します。トップレベル限定ルール、評価時の振る舞い、アンロード条件、参照カウントの取り扱い、並行性上の留意点などをまとめます。

---

## 1. 用語定義

- project-arena（プロジェクトアリーナ）  
  そのプロジェクト（ビルド単位／実行単位）内でのアリーナ。多数のオブジェクトをここに割り当て、プロジェクト終了（または明示的アンロード）時に一括解放する目的で使う。

- shared-heap（共有ヒープ / promote 領域）  
  複数プロジェクト／モジュールから参照されうるオブ��ェクトを置く領域。RC/ARC 等で寿命を管理する。外部エクスポート（`##`）によりここへ配置されるのが原則。

- pinned-area（ピン領域）  
  永続的に常駐させたいオブジェクトの領域（カーネル API など）。`###` により予約される（将来的に実装）。原則アンロードしない。

- ref(l) / loc l  
  参照オブジェクトの抽象表現。`l` は場所（loc）。`σ[l]` はその場所の現在の値。

- G（global binding）  
  名前 → 値（または ref(l)）のトップレベル環境。ロード時に確定する。

- モジュールロード（postfix `@`）  
  ファイルの読み込み実行を表す。読み込みスコープは module-arena を持つ。

---

## 2. 言語プリミティブの役割（確定）

- prefix `#`（トップレベル RHS のみ有効）
  - 意味: project-arena に配置される参照（mutable cell）を作るマーカー。トップレベル定義の RHS に置くと、その名前は project-arena 内の ref を指す。  
  - 式中で出現した場合: 現状は「無視」する（将来的に構文エラーにする予定）。  

- prefix `##`（トップレベル RHS のみ有効）
  - 意味: shared-heap に配置して promote（shared/global に公開）する。トップレベル定義の RHS に置くと、global symbol table に登録され、他プロジェクトが参照可能となる。内部では RC/ARC 管理される。  
  - 式中で出現した場合: 現状は「無視」する（将来的に構文エラーにする予定）。  

- prefix `###`（トップレベル RHS のみ有効）
  - 意味: pinned-area に配置（静的常駐）。カーネル／常駐ミドルウェア向けに予約。実装は後日。  

- infix `#`（assignment）
  - 意味: lhs が ref(l) を指す場合に場所 l の中身を rhs の評価値で上書きする。（任意スコープで使用可能）

- prefix `@`（deref）
  - 意味: ref を読み出す（@ r → value）。（任意スコープで使用可能）

- postfix `@`（module-load）
  - 既存のモジュールロード振る舞い。module-arena を作成し、そのスコープ内でトップレベル定義を評価する。

---

## 3. トップレベル定義時の手続き（ロード時 semantics）

トップレベルの定義はファイルスコープ単位で逐次評価され、グローバル環境 G が構築される。定義の形は S 式で次のように表す：

```
[":", name, rhs]
```

ロード時の処理（簡潔）:

1. `rhs` が通常の式（先頭が `#` / `##` / `###` でない場合）
   - 評価して値 `v` を得る。  
   - 名前を project-arena にある不変値／構造を指すようにバインドする: `G[name] := v_projectArena`（実装上、単に G[name] ↦ v を格納すればよい）  

2. `rhs` が `["#", e]` の場合（トップレベル）
   - `e` を評価して値 `v` を得る。  
   - 新しい loc `l` を project-arena に割り当て `σ[l] := v`（可変セル）。  
   - `G[name] := ref(l)`  

3. `rhs` が `["##", e]` の場合（トップレベル）
   - `e` を評価して値 `v` を得る。  
   - `v` を shared-heap に allocate（あるいは直接 shared-heap に生成）。loc `l` を生成し `shared[l] := v`、`rc[l] := initial`（通常 1）。  
   - `register_global_symbol(module, name, l, mode="promote")` を行う。  
   - `G[name] := ref(l)`（shared-ref）

4. `rhs` が `["###", e]`（reserved/pin）
   - pin 実装方針に従う（static data segment か pinned-area に allocation）。`G[name] := ref(l_pin)`。通常アンロード不可。  

注: 再帰を許す場合はプレバインド (placeholder) の手順を用いる（後述）。

---

## 4. 小ステップ様スタイル規則（簡易表現）

以下は直感的な小ステップ風ルール（実装の仕様のための簡略化した表記）。

- (Allocation: top-level project ref)
  - G, ρ ⊢ e ⇓ v  
  - l fresh in project-arena  
  - σ' = σ[l ↦ v]  
  - ------------------------------------  
  - load_top([":", name, ["#", e]], G, σ) ⇒ G[name ↦ ref(l)], σ'

- (Promote: top-level shared)
  - G, ρ ⊢ e ⇓ v  
  - l fresh in shared-heap  
  - shared[l] = v; rc[l] := 1  
  - register_global(name, l, mode="promote")  
  - ------------------------------------  
  - load_top([":", name, ["##", e]], G, σ) ⇒ G[name ↦ ref(l)], updated shared

- (Deref)
  - G ⊢ r ⇓ ref(l)   and store(l) = v  
  - --------------------------------  
  - ⟨['@', r], G, σ⟩ → ⟨v, G, σ⟩

- (Assignment)
  - G ⊢ lhs ⇓ ref(l)   and G ⊢ rhs ⇓ v  
  - σ' = σ with σ[l] := v (and adjust rc if needed)  
  - ----------------------------------------------  
  - ⟨['#', lhs, rhs], G, σ⟩ → ⟨v, G, σ'⟩

- (Top-level loading order & prebind for recursion)
  - For mutual recursion support:
    1. Prebind placeholders: for each top-level name create placeholder ref or loc in target arena and bind to G (so names are visible during evaluation).
    2. Evaluate RHS expressions with G (placeholders visible).
    3. Initialize the placeholders with actual values (and adjust rc as needed).

注: 上は説明のための簡略化。実装では rc/increment/decrement と reachability の扱いを厳密に行う必要がある。

---

## 5. module-arena / promote / pin のアンロードルール

- project-arena（モジュール／プロジェクト）  
  - 原則: モジュール（またはプロジェクト）終了時に module-arena を一括解放できる。ただし、その中のオブジェクトが外部へ promote されている、または外部から参照されている場合は解放できない。  
  - 実装: allocation site に module-id タグを付ける。アンロード時、外部参照が残っていれば（refcount > 0 または global table にエントリ）解放を抑止する。

- promote（shared-heap）  
  - 原則: shared-heap のオブジェクトは RC/ARC（参照カウント）で管理。外部参照が完全になくなった時点で dealloc される（ただし循環は別途対処）。  
  - 循環対策: 初期段階では弱参照や manual collector の採用を検討。運用方針として、共有オブジェクトの設計時に循環を避けるか、cycle-collector を導入する。

- pin（pinned-area / `###`）  
  - 原則: 常駐（unload-prohibited）。必要時のみ loader が特別扱いでアンロードできる（複雑な依存解決が必要）。

- SCC（強連結成分）単位アンロード  
  - モジュール間に相互参照がある場合、依存グラフの SCC を単位にアンロードを検討する。単一モジュールのアンロードが不可能な場合はその SCC 全体をアンロードする仕組みを用意する。

---

## 6. 参照カウント（RC/ARC）ポリシー・実装指針

- shared-heap 上の各 loc `l` は `rc[l]` を保持する（初期値 1）。  
- rc の更新:
  - 参照をコピー／エクスポートする: `rc[l]++`  
  - 参照への最後のローカル参照が消える（scope end、代入で上書き、モジュール unload 等）: `rc[l]--`  
  - `rc[l] == 0` ⇒ dealloc l; その値が参照を含む場合は内包する loc の rc をデクリメント（再帰的）  
- 並行利用:
  - シングルスレッド: 非原子的な rc 操作で可。  
  - マルチスレッド／並列ロード: ARC（atomic increments/decrements）が必要。  
- 循環:
  - RC 単独では循環を解放できない。対策案:
    - 弱参照（weak refs）を導入して参照グラフのバックリンクを弱くする。  
    - モジュール終了時に cycle-detection を行う（optional）。  
    - サイクルコレクタ（トレースベース）を導入する。

---

## 7. ハンドル方式（オプションの安全戦略）

- export を直接オブジェクトの生ポインタとして渡す代わりに、ハンドル（整数 ID）を返し、外部はランタイム API 経由で操作するパターン。安全性と ABI の安定化に有利。  
- `create_handle(v)` → handle `h` を返す。`lookup_handle(h)` で実体を取得（内部で rc を管理）。ハンドルはプロセス間／リンク境界で安全に渡せる。  

---

## 8. Parser・言語実装上の扱い（実務メモ）

- トークナイザ  
  - `##`, `###` は最長一致で識別する（現行の opSymbols 長さソートで問題なし）。  

- パーサ  
  - トップレベル解析時にのみ `["#", e]` / `["##", e]` / `["###", e]` を許可する。  
  - 式中で現れた場合は現状「無視」する（評価では通常の意味を持たない）。将来のバージョンで構文エラー化のためのフラグを残す。  
  - 典型的な挙動（pseudo）:
    ```js
    if (isTopLevel && rhs[0] === '##') handlePromote(name, rhs[1]);
    else if (isTopLevel && rhs[0] === '#') handleProjectRef(name, rhs[1]);
    else handleNormalTopLevel(name, rhs);
    ```

- ランタイム / loader  
  - `handlePromote` は shared-heap に allocation（または promote）し、global symbol table に登録する。  
  - `handleProjectRef` は project-arena に allocationして G[name] に ref を入れる。  
  - モジュールアンロード時は依存解決（SCC）と外部参照チェックを行い、解放またはアンロード拒否を行う。  

---

## 9. API（標準ライブラリ推奨関数）

明示的な可変操作はプリミティブ/ライブラリで提供する。暗黙の ++/-- は言語として導入しない方針。

- 非原子的:
  - `inc(ref)` → 新しい値（増加後）を返す。`ref` は ref(l)。
  - `dec(ref)` → 新しい値（減少後）を返す。

- 原子的（並列環境）:
  - `atomic_inc(ref)` / `atomic_dec(ref)`  
  - `fetch_add(ref, n)` / `fetch_sub(ref, n)` — old value を返す

- その他:
  - `deref(ref)` ≡ `['@', ref]`（言語プリミティブとしても提供）
  - `assign(ref, value)` ≡ `['#', ref, value]`（中置演算子の呼び名）

---

## 10. テストケースの例（S式）

- project-arena top-level mutable ref:
  ```
  [":", "cache", ["#", ["map", ...]]]  ;; cache は project-arena の ref
  ```

- shared export (promote):
  ```
  [":", "logger", ["##", ["?", ["msg"], ["call", "log_backend", "msg"]]]]
  ```

- pin (reserved):
  ```
  [":", "kernel_io", ["###", ["?", ["buf"], ["call", "direct_io", "buf"]]]]
  ```

- 読み出し・更新:
  ```
  ['@', 'cache']          ;; deref
  ['#', 'cache_ref', 42]  ;; assignment
  ```

---

## 11. 追加実装上の注意／運用指針

- ��帰/相互参照のためのプレバインド: top-level 定義を評価する前に名前の placeholder を用意してから RHS を評価する。placeholder を使った後に値を初期化することで再帰が可能になる。

- Export の可視性: `##` による登録は loader の global symbol table にエントリを作る。バージョン管理／ABI 管理のために `module:name` の形式で登録し、 name collision を防ぐ。

- セキュリティ: カーネルやハードウェアアクセスを伴う API は `###`（pin）か、`##` とハンドル API の組合せで提供する。生ポインタを外部に渡すべきでない。権限チェック機構を設けること。

- 将来的拡張:
  - 式中での `#` / `##` を構文��ラーにする（言語バージョンアップ時の破壊的変更）。現状は互換のために「無視」する挙動を採る。
  - `##` にオプションを付けて pin/protect を切り替える（例: `##!`）。
  - cycle-collector, weak-ref の導入。

---

## 12. まとめ（設計上の利点）

- 明示的なメモリ配置（project-arena / shared / pin）により、ユーザコードがどこで副作用・永続性を生むかが一目瞭然。セキュリティと検査が容易。  
- project-arena をデフォルトにすることでユーザーランドは単純な一括解放で済み、runtime コストを低減できる。  
- `##` によるトップレベル promote は、外部公開 API を明確に管理し、リンク／ロード時の整合性を取りやすくする。  
