# Validation Script for ADR and Guide Metadata
# Usage: powershell -File scripts/validate-adr-guide-metadata.ps1

$RepoRoot = (git rev-parse --show-toplevel).Trim()
$AdrPath = Join-Path $RepoRoot "docs/adr"
$GuidePath = Join-Path $RepoRoot "docs/guides"
$Errors = 0

Write-Host "Validating documentation metadata..."

# --- Function to validate YAML Frontmatter ---
function Validate-Metadata($FilePath, $Type) {
    $Content = Get-Content $FilePath -Raw
    $Matches = $Content -match "^---`r?`n(.*?)^---`r?`n"
    
    if (-not $Matches) {
        Write-Host "Error: $Type $FilePath has no YAML frontmatter."
        return $false
    }

    $Frontmatter = $Content.Split("---")[1]
    $Valid = $true

    # Mandatory fields
    $MandatoryFields = @("title:", "domain:", "related:")
    foreach ($Field in $MandatoryFields) {
        if (-not ($Frontmatter -match $Field)) {
            Write-Host "Error: $Type $FilePath is missing mandatory field: $Field"
            $Valid = $false
        }
    }

    # ADR specific checks
    if ($Type -eq "ADR") {
        if (-not ($Frontmatter -match "status:")) {
            Write-Host "Error: ADR $FilePath is missing mandatory field: status:"
            $Valid = $false
        }
    }

    return $Valid
}

# --- Process ADRs ---
if (Test-Path $AdrPath) {
    Get-ChildItem -Path $AdrPath -Filter "ADR-*.md" | ForEach-Object {
        if (-not (Validate-Metadata $_.FullName "ADR")) {
            $Errors = 1
        }
    }
}

# --- Process Guides ---
if (Test-Path $GuidePath) {
    Get-ChildItem -Path $GuidePath -Filter "*.md" | Where-Object { $_.Name -ne "README.md" } | ForEach-Object {
        if (-not (Validate-Metadata $_.FullName "Guide")) {
            $Errors = 1
        }
    }
}

if ($Errors -eq 1) {
    Write-Host "Metadata standard not fully met. See docs/METADATA-STANDARD.md"
    exit 1
} else {
    Write-Host "All ADRs and Guides are valid."
    exit 0
}
