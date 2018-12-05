Param(
    [Parameter(Mandatory=$true)]
    [string]$nugetClient,
    [Parameter(Mandatory=$true)]
    [string]$sourceRootDirectory,
    [Parameter(Mandatory=$true)]
    [string]$resultsDirectoryPath,
    [Parameter(Mandatory=$true)]
    [string]$logsPath,
    [Parameter(Mandatory=$false)]
    [string]$testNamePrefix,
    [Parameter(Mandatory=$false)]
    [int]$iterationCount = 1000
)


    . "$PSScriptRoot\..\PerformanceTestUtilities.ps1"
    
    $repoUrl = "https://github.com/cristinamanum/PerfTestClientS.git"
    $testCaseName = GenerateNameFromGitUrl $repoUrl
    
    $resultsFilePath = [System.IO.Path]::Combine($resultsDirectoryPath, "Restore$testCaseName.csv")
    
    $packagesConfig = SetupGitRepositoryWithPackagesConfig -repository $repoUrl -commitHash $commitHash -sourceDirectoryPath  $([System.IO.Path]::Combine($sourceRootDirectory, $testCaseName))

Write-Host !!!!!!!!!!!!!!!!!!!! $packagesConfig

    $name = "Symbols_NuGetClient_Config"
    # it will be downloaded multiple packages  
    $packageDownloadPath = ""
    # run only clean restore
    SetupNuGetFolders $nugetClient
    . "$PSScriptRoot\..\RunPerformanceTests.ps1" $nugetClient $packagesConfig $resultsFilePath $packageDownloadPath $logsPath $name  -skipWarmup -skipColdRestores -skipForceRestores -skipNoOpRestores -iterationCount $iterationCount