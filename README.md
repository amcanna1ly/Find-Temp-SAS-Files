# Find-Temp-SAS-Files
Finds Temporary SAS Files and Emails Report to Sys Admins

This program finds SAS temp files for all drives on the server and emails a report to the System Administrators. 

NOTE: This program will require heavy modification to run on your environment, the program as-is is designed specifically for my own environment.
The FindTempFile.bat file is used in Task Scheduler to run every day, it calls the Find Temp File That Start with A Dollar Sign.sas program.

To do:

1) Instead of listing out each drive manually in the program, have the program dynamically list each drive for each server
2) Include a servers.txt file in order for this to be run from one single server and ping each server instance instead of running each program on each seperate server.
