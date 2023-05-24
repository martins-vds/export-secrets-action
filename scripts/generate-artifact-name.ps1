[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]
    $Owner,
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]
    $RepoName,
    [Parameter(Mandatory = $false)]    
    [ValidateNotNull()]
    [string]
    $EnvironmentName = "",
    [Parameter(Mandatory = $false)]
    [ValidateSet( "org", "repo", "env")]
    [string]
    $SecretsType = "org"  
)

$name = "$SecretsType-secrets-$Owner-$RepoName".ToLowerInvariant()

if(![string]::IsNullOrWhiteSpace($EnvironmentName)) {
    $name = "$name-$EnvironmentName".ToLowerInvariant()
}

Write-Output "name=$name" | Out-File -FilePath $Env:GITHUB_OUTPUT -Encoding utf8 -Append