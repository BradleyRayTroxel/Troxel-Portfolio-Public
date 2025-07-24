param(
  [Parameter(Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string] $resourceGroupName
)

Describe 'Resource Group' {

It 'Exists' {
      $request = Get-AzResourceGroup -Name $resourceGroupName   
      $request.ResourceGroupName.Equals("$resourceGroupName") |
        Should -BeTrue -Because "the resource group was found"
    }

It 'Does not Exist' {
      $request = Get-AzResourceGroup -Name $resourceGroupName   
      $request.ResourceGroupName.Equals("$resourceGroupName") |
        Should -BeFalse -Because "the resource group was not found"
    }

}