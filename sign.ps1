#!/usr/bin/env pwsh
$ScriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
& node "$ScriptDir\sign.js" $args
