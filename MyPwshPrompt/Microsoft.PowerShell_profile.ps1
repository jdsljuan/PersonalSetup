$turns = 0
function Prompt {
    
    #-------------------------------------------------------------------------
    $date = Get-Date 
    $datep = '## '+ $date.Hour +':'+ $date.Minute +':'+ $date.Second +' ## '
    $line = ''

    $location = Get-Location  
    $location = ''+$location+'\ '

    $hidee = '{ H:'+(Get-ChildItem -Hidden).Length+' V:'+(Get-ChildItem).Length +' T:'+((Get-ChildItem).Length+(Get-ChildItem -Hidden).Length)+' } '

    $_host = Get-Host
    $_winsize = $_host.UI.RawUI.WindowSize

    for ($i = ($datep.Length+$location.Length+$hidee.Length); $i -lt $_winsize.Width; $i++) {
        $line = $line + '#'
    }
    
    $line = Write-Host -ForegroundColor Black -BackgroundColor Gray -NoNewline $datep$location$hidee$line
    #-------------------------------------------------------------------------

    #-------------------------------------------------------------------------
    if (Get-Command git -ErrorAction SilentlyContinue) {
        $gitBranch = Get-ASCIICharacter(968)
        if (Test-Path '.git'){
            $gitBranch = $gitBranch+' '+(git branch --show-current) 
        }
    }else {
        $gitBranch = ''
    }
    #-------------------------------------------------------------------------

    #-------------------------------------------------------------------------
    $prompt = $line + $gitBranch + ' > ' 
    #-------------------------------------------------------------------------

    $prompt
}

function Get-ASCIICharacter {
    param(
      [int]$number
    )
    [char]$number
}
  