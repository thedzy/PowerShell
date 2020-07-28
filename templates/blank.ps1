
<#
    .COMPANY_NAME
        comapny

    .AUTHOR
        author

    .DATE
        YYYYY-MM-DD

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
        Adds a file name extension to a supplied name.

    .DESCRIPTION
        Adds a file name extension to a supplied name.
        Takes any strings for the file name or extension.

    .FUNCTIONALITY
        keyword, keyword

    .PARAMETER name1
        Parameter -name1

    .PARAMETER name2
        Parameter -name2

    .INPUTS
        None. You cannot pipe objects to Add-Extension.

    .OUTPUTS
        System.String. Add-Extension returns a string with the extension or file name.

    .EXAMPLE
        C:\PS> script.ps1 -name "File"
        File.txt

    .EXAMPLE
        C:\PS> script.ps1 -name "File" -extension "doc"
        File.doc

    .EXAMPLE
        C:\PS> script.ps1 "File" "doc"
        File.doc

    .LINK
        Online version: https://github.com

    .LINK
        Set-Item
#>

##########################################################################################
# Arguments
################
# https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-attributes?view=powershell-7

param
(
    [Parameter()]
    [string]
    # name1
    $name1,

    [Parameter()]
    [string]
    # name2
    $name2 = "txt"
)

##########################################################################################
# Traps
################

# Generic error trap
trap [System.Exception] {
    echo "ERROR"
    echo "Message: $_"
    
    # Continue in spite of the error
    #continue
}

# Generic error trap
trap [System.TimeoutException] {
    echo "Timeout"
    echo "Error Message: $_"
    Get-Member $_
    
    # Continue in spite of the error
    #continue
}

##########################################################################################
# Environment setup
################



##########################################################################################
# Functions
################





##########################################################################################
# Main
################

while ($true) {
    sleep 1
    echo "test"
    throw
}
write-host "Do something"

exit
