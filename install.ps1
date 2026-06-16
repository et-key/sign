$ErrorActionPreference = "Stop"

Write-Host "Playground の準備をしています…" -ForegroundColor Cyan

# 1. Node.js がなかったら自動で入れる
if (-Not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "必要なソフトウェアをインストール中です。" -ForegroundColor Yellow
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        winget install -e --id OpenJS.NodeJS --accept-package-agreements --accept-source-agreements
        Write-Host "インストールを完了させるために、一度この黒い画面を閉じて、もう一度、このファイルを実行してください。" -ForegroundColor Green
        Pause
        exit
    }
    else {
        Write-Host "インストールが完了しなかったので、お手数ですがもう一度、このファイルを実行してください。" -ForegroundColor Red
        Pause
        exit
    }
}

# 2. 必要なパッケージのインストール
Write-Host "必要なデータをダウンロード中です…" -ForegroundColor Cyan
Push-Location $PSScriptRoot
try {
    npm install
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "インストールが完了しました。" -ForegroundColor Green
Write-Host "次回からは、このフォルダにある「sign_web.ps1」を実行すると、Playground を起動できます。" -ForegroundColor Yellow

# 3. スタートメニューへの追加確認
Write-Host ""
$addShortcut = Read-Host "スタートメニューに「Sign Playground」のショートカットを追加しますか？ (y/n)"
if ($addShortcut -match "^[yY]") {
    try {
        $WshShell = New-Object -ComObject WScript.Shell
        $ShortcutPath = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs\Sign Playground.lnk"
        $Shortcut = $WshShell.CreateShortcut($ShortcutPath)
        
        $nodeCmd = Get-Command node -ErrorAction SilentlyContinue
        if ($nodeCmd) {
            $Shortcut.TargetPath = $nodeCmd.Source
        }
        else {
            $Shortcut.TargetPath = "node.exe"
        }
        $Shortcut.Arguments = "run_playground.js"
        $Shortcut.WorkingDirectory = $PSScriptRoot
        $Shortcut.Save()
        Write-Host "スタートメニューに追加しました。スタートメニューから「Sign Playground」を探してみてください。" -ForegroundColor Green
    }
    catch {
        Write-Host "ショートカットの作成に失敗しました..." -ForegroundColor Red
        Write-Host "このフォルダにある「sign_web.ps1」のショートカットをスタートメニューに追加すると、次回起動が簡単になります。" -ForegroundColor Yellow
    }
}

Write-Host ""
# 4. そのままPlaygroundを起動
Write-Host "Playgroundを起動します。" -ForegroundColor Cyan
& "$PSScriptRoot\sign_web.ps1"

Pause
