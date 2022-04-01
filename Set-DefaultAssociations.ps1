## Created 2020.12.14 by Rachel Catches-Ford and Brandon Kessler.
## Purpose: Sets Chrome to be the Default Browser.

## Detect if OEMDefaultAssociations.xml exists
$XmlHead = @"
<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
"@

$XmlTail = @"
</DefaultAssociations>
"@


$GoogleXML = @"
<Association Identifier=".htm" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
<Association Identifier=".html" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
<Association Identifier="http" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
<Association Identifier="https" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
"@

$AcrobatReaderXML = @"
<Association Identifier=".pdf" ProgID="AcroExch.Document.DC" ApplicationName="Adobe Acrobat Reader DC" />
<Association Identifier=".pdfxml" ProgID="AcroExch.pdfxml" ApplicationName="Adobe Acrobat Reader DC" />
<Association Identifier=".acrobatsecuritysettings" ProgID="AcroExch.acrobatsecuritysettings" ApplicationName="Adobe Acrobat Reader DC" />
<Association Identifier=".fdf" ProgID="AcroExch.FDFDoc" ApplicationName="Adobe Acrobat Reader DC" />
<Association Identifier=".xfdf" ProgID="AcroExch.XFDFDoc" ApplicationName="Adobe Acrobat Reader DC" />
<Association Identifier=".xdp" ProgID="AcroExch.XDPDoc" ApplicationName="Adobe Acrobat Reader DC" />
<Association Identifier=".pdx" ProgID="PDXFileType" ApplicationName="Adobe Acrobat Reader DC" />
<Association Identifier=".api" ProgID="AcroExch.Plugin" ApplicationName="Adobe Acrobat Reader DC" />
<Association Identifier=".secstore" ProgID="AcroExch.SecStore" ApplicationName="Adobe Acrobat Reader DC" />
"@


$AcrobatProDCXML = @"
<Association Identifier=".pdf" ProgID="Acrobat.Document.DC" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".pdfxml" ProgID="Acrobat.pdfxml" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".acrobatsecuritysettings" ProgID="Acrobat.acrobatsecuritysettings" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".fdf" ProgID="Acrobat.FDFDoc" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".xfdf" ProgID="Acrobat.XFDFDoc" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".xdp" ProgID="Acrobat.XDPDoc" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".pdx" ProgID="PDXFileType" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".api" ProgID="Acrobat.Plugin" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".secstore" ProgID="Acrobat.SecStore" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".sequ" ProgID="Acrobat.Sequence" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".rmf" ProgID="Acrobat.RMFFile" ApplicationName="Adobe Acrobat DC" />
<Association Identifier=".bpdx" ProgID="AcrobatBPDXFileType" ApplicationName="Adobe Acrobat DC" />
"@

$AcrobatPro2017XML = @"
<Association Identifier=".pdf" ProgID="Acrobat.Document.2017" ApplicationName="Adobe Acrobat Pro 2017" />
<Association Identifier=".pdfxml" ProgID="AcroExch.pdfxml" ApplicationName="Adobe Acrobat Pro 2017" />
<Association Identifier=".acrobatsecuritysettings" ProgID="AcroExch.acrobatsecuritysettings" ApplicationName="Adobe Acrobat Pro 2017" />
<Association Identifier=".fdf" ProgID="AcroExch.FDFDoc" ApplicationName="Adobe Acrobat Pro 2017" />
<Association Identifier=".xfdf" ProgID="AcroExch.XFDFDoc" ApplicationName="Adobe Acrobat Pro 2017" />
<Association Identifier=".xdp" ProgID="AcroExch.XDPDoc" ApplicationName="Adobe Acrobat Pro 2017" />
<Association Identifier=".pdx" ProgID="PDXFileType" ApplicationName="Adobe Acrobat Pro 2017" />
<Association Identifier=".api" ProgID="AcroExch.Plugin" ApplicationName="Adobe Acrobat Pro 2017" />
<Association Identifier=".secstore" ProgID="AcroExch.SecStore" ApplicationName="Adobe Acrobat Pro 2017" />
"@


$AcrobatPro2020XML = @"
<Association Identifier=".pdf" ProgID="Acrobat.Document.2020" ApplicationName="Adobe Acrobat Pro 2020" />
<Association Identifier=".pdfxml" ProgID="AcroExch.pdfxml" ApplicationName="Adobe Acrobat Pro 2020" />
<Association Identifier=".acrobatsecuritysettings" ProgID="AcroExch.acrobatsecuritysettings" ApplicationName="Adobe Acrobat Pro 2020" />
<Association Identifier=".fdf" ProgID="AcroExch.FDFDoc" ApplicationName="Adobe Acrobat Pro 2020" />
<Association Identifier=".xfdf" ProgID="AcroExch.XFDFDoc" ApplicationName="Adobe Acrobat Pro 2020" />
<Association Identifier=".xdp" ProgID="AcroExch.XDPDoc" ApplicationName="Adobe Acrobat Pro 2020" />
<Association Identifier=".pdx" ProgID="PDXFileType" ApplicationName="Adobe Acrobat Pro 2020" />
<Association Identifier=".api" ProgID="AcroExch.Plugin" ApplicationName="Adobe Acrobat Pro 2020" />
<Association Identifier=".secstore" ProgID="AcroExch.SecStore" ApplicationName="Adobe Acrobat Pro 2020" />
"@

$DefaultPath = "C:\Windows\System32"
$DefaultApps = "OEMDefaultAssociations.xml"

$7ZipXML = @"
<Association Identifier=".7z" ProgId="Applications\7zFM.exe" ApplicationName="7-Zip File Manager" />
"@

$CMTraceXML = @"
<Association Identifier=".log" ProgId="Log.File" ApplicationName="CMTrace_x86.exe" />
<Association Identifier=".lo_" ProgId="Log.File" ApplicationName="CMTrace_x86.exe" />
"@

## Create Function for creating App
function Set-DefaultApps{
param(
    [Parameter(Mandatory)][string]$Path,
    [Parameter(Mandatory)][string]$File,
    [Parameter(Mandatory)]$Xml
)
    New-Item -ItemType File -Path "$Path" -Name "$File" -Force ## Creates the File
    $Xml | Out-File -Force -FilePath $Path\$File -Encoding utf8 # Writes xml out
}


## Test for Adobe
$InstalledApps = Get-CimInstance -ClassName Win32_Product

if(($InstalledApps | Where-Object{$_.Name -like '*Acrobat*DC*'}) -and !($InstalledApps | Where-Object{$_.Name -like '*Reader*'})){
$Xml = @"
$XmlHead
$7ZipXML
$CMTraceXML
$GoogleXML
$AcrobatProDCXML
$XmlTail
"@
} elseif (($InstalledApps | Where-Object{$_.Name -like '*Acrobat*2020*'})) {
$Xml = @"
$XmlHead
$7ZipXML
$CMTraceXML
$GoogleXML
$AcrobatPro2020XML
$XmlTail
"@
}elseif (($InstalledApps | Where-Object{$_.Name -like '*Acrobat*2017*'})) {
$Xml = @"
$XmlHead
$7ZipXML
$CMTraceXML
$GoogleXML
$AcrobatPro2017XML
$XmlTail
"@
}elseif (($InstalledApps | Where-Object{$_.Name -like '*Reader*'})) {
$Xml = @"
$XmlHead
$7ZipXML
$CMTraceXML
$GoogleXML
$AcrobatReaderXML
$XmlTail
"@
}else{
$Xml = @"
$XmlHead
$7ZipXML
$CMTraceXML
$GoogleXML
$XmlTail
"@
}

Remove-Item -Path $DefaultPath\$DefaultApps -Force
Set-DefaultApps -Path $DefaultPath -File $DefaultApps -Xml $Xml