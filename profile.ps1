#Author: vhanla,  modded by: buttercubz
#Force coloring of git and npm commands
$env:TERM = 'cygwin'
$env:TERM = 'FRSX'
$env:TERM = "msys"


$global:foregroundColor = 'white'
$time = Get-Date
$curUser= (Get-ChildItem Env:\USERNAME).Value

Write-Host "Hello, $curUser " -foregroundColor $foregroundColor -NoNewLine; Write-Host "$([char]9829) " -foregroundColor Red
Write-Host "Today is: $($time.ToLongDateString())"`n -foregroundColor Green

function Prompt {
	# Prompt Colors
	# Black DarkBlue DarkGreen DarkCyan DarkRed DarkMagenta DarkYellow
	# Gray DarkGray Blue Green Cyan Red Magenta Yellow White

	$prompt_text = "Black"
	# $prompt_background = "Blue"
	$prompt_background = "DarkCyan"
	$prompt_git_background = "Green"
	$prompt_git_text = "Black"

	# Grab Git Branch
	$git_string = "";
	git branch | foreach {
		if ($_ -match "^\* (.*)"){
			$git_string += $matches[1]
		}
	}

	# Grab Git Status
	$git_status = "";
	git status --porcelain | foreach {
		$git_status = $_ #just replace other wise it will be empty
	}

	if (!$git_string)	{
		$prompt_text = "Black"
		$prompt_background = "DarkBlue"
		$prompt_git_background = "Green"
	}

	if ($git_status){
		$git_string = $git_string + "* "
		$prompt_git_background = "Red"
		$prompt_git_text = "White"
	}


$curtime = Get-Date
$path = PWD
Write-Host $path -foregroundColor $prompt_text -backgroundColor $prompt_background -NoNewLine
if ($git_string){
	Write-Host  "$([char]57520)" -foregroundColor $prompt_background -NoNewLine -backgroundColor $prompt_git_background
	Write-Host  " $([char]57504) " -foregroundColor $prompt_git_text -backgroundColor $prompt_git_background -NoNewLine
	Write-Host ($git_string)  -NoNewLine -foregroundColor $prompt_git_text -backgroundColor $prompt_git_background
	Write-Host  "$([char]57520)" -foregroundColor $prompt_git_background
}
else {
	Write-Host  "$([char]57520)" -foregroundColor $prompt_background
}
Write-Host -NoNewLine " $([char]955)" -foregroundColor Red
Write-Host -NoNewLine " (" -foregroundColor Green
Write-Host -NoNewLine ("{0:HH}:{0:mm}" -f (Get-Date)) -foregroundColor $foregroundColor
Write-Host -NoNewLine ") " -foregroundColor Green
Write-Host -NoNewLine "$([char]8594)" -foregroundColor Magenta

$host.UI.RawUI.WindowTitle = "PS >>User: $curUser >>Path: $((Get-Location).Path)"

Return " "

}