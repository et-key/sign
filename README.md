# Sign integrity generic notation

<img src="./Sign_logo.svg"  alt="Sign Logo" style="display:block; width:128px; margin:1.62%;"/>

Welcome to the Sign integrity generic notation Page!

This is a language for expressing the integrity of data evaluation generic way.
It is designed to be used in various Anyone, such as data validation, integrity checks, and Functional Effects.

## Manifesto

* [Our Manifesto](./documents/manifesto/manifesto.en-us.md)
* [日本語版はこちら](./documents/manifesto/manifesto.ja-jp.md)

## Example

* [language example](./documents/en-us/example.en-us.sn)
* [日本語はこちら](./documents/ja-jp/example.ja-jp.sn)

## Reference

* [language reference](./documents/en-us/Sign_reference_en-us.md)
* [日本語はこちら](./documents/ja-jp/Sign_reference_ja-jp.md)

## Specification

* [language specification](./documents/en-us/specification/)
* [日本語はこちら](./documents/ja-jp/specification/)

## License

* [Language-License](./documents/License/sign-language-license.en-us.md)
* [日本語はこちら](./documents/License/sign-language-license.ja-jp.md)

## Concept view

```mermaid
---
config:
  theme: redux-dark
---
graph LR

subgraph Lambda
        identity( _ : identity or Void )
end

subgraph Object[ Object = True ]
    Number([ - ... 0 ... +])
    Letter([ UTF ... etc])

    subgraph List [ List ...etc ]
        False( _ : false = Null)
    end
end

Apply([ Default or Fulfilled Apply ])
Partial([ Partial or Not Apply ])

identity <-.-> False
Lambda --> Partial & Apply
Partial --> False & Lambda
Apply --> List & Number & Letter
```

```mermaid
---
config:
  theme: redux-dark
---
graph LR
 subgraph Product[" "]
        Syntax
        List
        Stack
        Literal
        Compilation
  end

  subgraph Coproduct[" "]
        Semantics
        Lambda
        Stream
        Operator
        Interpretation
  end

  Syntax <===> Semantics

  List <===> Lambda

  Stack <===> Stream

  Literal <===> Operator

  Compilation <===> Interpretation
```

## Playground

You can launch the interactive web-based playground locally using any of the following (defaults to port `3980`):

### Windows ユーザー向けのかんたんセットアップ (For Windows Users)

初めて実行される方や、Node.js や npm の操作に不慣れな方は、専用のインストールスクリプトをご用意しております。

1. エクスプローラーで `install.ps1` を右クリックし、「PowerShell で実行」を選択してください。（またはターミナルから `./install.ps1` を実行します）
2. Node.js がインストールされていない場合は、画面の指示に従って自動インストールが可能です。
3. 必要なデータのダウンロードが完了すると、自動的に Playground が起動いたします。

**※2回目以降の起動について**
セットアップ完了後は、`sign_web.ps1` を実行していただくだけで、いつでも Playground を起動できます。

---

### その他の起動方法 (Manual Launch Methods)

- **npm script**:
  ```bash
  npm run playground [-- <port>]
  # Example: npm run playground -- 8080
  ```
- **Shell script** (for macOS/Linux/Git Bash):
  ```bash
  ./sign_web.sh [<port>]
  # Example: ./sign_web.sh 8080
  ```
- **PowerShell script** (for Windows PowerShell):
  ```powershell
  .\sign_web.ps1 [<port>]
  # Example: .\sign_web.ps1 8080
  ```

This will start the local development server at the selected port (default `http://localhost:3980`) and automatically open your default web browser.

