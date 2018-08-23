#Script to validate Local Admins
#********************************
#Actions:
#1. Get current Server date
#2. Check if database/file for report exists for current date. 
#3 If existing report does not exist run query of AD for expected computer object results.
#4 Create new database instance. Write contents of results from AD query to file with responded flag set to False.
#5 If Database exists load file, check if PC responded column, attempt to reach machine, if machnine could be reached, enter results into DB and mark responded as True.
#
#- Error handle and record all machines not reporting.
#
#- For each object, add results into table.
#	- Table to include, Distinguished name, DN of Admin group, Date, Responded
#	- Report to be run from 7 AM to 7 PM, this will check for existance of database between runs and continue from previous run state until all possible machines for that day session are captured
#

#Variables
[bool]$scriptActive = $True
$currentDate = (get-date -Format FileDate).ToString()
$reportingDirectory = $env:USERPROFILE + "\" + "Reports\Endpoint Local Admins"
$ReportPath = $reportingDirectory + "\" + $currentDate + ".csv"
$EmployeePCOUs = 'ou=Computers,dc=lapsang,dc=local','ou=Laptops,dc=lapsang,dc=local'
#List of all Organizational Units which need to be checked for computer objects. these are seperated by commas
#Might be more logical to have all employee devices under one OU and have two sub OUs for desktops and laptops, or other depending on requirements.

#Main

while ($scriptActive -eq $True){ #Check if script is running

if (Test-Path $reportingDirectory){ #Test if the reporting directory exists, create it if not, else check if the report itself exists for given date.
	if (Test-Path $ReportPath){
		$Computers = Import-CSV $ReportPath #Import the report
		ForEach ($computer in $Computers){
			if($computer.Responded -eq $False){
				#Run logic here to check contents of local admin group if machine responds and commit any changes to the DB, skipping machine if it does not respond
				

			}
			else{
				 
				
			}
			

		}
		#Once completed update changes to report in DB and set script active flag to false to exit while loop
		$scriptActive = $False
	}
	else{ #If report does not exist, create report and output to CSV. 
	 $Computers = $EmployeePCOUs | ForEach-Object {get-adcomputer -Filter * -Property name -SearchBase $_}
	 $report = @()
		ForEach ($Computer in $Computers){$report += New-Object psobject -Property @{"Computer Name"=$($Computer.DN);"Local Admins"=$null;Date=(Get-Date);"Responded" = $False} }
		$report | select "Computer Name", "Local Admins", "Date", "Responded" | Export-CSV -path $ReportPath
	 }
}
else {
	New-Item -ItemType directory -Path $reportingDirectory
}

}