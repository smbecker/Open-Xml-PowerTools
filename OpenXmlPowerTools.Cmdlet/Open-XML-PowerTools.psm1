<#***************************************************************************

Copyright (c) Microsoft Corporation 2014.

This code is licensed using the Microsoft Public License (Ms-PL).  The text of the license can be found here:

http://www.microsoft.com/resources/sharedsource/licensingbasics/publiclicense.mspx

Published at http://OpenXmlDeveloper.org
Resource Center and Documentation: http://openxmldeveloper.org/wiki/w/wiki/powertools-for-open-xml.aspx

***************************************************************************#>

<#

Various advanced functions contain prototypical ways of accomplishing certain things:

####################### All Open XML

Get-OpenXmlValidationErrors
- Supports wildcards
- Supports piping a collection of files into it
- Calls a C# function that returns a collection of objects
- Creates a hash table and calls Write-Output
- ValidateSet Parameter (Office version)

Test-OpenXmlValid
- Supports wildcards
- Supports piping a collection of files into it
- Calls a C# function (that returns bool) that was introduced by Add-Type in AddTypes.ps1
- Returns a boolean value
- ValidateSet Parameter (Office version)

AddTypes.ps1
- Add and use C# types
- Link to assemblies when compiling the C#

####################### DOCX

Clear-DocxTrackedRevision
- Supports wildcards
- Supports piping a collection of files into it
- ShouldProcess=$True, ConfirmImpact='Medium'
- Switch parameter (supports -Force)
- Calls directly into OpenXmlPowerTools using WmlDocument
- Defines aliases

Merge-Docx
- Calls directly into OpenXmlPowerTools using WmlDocument
- Defines aliases
- OutputPath parameter
- Returns WmlDocument object

#>

$ver = $PSVersionTable.PSVersion
if ($ver.Major -lt 3) { throw "You must be running PowerShell 3.0 or later" }
if (Get-Module Open-XML-PowerTools) { return }

# AddTypes.ps1 is in the same directory as Open-XML-PowerTools.psm1
# needs to access both Cmdlets and OpenXmlPowerTools
. "$PSScriptRoot\AddTypes.ps1"
. "$PSScriptRoot\Utils.ps1"

## Applies to any file
. "$PSScriptRoot\ConvertTo-Base64.ps1"
. "$PSScriptRoot\ConvertFrom-Base64.ps1"
. "$PSScriptRoot\ConvertTo-FlatOpc.ps1"
. "$PSScriptRoot\ConvertFrom-FlatOpc.ps1"

## Applies to all Open XML document types
. "$PSScriptRoot\Get-OpenXmlValidationErrors.ps1"
. "$PSScriptRoot\Test-OpenXmlValid.ps1"
. "$PSScriptRoot\Test-OpenXmlPowerToolsCmdlets.ps1"

# DOCX
. "$PSScriptRoot\Convert-DocxToHtml.ps1"
. "$PSScriptRoot\Clear-DocxTrackedRevision.ps1"
. "$PSScriptRoot\Expand-DocxFormatting.ps1"
. "$PSScriptRoot\Merge-Docx.ps1"
. "$PSScriptRoot\Complete-DocxTemplateFromXml.ps1"
. "$PSScriptRoot\New-Docx.ps1"
. "$PSScriptRoot\Add-DocxText.ps1"
. "$PSScriptRoot\New-WmlDocument.ps1"
. "$PSScriptRoot\DocxLib.ps1"
. "$PSScriptRoot\Get-DocxMetrics.ps1"

# XLSX

# PPTX
. "$PSScriptRoot\New-Pptx.ps1"
. "$PSScriptRoot\Merge-Pptx.ps1"
. "$PSScriptRoot\PptxLib.ps1"
. "$PSScriptRoot\New-PmlDocument.ps1"

Export-ModuleMember `
    -Alias @(
        'AcceptRevision',
        'Accept-DocxTrackedRevision',
        'BuildDocument',
        'BuildPresentation',
        'AssembleFormatting'
    ) `
    -Function @(
        # All Files
        'ConvertTo-Base64',
        'ConvertFrom-Base64',
        'ConvertTo-FlatOpc',
        'ConvertFrom-FlatOpc',
        'Convert-DocxToHtml',
        'Format-Xml',

        # All Open XML
        'Get-OpenXmlValidationErrors',
        'Test-OpenXmlValid',
        'Test-OpenXmlPowerToolsCmdlets',

        # DOCX
        'Clear-DocxTrackedRevision',
        'Expand-DocxFormatting',
        'Merge-Docx',
        'Complete-DocxTemplateFromXml',
        'New-Docx',
        'Add-DocxText',
        'Get-DocxMetrics',
        'New-WmlDocument',

        # XLSX

        # PPTX
        'New-Pptx',
        'Merge-Pptx',
        'New-PmlDocument'
    )
