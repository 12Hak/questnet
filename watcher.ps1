
# What path are you watching
$MonitorPath = "C:\temp\Questnet\watched\"

 
# specify which files you want to monitor
$FileFilter = '*' 
 
# specify whether you want to monitor subfolders as well:
$IncludeSubfolders = $true
 
# specify the file or folder properties you want to monitor:
$AttributeFilter = [IO.NotifyFilters]::FileName
 
# specify the type of changes you want to monitor:
$ChangeTypes = [System.IO.WatcherChangeTypes]::Created, [System.IO.WatcherChangeTypes]::Deleted, [System.IO.WatcherChangeTypes]::Renamed
$Timeout = 1000

# create a filesystemwatcher object
$watcher = New-Object -TypeName IO.FileSystemWatcher -ArgumentList $MonitorPath, $FileFilter -Property @{
    IncludeSubdirectories = $IncludeSubfolders
    NotifyFilter = $AttributeFilter
}
 
 
 
 
 
while($true){
$result = $watcher.WaitForChanged($ChangeTypes, $Timeout)
    if (($result.ChangeType).ToString() -ne "0") {
        if (($result.ChangeType).ToString() -eq "Renamed") {
            $logline = "$(Get-Date) $($result.ChangeType) - $($result.OldName) to $($result.Name)"
            Add-content "C:\temp\Questnet\FileWatcher_log.txt" -value $logline #log changes to file
            write-host $logline
        }
        else {
            $logline = "$(Get-Date) $($result.ChangeType) - $($watcher.SourceEventArgs.FullPath) $($result.Name)"
            Add-content "C:\temp\Questnet\FileWatcher_log.txt" -value $logline #log changes to file
            write-host $logline
        }
    }
 
   
}