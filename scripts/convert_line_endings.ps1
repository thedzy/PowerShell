
<#
    .COMPANY_NAME
        thedzy.com

    .AUTHOR
        thedzy@hotmail.com

    .DATE
        2020-07-28

    .PLATFORM
        Windows

    .VERSION
        0.1    
#>

##########################################################################################
# Help
################
# https://docs.microsoft.com/en-us/powershell/scripting/developer/help/comment-based-help-keywords?view=powershell-7

<#
    .SYNOPSIS
        Convert ALL line breaks in the files in a folder or a file

    .DESCRIPTION
        Find files in folder, with filter, and replace all line breaks to the desired system or replace in a single file

    .FUNCTIONALITY
        crlf, lf, eol

    .PARAMETER path
        Path to file/folder to convert

    .PARAMETER to
        Format to convert to (cr, crlf, lf)

    .PARAMETER filter
        Filter files in folder

    .INPUTS
        Path to file/folder to convert

    .EXAMPLE
        Convert all files in folder
        C:\PS> convert_line_endings.ps1 -path ~/Downloads/textfiles/ -to crlf

    .EXAMPLE
        Convert 1 file
        C:\PS> convert_line_endings.ps1 -path ~/Downloads/textfile.txt -to lf

    .EXAMPLE
        Convert all txt files
        C:\PS> convert_line_endings.ps1 -path ~/Downloads/textfile/ -to lf -filter *.txt


    .LINK
        Original:  https://github.com/thedzy/PowerShell/tree/master/scripts
#>

##########################################################################################
# Arguments
################
# https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-attributes?view=powershell-7

param
(
    [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
    [string]
    # Convert path
    $path,

    [Parameter(Mandatory, Position = 1, HelpMessage = "CRLF or LF")][ValidateSet('cr', 'crlf', 'lf')]
    [string]
    # Convert to
    $to = "lf",

    [Parameter(Position = 2)]
    [string]
    # Forward to get-children
    $filter,

    [Parameter()]
    [switch]
    # Forward to get-children
    $recurse = $false
)
$arguments = @{
    Path = $path
}
if ($filter) { $arguments.Add("Filter", $filter) }
if ($recurse)  { $arguments.Add("Recurse", $true) }


##########################################################################################
# Environment setup
################

$eofs = @{
    cr   = "`r";
    crlf = "`r`n";
    lf   = "`n"
}


##########################################################################################
# Functions
################

Function convert_file {
    param (
        [string] $file, [string] $to
    )

    echo "Converting ... $file"

    # Take everything down to a common break
    $new_content = Get-Content -Raw -Path $file | % { $_ -replace "`r`n", "`n" } | % { $_ -replace "`r", "`n" } 
    # If not using unix, replace with intended
    if ($eofs.Item($to) -ne "`n") { $new_content = $new_content -replace "`n", $eofs.Item($to) }

    # Save contents
    $new_content | Set-Content -NoNewline -Path $file
}

##########################################################################################
# Main
################

# Validate path
if ( Test-Path $path) {
    # If directory loop
    if ((Get-Item $path) -is [System.IO.DirectoryInfo]) {
        foreach ($file in (Get-ChildItem @arguments -File)) {
            convert_file -to $to -file  $file.FullName
        }
    }
    else {
        convert_file -to $to -file (Resolve-Path $path)
    }
}


exit




