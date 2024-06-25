$extensions = @(
    "cweijan.vscode-autohotkey-plus";
    "stylelint.vscode-stylelint";
    "Zignd.html-css-class-completion";
    "golang.Go";
    "VisualStudioExptTeam.vscodeintellicode";
    "ipatalas.vscode-postfix-ts";
    "dbaeumer.vscode-eslint";
    "octref.vetur";
    "onecentlin.laravel5-snippets";
    "onecentlin.laravel-blade";
    "ms-python.python";
    "ms-python.vscode-pylance";
    "ms-python.debugpy";
    "dsznajder.es7-react-js-snippets";
    "rubbersheep.gi";
    "eamodio.gitlens";
    "christian-kohler.npm-intellisense";
    "ms-vscode-remote.vscode-remote-extensionpack";
    "cssho.vscode-svgviewer";
    "Vue.volar";
    "Vue.vscode-typescript-vue-plugin";
    "lokalise.i18n-ally";
    "yoavbls.pretty-ts-errors";
    "ms-python.pylint";
    "ms-python.black-formatter";
    "ms-python.autopep8";
    "charliermarsh.ruff";
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

