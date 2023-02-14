
function Prompt {

    #-------------------------------------------------------------------------
    $date = Get-Date 
    $datep = '>> '+ $date.Hour +':'+ $date.Minute +':'+ $date.Second +' >> '
    $line = ''

    $location = Get-Location  
    $location = ''+$location+'\ '

    #$hidee = '{ H:'+(Get-ChildItem -Hidden).Length+' V:'+(Get-ChildItem).Length +' T:'+((Get-ChildItem).Length+(Get-ChildItem -Hidden).Length)+' } '

    $_host = Get-Host
    $_winsize = $_host.UI.RawUI.WindowSize

    for ($i = ($datep.Length+$location.Length); $i -lt $_winsize.Width; $i++) {
        $line = $line + ' '
    }
    
    $line = $datep+$location+$line
    #$line = Write-Host -ForegroundColor Black -BackgroundColor Gray -NoNewline $datep$location$line
    #-------------------------------------------------------------------------

    #-------------------------------------------------------------------------
    if (Get-Command git -ErrorAction SilentlyContinue) {
        $gitBranch = Get-ASCIICharacter(968)
        $gitBranch = $gitBranch+' '+(git branch --show-current)
        $gitStatus = (git status --short).Length
    }else {
        $gitBranch = ''
    }
    #-------------------------------------------------------------------------

    #-------------------------------------------------------------------------
    $services = '>> SERVICES >> UP:'+(get-service | Where-Object -Property Status -eq 'Running').Length+' DOWN:'+(get-service | Where-Object -Property Status -eq 'Stopped').Length+' '
    for ($i = $services.Length; $i -lt $_winsize.Width; $i++) {
        $services = $services + ' '
    }
    #-------------------------------------------------------------------------

    #-------------------------------------------------------------------------
    Write-Host '' 
    Write-Host -NoNewline -ForegroundColor Green  $line 
    Write-Host -NoNewline -ForegroundColor Green $services
    if($gitStatus -gt 0){
        Write-Host -NoNewline -ForegroundColor Green ''$gitBranch
    }else{
        Write-Host -NoNewline -ForegroundColor DarkRed ''$gitBranch
    }
    
    $prompt = ' ... ' 
    $prompt
    #-------------------------------------------------------------------------
    
}

function Get-ASCIICharacter {
    param(
      [int]$number
    )
    [char]$number
}

Clear-Host

  