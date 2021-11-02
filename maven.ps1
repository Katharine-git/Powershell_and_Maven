#uninstall Maven

function uninstallMaven ($path) {


  #check weather Maven is installed or not
  if (Test-Path $path)
  {

    Write-Verbose "Uninstalling maven"
    Remove-Item -Path $path -Force -Recurse 

    if (!(Test-Path $path))
    {
      Write-Verbose "Maven Uninstalled Successfully"
    }
    else {
      Write-Verbose "System can't Uninstall Maven because it may be use in another program(s)"
    }

    #Removing environmental variable
    [Environment]::SetEnvironmentVariable("MAVEN_HOME","$null","machine")
    [Environment]::SetEnvironmentVariable("Path",$env:Path + " ","Machine")

  }
  else{
    Write-Verbose "Maven is not installed"
  }

}

#downloading
function downloadmaven ($url,$destination) {

  Invoke-WebRequest -Uri $url -OutFile $destination
  if (Test-Path $destination)
  {
    Write-Verbose "ready to extract"
    Write-Verbose "extracting files...."
  }


  installmaven $destination $unzip_destination
}

#installing
function installmaven ($destination,$unzip_destination) {
  Expand-Archive -Path $destination -DestinationPath $unzip_destination -Force
  if (Test-Path $unzip_destination\$mavenversion)
  {
    Write-Verbose "File extracted successfully"
  }
  else
  {
    Write-Verbose "File extraction failed. Please check the path is correct"
  }
  
  #Setting Environment variables
  [Environment]::SetEnvironmentVariable("MAVEN_HOME",$unzipped,"machine")
  [Environment]::SetEnvironmentVariable("Path",$env:Path + ";$unzipped\bin","Machine")

}

#variables
$path = "C:\Users\user\OneDrive\Documents\maven\maven.properties"
$output = Get-Content $path | ConvertFrom-StringData


$url = $output.url
$destination = $output.destination
$unzip_destination = $output.unzip_destination
$mavenversion = $output.mavenversion
$logpath = $output.logpath
$VerbosePreference = "continue"
$servername = $output.servername

Start-Transcript -Path $logpath

Write-Host "---------------------------"
Write-Host "    Uninstalling Maven"
Write-Host "---------------------------"



uninstallMaven "$unzip_destination/$mavenversion"

Write-Host "------------------------------------"
Write-Host "   Maven Successfully Uninstalled"
Write-Host "-----------------------------------"

Write-Host " . "
Write-Host " . "
Write-Host " . "


Write-Host "--------------------------------"
Write-Host "  Preparing for maven install"
Write-Host "--------------------------------"

if ((Test-Connection -ComputerName $servername -Quiet) -eq "True")
{
  Write-Verbose "Server have Internet access"
  downloadmaven $url $destination
}
else
{
  installmaven $destination $unzip_destination
}


Stop-Transcript
