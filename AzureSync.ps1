azcopy login --identity
$1 = $args[0]
$2 = $args[1]
$accounturl = "https://account.blob.core.windows.net"
$accountname = "accountname"
$accountkey = ""
$azureStorageContainer = "myquestablobs"
$azureContext = New-AzureStorageContext -ConnectionString "DefaultEndpointsProtocol=https;AccountName=$accountname;AccountKey=$accountkey;EndpointSuffix=core.windows.net;"
$blobchk = Get-AzureStorageBlob -Blob "$accounturl/$1$2" -Container $azureStorageContainer -Context $azureContext -ErrorAction Ignore
if (-not $blobchk)
{
    $NewBlobContainer = "$accounturl/$1$2".ToLower()
    azcopy make "$NewBlobContainer"
}
$NewBlobContainer = "$accounturl/$1$2".ToLower()
azcopy make "$NewBlobContainer"
azcopy sync "$PSScriptRoot\$1\$2" "$NewBlobContainer" --delete-destination=true
