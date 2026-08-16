/**
 * Sign コンパイラが投げるエラーの種別。
 *
 * 種別は「なぜ止まるのか」で分ける。値が `__` へ収束すべきものはそもそも例外にしない
 * ——型が合わないことは「その対象間に射が無い」ということだが、`__` は零対象であり
 * 零射 `A → __ → B` は常に存在するため、結果は `__` であって停止理由ではない
 * （0_design_principles.md 原理4 の「型が合わないことは違反ではない」）。
 *
 * | 種別 | 意味 | 例 |
 * |---|---|---|
 * | `SyntaxError` | そもそもプログラムが存在しない。射を書けていない | 縮約しきれない式、連鎖比較の混在 |
 * | `OperationError` | プログラムは在るが、その位置でその操作が許されていない | 仮引数部での `#`（Output） |
 * | （例外にしない） | 射が無い＝零射。`__` へ収束し、Pass 3b が理由を記録する | `` `abc` + 1 ``、範囲の端点が List |
 *
 * `TypeError` を `OperationError` の代わりに使わないこと。「型が合わない」は上の表の
 * 3行目であり、停止させない側である。名前を分けることで、停止する違反と `__` へ落ちる
 * 収束とがエラー種別だけで見分けられる。
 */

/**
 * 静的に判定できる「その位置でその操作は許されない」違反（原理4）。
 * 型の不一致ではないため `__` へは落とさず、コンパイルを停止する。
 */
export class OperationError extends Error {
  /**
   * @param {string} message 人間向けの説明
   * @param {{ spec?: string, reason?: string }} [info] 参照すべき規範箇所と機械可読なコード
   */
  constructor(message, info = {}) {
    super(message);
    this.name = "OperationError";
    if (info.spec) this.spec = info.spec;
    if (info.reason) this.reason = info.reason;
  }
}
