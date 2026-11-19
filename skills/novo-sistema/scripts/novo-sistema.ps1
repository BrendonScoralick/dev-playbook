<#
.SYNOPSIS
  Cria a base de um sistema novo a partir do dev-playbook (parte mecânica do /novo-sistema).

.DESCRIPTION
  - Copia estruturas/perfil-<a|b> para a pasta de destino (incluindo arquivos ocultos).
  - Opcional (-CopiarMetodo): copia metodo/ para .dev-playbook/metodo (ignorado pelo Git), para uso sem o plugin.
  - Preenche os campos dos modelos (nome, versão do playbook, data, responsável).
  - Cria .env a partir do .env.example e docs/estado.md a partir do modelo.
  - Inicializa o Git (branch main) se ainda não houver repositório.
  Não faz commit, não cria repositório no GitHub e não instala dependências.

.EXAMPLE
  powershell -ExecutionPolicy Bypass -File novo-sistema.ps1 -Playbook "C:\caminho\dev-playbook" -Perfil b -Nome "Agenda de Salas" -Responsavel "meu-usuario"
#>
param(
  [Parameter(Mandatory = $true)][string]$Playbook,
  [Parameter(Mandatory = $true)][ValidateSet('a', 'b')][string]$Perfil,
  [Parameter(Mandatory = $true)][string]$Nome,
  [string]$Responsavel = '',
  [string]$Destino = (Get-Location).Path,
  [switch]$CopiarMetodo
)

$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)

function Ler([string]$caminho) { [IO.File]::ReadAllText($caminho, [Text.Encoding]::UTF8) }
function Gravar([string]$caminho, [string]$texto) { [IO.File]::WriteAllText($caminho, $texto, $utf8) }

# 1. Conferências
$estrutura = Join-Path $Playbook "estruturas\perfil-$Perfil"
$metodo = Join-Path $Playbook 'metodo'
if (-not (Test-Path $estrutura)) { throw "Estrutura não encontrada: $estrutura" }
if (-not (Test-Path $metodo)) { throw "Pasta metodo não encontrada: $metodo" }
if (-not (Test-Path $Destino)) { New-Item -ItemType Directory -Path $Destino | Out-Null }
$existentes = Get-ChildItem -Path $Destino -Force | Where-Object { $_.Name -ne '.git' }
if ($existentes) { throw "A pasta de destino não está vazia: $Destino. Use uma pasta nova (pode conter só .git)." }

# 2. Versão do playbook e identificadores
$versao = ''
$repoPlaybook = ''
$manifesto = Join-Path $Playbook '.claude-plugin\plugin.json'
if (Test-Path $manifesto) {
  $m = (Ler $manifesto) | ConvertFrom-Json
  if ($m.version) { $versao = [string]$m.version }
  if ($m.repository) { $repoPlaybook = ([string]$m.repository) -replace '^https?://github\.com/', '' -replace '\.git$', '' }
}
if (-not $versao) { try { $versao = (git -C $Playbook describe --tags --abbrev=0 2>$null) } catch { } }
if (-not $versao) { $versao = 'sem-tag' }
$versao = $versao.Trim().TrimStart('v')
$data = Get-Date -Format 'yyyy-MM-dd'
$slug = ($Nome.ToLowerInvariant().Normalize([Text.NormalizationForm]::FormD) -replace '\p{Mn}', '' -replace '[^a-z0-9]+', '-').Trim('-')
if (-not $slug) { $slug = 'sistema' }

# 3. Cópias (robocopy: códigos < 8 = sucesso)
robocopy $estrutura $Destino /E /NFL /NDL /NJH /NJS /NP | Out-Null
if ($LASTEXITCODE -ge 8) { throw "Falha ao copiar a estrutura (robocopy $LASTEXITCODE)" }
if ($CopiarMetodo) {
  robocopy $metodo (Join-Path $Destino '.dev-playbook\metodo') /E /NFL /NDL /NJH /NJS /NP | Out-Null
  if ($LASTEXITCODE -ge 8) { throw "Falha ao copiar o método (robocopy $LASTEXITCODE)" }
}
$global:LASTEXITCODE = 0

# 4. Preenchimento dos modelos
$readme = Join-Path $Destino 'README.md'
$t = Ler $readme
$t = $t.Replace('<Nome do sistema>', $Nome).Replace('v<X.Y>', "v$versao").Replace('<aaaa-mm-dd>', $data).Replace('<sistema>/', "$slug/")
$t = [regex]::Replace($t, '(?m)^> Este arquivo e os demais.*\r?\n', '')
Gravar $readme $t

$claude = Join-Path $Destino 'CLAUDE.md'
$t = Ler $claude
$t = [regex]::Replace($t, '(?s)^<!--.*?-->\r?\n', '')
$t = $t.Replace('<nome>', $Nome).Replace('v<X.Y>', "v$versao")
Gravar $claude $t

$changelog = Join-Path $Destino 'CHANGELOG.md'
$t = Ler $changelog
$t = $t.Replace('<sistema>', $Nome).Replace('<aaaa-mm-dd>', $data).Replace('v<X.Y>', "v$versao")
Gravar $changelog $t

$pacote = Join-Path $Destino 'package.json'
$t = Ler $pacote
$t = $t.Replace('"<sistema>"', "`"$slug`"")
Gravar $pacote $t

if ($Responsavel) {
  $owners = Join-Path $Destino '.github\CODEOWNERS'
  $t = Ler $owners
  $t = $t.Replace('<responsavel>', "@$($Responsavel.TrimStart('@'))")
  Gravar $owners $t
}

if ($repoPlaybook) {
  $cfg = Join-Path $Destino '.claude\settings.json'
  $c = Ler $cfg
  Gravar $cfg ($c.Replace('<repositorio-do-playbook>', $repoPlaybook))
}

# 5. .env e docs/estado.md
$env = Join-Path $Destino '.env'
if (-not (Test-Path $env)) { Copy-Item (Join-Path $Destino '.env.example') $env }
$docs = Join-Path $Destino 'docs'
New-Item -ItemType Directory -Force -Path (Join-Path $docs 'adr') | Out-Null
$estado = Join-Path $docs 'estado.md'
if (-not (Test-Path $estado)) {
  Copy-Item (Join-Path $metodo 'modelos\estado-do-sistema.md') $estado
}

# 6. Git
if (-not (Test-Path (Join-Path $Destino '.git'))) {
  git -C $Destino init -b main | Out-Null
}

# 7. Resumo
$pendentes = Get-ChildItem -Path $Destino -Recurse -File -Force |
  Where-Object { $_.FullName -notmatch '\\\.dev-playbook\\|\\\.git\\|\\ISSUE_TEMPLATE\\' -and $_.Name -notin @('.env', 'pull_request_template.md') } |
  Select-String -Pattern '(?<!-)<(Nome do sistema|nome|sistema|X\.Y|aaaa-mm-dd|responsavel)>' -List |
  ForEach-Object { $_.Path.Substring($Destino.Length).TrimStart('\') }

Write-Output "OK: sistema '$Nome' (perfil $Perfil) criado em $Destino"
Write-Output "Versão do playbook: v$versao | pacote: $slug | data: $data"
Write-Output "Arquivos com campos de identificação ainda a preencher:"
if ($pendentes) { $pendentes | ForEach-Object { Write-Output "  - $_" } } else { Write-Output '  (nenhum)' }
