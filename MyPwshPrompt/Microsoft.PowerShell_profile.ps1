function Prompt {
    
    $_host = Get-Host
    $_winsize = $_host.UI.RawUI.WindowSize

    $date = Get-Date 
    $datep = ' < '+$date.Hour+':'+$date.Minute+':'+$date.Second+ ' > '
    
    $line = ''
    for ($i = $datep.Length; $i -lt $_winsize.Width; $i++) {
        $line = $line + '*'
    }
    $line = $datep + $line;

    if (Get-Command git -ErrorAction SilentlyContinue) {
        $gitBranch = Get-ASCIICharacter(968)+' '+(git branch --show-current) 
    }else {
        $gitBranch = Write-Host -ForegroundColor Red (Get-ASCIICharacter(967)+' ')
    }

    $prompt = $line + $gitBranch 

    $prompt = Write-Host -ForegroundColor Green -NoNewline $prompt 
    
    $prompt
    ' '
}

function Get-ASCIICharacter {
    param(
      [int]$number
    )
    [char]$number
}
  