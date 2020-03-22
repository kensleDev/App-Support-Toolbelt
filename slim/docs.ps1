

$content = get-content E:\Dev\repos\Windows-Helper\slim\keymap.ahk -ReadCount 1000 |
foreach { $_ -match "Capslock & " }


$content |
foreach { 

  $command = $_.ToString()

  $keyFirstHalf = $command.Substring($command.IndexOf("&") + 2)
  $key = $keyFirstHalf.Substring(0, $keyFirstHalf.IndexOf("::"))

  $altCmdFirstHalf = $command.Substring($command.IndexOf("cmd") + 5)
  $altCmd = $altCmdFirstHalf.Substring(0, $keyFirstHalf.IndexOf(","))
  Write-Output $altCmd
}
