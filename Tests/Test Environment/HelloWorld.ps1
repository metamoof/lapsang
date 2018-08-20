function Get-HelloWorld ()
{
    "Hello World"
}

#Pester Tests
Describe 'Get-HelloWorld' {
    It 'returns the string "Hello World"' {
        Get-HelloWorld | Should -Be "Hello World"
    }
}