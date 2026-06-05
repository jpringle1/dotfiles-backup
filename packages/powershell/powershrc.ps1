# oh-my-posh init pwsh --config 'C:\Users\joe.pringle\appdata\local\programs\oh-my-posh\themes\catppuccin.omp.json' | Invoke-Expression
#oh-my-posh init pwsh | Invoke-Expression
# Invoke-Expression (& { (zoxide init powershell | Out-String) })

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardKillWord # ctrl w only deletes directory, not whole path
# Set-PSReadLineOption -PredictionSource HistoryAndPlugin
# Set-PSReadLineOption -PredictionViewStyle InlineView

Remove-Item alias:cat -Force
Remove-Item alias:ls -Force
Set-Alias -Name v -Value nvim
Set-Alias -Name g -Value lazygit
Set-Alias -Name cat -Value bat
Set-Alias -Name ls -Value lsd
Set-Alias -Name covrep -Value "C:/src/covrep/reportCoverage.ps1"
Set-Alias -Name wl-copy -Value Set-Clipboard

function y {
	$tmp = (New-TemporaryFile).FullName
	yazi.exe $args --cwd-file="$tmp"
	$cwd = Get-Content -Path $tmp -Encoding UTF8

	if ($cwd -and $cwd -ne $PWD.Path -and (Test-Path -LiteralPath $cwd -PathType Container)) {
		Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
	}

	Remove-Item -Path $tmp
}

function grep {
    $input | ForEach-Object { $_.ToString() } |
    findstr @args |
    ForEach-Object { $_.Trim() }
}

function vault {
    Set-Location "C:\src\obsidian-vaults\WorkVault"
}

function ln {
    param(
        [Parameter(Mandatory=$true)]
	[Alias('s')]
        [string]$Source,

        [Parameter(Mandatory=$true)]
	[Alias('t')]
        [string]$Target
    )

    New-Item -ItemType SymbolicLink -Path $Target -Target $Source
}

function setrepo {
    param(
        [string]$RepoName
    )

    [Environment]::SetEnvironmentVariable("CURRENTREPO", $RepoName, "User")
    $env:CURRENTREPO = $RepoName

    Write-Host "CURRENTREPO set to: $RepoName" -ForegroundColor Green
}

function gotorepo {
    $repo_base_dir = "C:\repos\jet2\"

   if (-not $env:CURRENTREPO) {
        Write-Host "CURRENTREPO is not set." -ForegroundColor Yellow
        return
    }

    $targetPath = Join-Path $repo_base_dir $env:CURRENTREPO

    if (-not (Test-Path $targetPath)) {
        Write-Host "Path does not exist: $targetPath" -ForegroundColor Red
        return
    }

    Set-Location $targetPath
}

function prompt {
    Write-Host "󰨊:::" -NoNewline -ForegroundColor Blue
    Write-Host (Get-Location) -NoNewline -ForegroundColor Cyan
    return "> "
}

function lst {
    param(
        [Parameter(Position = 0)]
        $Arg1,

        [Parameter(Position = 1)]
        $Arg2
    )

    $depth = 2
    $paths = @()

    # If -d is used, treat remaining args as paths
    if ($PSBoundParameters.ContainsKey('Arg1') -and $Arg1 -eq '-d') {
        $paths = @($Arg2)
    }
    else {
        # If first arg is numeric → depth mode
        if ($Arg1 -is [int]) {
            $depth = $Arg1
            $paths = @()
        }
        # If first arg is string → treat as path (optional fallback)
        elseif ($Arg1 -is [string] -and $Arg1) {
            $paths = @($Arg1)
        }
    }

    & lsd --tree --depth $depth @paths
}

function docker-up {
	docker-compose -f docker-compose.localdev.yaml up --build --force-recreate
}
