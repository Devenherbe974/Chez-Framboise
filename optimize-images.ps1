# optimize-images.ps1
# Redimensionne chaque image du dossier images/ pour que son côté le plus long
# fasse au maximum 1600 px, et la recompresse en JPG qualité 82 %.
# Utilise System.Drawing (intégré à Windows, aucune dépendance).
# Lancer depuis le dossier "Chez Framboise" : .\optimize-images.ps1

Add-Type -AssemblyName System.Drawing

$imagesDir = Join-Path $PSScriptRoot "images"
$maxDim    = 1600
$quality   = 82L

# Encodeur JPEG avec paramètre qualité
$jpegCodec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
             Where-Object { $_.MimeType -eq 'image/jpeg' }
$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
    [System.Drawing.Imaging.Encoder]::Quality, $quality)

$totalBefore = 0
$totalAfter  = 0

Get-ChildItem -Path $imagesDir -File | Where-Object {
    $_.Extension -match '\.(jpg|jpeg)$'
} | ForEach-Object {
    $file       = $_
    $sizeBefore = $file.Length
    $totalBefore += $sizeBefore

    # Charger l'image
    $img = [System.Drawing.Image]::FromFile($file.FullName)
    $w   = $img.Width
    $h   = $img.Height

    # Calculer la nouvelle taille (le plus grand côté = $maxDim au plus)
    $longest = [math]::Max($w, $h)
    if ($longest -gt $maxDim) {
        $ratio = $maxDim / $longest
        $newW  = [int]($w * $ratio)
        $newH  = [int]($h * $ratio)
    } else {
        $newW = $w
        $newH = $h
    }

    # Créer le bitmap cible et dessiner en haute qualité
    $bmp = New-Object System.Drawing.Bitmap($newW, $newH, [System.Drawing.Imaging.PixelFormat]::Format24bppRgb)
    $g   = [System.Drawing.Graphics]::FromImage($bmp)
    $g.InterpolationMode  = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode      = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode    = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $g.DrawImage($img, 0, 0, $newW, $newH)
    $g.Dispose()
    $img.Dispose()

    # Sauvegarder dans un fichier temporaire puis remplacer (évite de corrompre l'original)
    $tempPath = "$($file.FullName).tmp"
    $bmp.Save($tempPath, $jpegCodec, $encoderParams)
    $bmp.Dispose()
    Move-Item -Force -Path $tempPath -Destination $file.FullName

    $sizeAfter   = (Get-Item $file.FullName).Length
    $totalAfter += $sizeAfter
    $reduction   = [math]::Round((1 - $sizeAfter / $sizeBefore) * 100)
    $beforeKo    = [math]::Round($sizeBefore / 1KB)
    $afterKo     = [math]::Round($sizeAfter  / 1KB)

    Write-Host ("{0,-18}  {1,5} Ko -> {2,4} Ko  ({3,3}% de moins)  [{4}x{5} -> {6}x{7}]" -f $file.Name, $beforeKo, $afterKo, $reduction, $w, $h, $newW, $newH)
}

$totalReduction = [math]::Round((1 - $totalAfter / $totalBefore) * 100)
Write-Host ""
Write-Host ("TOTAL : {0} Mo -> {1} Mo  ({2}% de moins)" -f [math]::Round($totalBefore/1MB,1), [math]::Round($totalAfter/1MB,1), $totalReduction)
