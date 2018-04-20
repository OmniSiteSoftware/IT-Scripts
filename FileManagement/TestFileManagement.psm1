# File Management PowerShell Module
# TP 4/13/2018

# Referenced by several automated File Management Scripts
# CompressFile selects object older than specified date in specified directory, compresses them, 
#   creates a .zip file reflecting the date, and removes the files from the soure destination
# RemoveOld is used to delete files older than a certain age.
# DO NOT use the FQDN in the UNC pointing to this module. You will get a Security Warning when running the script that cannot be supressed. 

Function MoveTemp($Source, $Age){
    $TimeSpan = (Get-Date).AddDays(-$Age)
    Get-ChildItem -Path $Source | Where-Object {$_.CreationTime -lt $TimeSpan
        } | Move-Item -Destination 'C:\Users\tpettit\Desktop\Script Testing Environment\Temp\'
        } 

Function CompressFile($Source, $Destination, $Age){
    $Destination += Get-Date -Uformat "%Y %m %d"
    $TimeSpan = (Get-Date).AddDays(-$Age)
    $Files = Get-ChildItem -Path $Source | Where-Object {$_.CreationTime -le $TimeSpan}
        ForEach ($_ in $Files) {Compress-Archive -Path $_.FullName -DestinationPath "$Destination.zip" -Update}
        ForEach ($_ in $Files) {Move-Item -Path $_.FullName -Destination 'C:\Users\tpettit\Desktop\Script Testing Environment\Logs\DeleteTest\'}
}

#RemoveOld expects $MaxAge to be a number of days
Function RemoveFiles($Source, $Age){
    $CurrentDate = Get-Date
    $Timespan = $CurrentDate.AddDays(-$Age)
    Get-ChildItem -Path $Source | Where-Object {$_.CreationTime -lt $TimeSpan
        } | Move-Item -Destination 'C:\Users\tpettit\Desktop\Script Testing Environment\DeleteTest\'
        }

Export-ModuleMember -Function *