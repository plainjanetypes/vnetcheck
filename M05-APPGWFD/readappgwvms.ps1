$vmnames= get-content -path '.\readappgwvms.txt'

#create an array
$vmnamesarray = @()

#loop to get values
foreach ($v in $vmnames) {
     $vmnamesarray +=  @{ value = $v }
     }


$vmnamesarray | ConvertTo-Json

write-output $vmnamesarray