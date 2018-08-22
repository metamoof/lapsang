# load the file to be tested
$here = (Split-Path -Parent $MyInvocation.MyCommand.Path)
. $here\HelloWorld.ps1

#Pester Tests
Describe 'Get-HelloWorld' {
    It 'returns the string "Hello World"' {
        Get-HelloWorld | Should -Be "Hello World"
    }
}