# Inicializar Oh My Posh (Tema por defecto: jandedobbeleer)
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\prue_custom.omp.json" | Invoke-Expression

# Inicializar Zoxide (Alias 'z')
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Iconos en la terminal para 'ls' / 'dir'
Import-Module Terminal-Icons

# PSReadLine (Autocompletado con flecha derecha tipo Zsh / Fish)
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows


# Integración de FZF (Buscador rápido con Ctrl+R)
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    Set-PSReadLineKeyHandler -Chord 'Ctrl+r' -ScriptBlock {
        $result = (Get-History).CommandLine | fzf --height 40% --reverse
        if ($result) { [Microsoft.PowerShell.PSConsoleUtilities.PSReadLine]::Insert($result) }
    }
}

# Mise
Invoke-Expression (mise activate pwsh | Out-String)

# Comando 'which' para saber dónde se instala un ejecutable (como en Linux)
function which ($command) {
    Get-Command $command | Select-Object -ExpandProperty Source
}

# Atajo teclado antigravity cli
function agy { antigravity-cli $args }

# Claude Personal
function ccp {
    $env:CLAUDE_CONFIG_DIR = "$HOME\.claude_personal"
    claude $args
}

# Claude Empresa
function cce {
    $env:CLAUDE_CONFIG_DIR = "$HOME\.claude_empresa"
    claude $args
}
