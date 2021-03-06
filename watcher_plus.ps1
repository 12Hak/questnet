### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    $filewatcher = New-Object System.IO.FileSystemWatcher
    #Mention the folder to monitor
    $filewatcher.Path = "C:\temp\Questnet\watched"
    $filewatcher.Filter = "*.*"
    #include subdirectories $true/$false
    $filewatcher.IncludeSubdirectories = $true
    $filewatcher.EnableRaisingEvents = $true  

### DECIDE WHICH EVENTS SHOULD BE WATCHED 
#The Register-ObjectEvent cmdlet subscribes to events that are generated by .NET objects on the local computer or on a remote computer.
#When the subscribed event is raised, it is added to the event queue in your session. To get events in the event queue, use the Get-Event cmdlet.
    Register-ObjectEvent $filewatcher "Created" -Action $createaction
    Register-ObjectEvent $filewatcher "Changed" -Action $writeaction
    Register-ObjectEvent $filewatcher "Deleted" -Action $writeaction
    Register-ObjectEvent $filewatcher "Renamed" -Action $writeaction
    while ($true) {sleep 5}


### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    $writeaction = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content "C:\temp\Questnet\FileWatcher_log.txt" -value $logline
                
               }    


# LETS ADD SOME MORE STUFF

    $createaction = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content "C:\temp\Questnet\FileWatcher_log.txt" -value "hello"
                
              }    

