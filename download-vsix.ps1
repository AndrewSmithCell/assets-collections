$extensions = @(
    "ms-vscode.cpptools";
)
$body=@{
    filters = ,@{
    criteria =,@{
            filterType=7
            value = $null
        }
    }
    flags = 1712
}
foreach($Extension in $extensions) {
    write-output "getting $($Extension)"
    $response =  try {
        $body.filters[0].criteria[0].value = $Extension
        $Query =  $body|ConvertTo-JSON -Depth 4
        (Invoke-WebRequest -Uri "https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery?api-version=6.0-preview" -ErrorAction Stop -Body $Query -Method Post -ContentType "application/json")
    } catch [System.Net.WebException] {
        Write-output "An exception was caught: $($_.Exception.Message)"
        $_.Exception.Response
    }
    $statusCodeInt = [int]$response.StatusCode

    if ($statusCodeInt -ge 400) {
        Write-Warning "API Error :  $($response.StatusDescription)"
        return
    }
    $ObjResults = ($response.Content | ConvertFrom-Json).results

    If ($ObjResults.resultMetadata.metadataItems.count -ne 1) {
        Write-Warning "Extension not found"
        return
    }

    $extension = $ObjResults.extensions

    $publisher = $extension.publisher.publisherName
    $extensionName = $extension.extensionName
    $version = $extension.versions[0].version

    $uri = "$($extension.Versions[0].assetUri)/Microsoft.VisualStudio.Services.VSIXPackage"
    Invoke-WebRequest -uri $uri -OutFile "$publisher.$extensionName.$version.VSIX"
}

