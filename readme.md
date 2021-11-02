<b>This repository contains scripts that uninstalls and install Apache Maven 3.8.3 and also checks for internet connectivity.
A properties file is added to generalise the scripts and improve flexibility.</b>

<b>The script contains 3 function ;</b>

#1. To <i>uninstall</i> Maven if it is already installed.
- Checks if the Maven directory exists or not
- If it does, deletes  the path and removes the Environment variables

#2. <i>Download and install</i> the Maven zip file <i>if there is internet access</i>.
- Checks for internet availability
- If yes, downloads the zip file , extracts and install Maven
- Sets the environment variables.

#3. <i>Download the zip file</i> from a seperate location and install <i>if no access to internet.</i>
- For unavailability of internet access, extracts the zip file from a seperate location and installs maven.
- Sets environment variables

