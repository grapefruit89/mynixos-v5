# 2>NUL & @cls & cd /d "%~dp0" & set "SCRIPT_PATH=%~f0" & powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-Expression ([System.IO.File]::ReadAllText($env:SCRIPT_PATH, [System.Text.Encoding]::UTF8))" & pause & exit /b

# --- KONFIGURATION ---
$currentDirName = (Get-Item .).Name
$baseFileName = ".\__$($currentDirName)_Bundle" 
$limit = 1MB

# --- VERSIONIERUNG ---
$counter = 0
$outFile = "${baseFileName}.md"
while (Test-Path $outFile) {
    $counter++
    $outFile = "${baseFileName}_$counter.md"
}

$rootPath = Get-Location
$date = Get-Date -Format "dd.MM.yyyy HH:mm:ss"

Write-Host "🚀 Starte Platinum Bundler v4.1 (Deep Space Compression + Encoding Fix) für: $currentDirName..." -ForegroundColor Cyan

# --- DATEIFILTER ---
$allFilesRaw = Get-ChildItem -Recurse -File -ErrorAction SilentlyContinue | Where-Object {
    $_.FullName -notmatch "node_modules|\.git|shredder_tmp" -and
    $_.Name -notmatch "bundler\.bat"
}

# --- HILFSFUNKTIONEN ---
function Test-IsBinaryFile {
    param($FilePath)
    try {
        $stream = [System.IO.File]::OpenRead($FilePath)
        $buffer = New-Object byte[] 1024
        $read = $stream.Read($buffer, 0, 1024)
        $stream.Close()
        if ($read -eq 0) { return $false }
        for($i=0; $i -lt $read; $i++) { if ($buffer[$i] -eq 0) { return $true } }
        return $false
    } catch { return $true }
}

function Format-Size {
    param($Bytes)
    if ($Bytes -lt 1KB) { return "$Bytes B" }
    if ($Bytes -lt 1MB) { return "{0:N2} KB" -f ($Bytes / 1KB) }
    return "{0:N2} MB" -f ($Bytes / 1MB)
}

# --- DATEIEN INDEXIEREN & BUNDLE-SCHUTZ ---
Write-Host "🔍 Scanne Dateien und ignoriere alte Bundles..." -ForegroundColor DarkGray
$indexedFiles = @()
$id = 1
foreach ($f in $allFilesRaw) {
    $firstLine = ""
    try {
        $stream = [System.IO.StreamReader]::new($f.FullName)
        $firstLine = $stream.ReadLine()
        $stream.Close()
    } catch {}

    if ($firstLine -match "PLATINUM_BUNDLER_IGNORE_FILE") {
        Write-Host "   -> Ignoriere Bundle-Datei: $($f.Name)" -ForegroundColor Magenta
        continue
    }

    $indexedFiles += [PSCustomObject]@{
        Id = $id
        Anchor = "[F-$($id.ToString('000'))]"
        File = $f
        RelPath = $f.FullName.Replace($rootPath.Path, "").TrimStart("\")
    }
    $id++
}

# --- PRO FEATURE 1: MAP / LANDKARTE ---
Write-Host "🗺️ Erstelle Landkarte..." -ForegroundColor Yellow
$treeEntries = @()
foreach ($item in $indexedFiles) {
    $depth = $item.RelPath.Split('\').Count - 1
    $prefix = " " * $depth
    $treeEntries += "$prefix- $($item.Anchor) $($item.RelPath)"
}

# --- PRO FEATURE 2: SEMANTIC TAGS ---
Write-Host "🧠 Analysiere Semantic Tags..." -ForegroundColor Yellow
$deepTree = $indexedFiles | Sort-Object {$_.File.Length} -Descending | Select-Object -First 80 | ForEach-Object {
    $raw = try { [System.IO.File]::ReadAllText($_.File.FullName, [System.Text.Encoding]::UTF8) } catch { $null }
    $tags = if ($raw) {
        ($raw -split '\W+' | Where-Object { $_.Length -gt 4 } | Group-Object | Sort-Object Count -Descending | Select-Object -First 5 -ExpandProperty Name) -join ", "
    } else { "no content" }
    "$($_.Anchor) $($_.RelPath) | $(Format-Size $_.File.Length) | Tags: [$tags]"
} | Out-String

# --- DATEI-STATISTIK ---
$stats = $allFilesRaw | Group-Object Extension | Sort-Object Count -Descending | Select-Object Count, Name, @{Name="SizeSum"; Expression={(($_.Group | Measure-Object Length -Sum).Sum / 1MB).ToString("N2") + " MB"}}
$statsBlock = $stats | Format-Table -AutoSize | Out-String

# --- HEADER & AI PROMPT SCHREIBEN ---
$headerBlock = @"
# 🤖 SYSTEM PROMPT FÜR DIE KI
**Rolle:** Du bist ein professioneller AI-Coding-Assistent und Software-Architekt.
**Kontext:** Diese Datei ist eine aggregierte "Single Source of Truth" (SSoT) des Projekts "$currentDirName".
**Anweisung:** 1. Nutze die untenstehende Landkarte und die Semantic Tags, um das gesamte Projekt zu verstehen.
2. Wenn du Code-Änderungen vorschlägst, beziehe dich IMMER auf die genauen `[F-XXX]` Anker und Dateipfade, damit der User weiß, wo der Code hingehört.
3. Analysiere Zusammenhänge zwischen den Dateien, bevor du Architektur-Entscheidungen triffst.

---

# 💎 PLATINUM AI CONTEXT BUNDLE: $currentDirName
Erstellt: $date | Quelle: $rootPath

## 🗺️ LANDKARTE (PROJECT TREE)
$($treeEntries -join "`r`n")

## 🧠 SEMANTIC TAGS (Top-80 Dateien)
$deepTree

## 📊 DATEI-STATISTIK
$statsBlock

## 📦 DATEI-INHALTE (SEMANTIC ANCHORS)
"@

Set-Content -Path $outFile -Value $headerBlock -Encoding UTF8

# --- PRO FEATURE 3: DATEI-LOOP MIT NUCLEAR PURITY & TOKEN GUARD ---
foreach ($item in $indexedFiles) {
    $fPath = $item.File.FullName
    $rel = $item.RelPath
    $anchor = $item.Anchor
    $ext = $item.File.Extension.TrimStart('.')
    if (-not $ext) { $ext = "txt" }

    Write-Host "Veredle $anchor $rel..." -ForegroundColor DarkGray
    $isBinary = Test-IsBinaryFile -FilePath $fPath
    $fileInfo = "### $anchor $rel`r`n* Pfad: $rel | Format: .$ext | Größe: $(Format-Size $item.File.Length)"
    
    Add-Content -Path $outFile -Value $fileInfo

    if ($isBinary) {
        Add-Content -Path $outFile -Value "* [BINARY-SKIP] Binärdatei übersprungen.`r`n---"
    }
    elseif ($item.File.Length -gt $limit) {
        Add-Content -Path $outFile -Value "* [TOKEN-GUARD] Datei > 1MB. Head/Tail 50 Zeilen:`r`n"
        Add-Content -Path $outFile -Value "````$ext"
        Get-Content $fPath -TotalCount 50 | Add-Content -Path $outFile
        Add-Content -Path $outFile -Value "`r`n[... MITTELTEIL ÜBERSPRUNGEN ...]`r`n"
        Get-Content $fPath | Select-Object -Last 50 | Add-Content -Path $outFile
        Add-Content -Path $outFile -Value "````n---"
    }
    else {
        Add-Content -Path $outFile -Value "````$ext"
        
        # 🛠️ ENCODING-FIX & MOJIBAKE-CLEANUP:
        $txt = try { [System.IO.File]::ReadAllText($fPath, [System.Text.Encoding]::UTF8) } catch { $null }
        
        if ($txt) {
            # 0. Mojibake & Non-Breaking-Space Killer
            $txt = $txt -replace [char]160, ' '
            $txt = $txt -replace 'Â', ''
            
            # 1. Base64 Killer (Bilder & Fonts)
            $txt = [regex]::Replace($txt, '(?i)(data:[a-z0-9-/]+;base64,)[a-z0-9+/=]{100,}', '$1[... BASE64 DATA REMOVED ...]')

            # 2. Kommentar-Shredder (HTML, JS, CSS, Python, Powershell)
            $txt = [regex]::Replace($txt, '(?s)', '')
            $txt = [regex]::Replace($txt, '(?m)^[ \t]*(\/\/|#|--).*$', '')
            $txt = [regex]::Replace($txt, '(?s)\/\*.*?\*\/', '')

            # 3. HTML/XML Tag Minifier (Zieht Tags zusammen > < wird zu ><)
            $txt = [regex]::Replace($txt, '>\s+<', '><')

            # 4. Unicode Block Filter (Nur Latin, Umlaute, Tabs, Newlines. Tötet Emojis & Steuerzeichen)
            $txt = [regex]::Replace($txt, '[^\p{IsBasicLatin}\p{IsLatin-1Supplement}\r\n\t]', '')

            # 5. Whitespace Deep Compression
            $txt = [regex]::Replace($txt, '(?m)[ \t]+$', '')      # Entfernt Trailing-Leerzeichen am Zeilenende
            $txt = [regex]::Replace($txt, '(?m)^\s+$', '')        # Leert Zeilen, die nur aus Leerzeichen/Tabs bestehen
            $txt = [regex]::Replace($txt, '(\r?\n){3,}', "`r`n`r`n") # Maximal 1 Leerzeile am Stück erlaubt

            $txt = $txt.Trim()
            if ($txt) { Add-Content -Path $outFile -Value $txt }
        }
        Add-Content -Path $outFile -Value "`r`n````n---"
    }
}

# --- FINAL INDEX ---
Add-Content -Path $outFile -Value "`r`n## 📌 INDEX ALLER ANCHORS`r`n"
$indexedFiles | ForEach-Object { $_.Anchor } | Add-Content -Path $outFile

Write-Host "================================" -ForegroundColor Green
Write-Host "✅ FERTIG! KI-Bundle erstellt:" -ForegroundColor Green
Write-Host "$outFile" -ForegroundColor White