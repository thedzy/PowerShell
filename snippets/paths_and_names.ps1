#!/bin/sh

$Script = ([System.IO.DirectoryInfo] $MyInvocation.InvocationName)

# Script script$Script
"Script            : {0} " -f $Script.FullName

# Path to Script
"Path to script    : {0}" -f (Split-Path -Path $Script -Parent)


# Full script$Script Name
"Script full name  : {0}" -f (Split-Path -Path $Script -Leaf)


# Base Name
"Script base name  : {0}" -f (Split-Path -Path $Script -Leaf).Replace($Script.Extension, "")

# script$Script extension
"Script extensison : {0}" -f $Script.Extension 

# Get path relative to our path
"Relative path     : {0}" -f $Script.FullName -replace [Regex]::Escape("$PWD"), ""

exit
