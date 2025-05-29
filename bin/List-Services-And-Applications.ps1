# List-Services-And-Applications.ps1
# Lists all services and installed applications on Windows 10, 11, and Server

Write-Host "=== SERVICES LIST ===" -ForegroundColor Cyan
Get-Service | Sort-Object Status, DisplayName | Format-Table Status, DisplayName, Name -AutoSize

Write-Host "`n=== APPLICATIONS LIST (User + Machine Scope) ===" -ForegroundColor Cyan

# Get installed applications from both 32-bit and 64-bit registry hives
function Get-InstalledApplications {
    $paths = @(
        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
    )

    foreach ($path in $paths) {
        Get-ItemProperty $path -ErrorAction SilentlyContinue | Where-Object {
            $_.DisplayName -and $_.DisplayName -ne ""
        } | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
    }
}

$appList = Get-InstalledApplications | Sort-Object DisplayName
$appList | Format-Table DisplayName, DisplayVersion, Publisher, InstallDate -AutoSize

Write-Host "`n=== DONE ===" -ForegroundColor Green