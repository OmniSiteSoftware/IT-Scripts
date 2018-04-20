# File Management PowerShell Module
# TP 4/20/2018

# CompressFile selects object older than specified date in specified directory, compresses them, 
#   creates a .zip file reflecting the date, and removes the files from the soure destination
# RemoveOld is used to delete files older than a certain age. (used for cleaning up old .zip files primarily) 

Function CompressFile($Source, $Destination, $Age){
    $Destination += Get-Date -Uformat "%Y %m %d"
    $TimeSpan = (Get-Date).AddDays(-$Age)
    $Files = Get-ChildItem -Path $Source | Where-Object {$_.CreationTime -le $TimeSpan}
        ForEach ($_ in $Files) {Compress-Archive -Path $_.FullName -DestinationPath "$Destination.zip" -Update}
        ForEach ($_ in $Files) {Move-Item -Path $_.FullName -Destination 'C:\Users\tpettit\Desktop\Script Testing Environment\Logs\DeleteTest\'}
}

#RemoveOld expects $MaxAge to be a number of days
Function RemoveFiles($Source, $Age){
    $Timespan = (Get-Date -UFormat "%y %m %d").AddDays(-$Age)
    Get-ChildItem -Path $Source | Where-Object {$_.CreationTime -lt $TimeSpan
        } | Move-Item -Destination 'C:\Users\tpettit\Desktop\Script Testing Environment\DeleteTest\'
        }

Export-ModuleMember -Function *