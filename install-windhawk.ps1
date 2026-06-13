[CmdletBinding()]
param(
    [string]$Source = (Join-Path $PSScriptRoot 'local@taskbar-ai-quota.wh.cpp'),
    [string]$ModsSource = 'C:\ProgramData\Windhawk\ModsSource'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $Source -PathType Leaf)) {
    throw "Source file not found: $Source"
}

if (-not (Test-Path -LiteralPath $ModsSource -PathType Container)) {
    throw "Windhawk ModsSource folder not found: $ModsSource"
}

$destination = Join-Path $ModsSource (Split-Path -Leaf $Source)

try {
    Copy-Item -LiteralPath $Source -Destination $destination -Force
    "Installed: $destination"
}
catch [System.UnauthorizedAccessException] {
    throw "Access denied installing to $ModsSource. Run PowerShell as Administrator."
}
