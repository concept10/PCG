# Get memory usage for all running services in Windows 11

# Get all running services and include process ID where available
$services = Get-CimInstance Win32_Service | Where-Object { $_.State -eq 'Running' }

$results = foreach ($svc in $services) {
    # Only services with a Process ID > 0 have an associated process
    if ($svc.ProcessId -gt 0) {
        try {
            $proc = Get-Process -Id $svc.ProcessId -ErrorAction Stop
            [PSCustomObject]@{
                ServiceName   = $svc.Name
                DisplayName   = $svc.DisplayName
                Status        = $svc.State
                ProcessId     = $svc.ProcessId
                ProcessName   = $proc.ProcessName
                MemoryUsed_MB = [math]::Round($proc.WorkingSet64 / 1MB, 2)
            }
        }
        catch {
            # Process may have exited between query and retrieval
        }
    }
}

# Sort results by memory usage
$results | Sort-Object MemoryUsed_MB -Descending | Format-Table -AutoSize
