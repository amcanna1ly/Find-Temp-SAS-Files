set PATH=W:\ServerTools\ServerDiskSpaceReport\Version_3.0
set ScriptName=%PATH%\FindTempFiles.cmd


if %COMPUTERNAME%==PEER4 goto PEER4
rem -----------------------------------------------------------------
del C:\dl\tempfiles.txt
copy C:\dl\blank.dat  c:\dl\h_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\i_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\j_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\k_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\l_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\m_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\n_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\o_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\p_$.txt  /Y

H:
cd \
dir $*.* /s > c:\dl\h_$.txt

I:
cd \
dir $*.* /s > c:\dl\i_$.txt

J:
cd \
dir $*.* /s > c:\dl\j_$.txt

K:
cd \
dir $*.* /s > c:\dl\k_$.txt

L:
cd \
dir $*.* /s > c:\dl\l_$.txt

M:
cd \
dir $*.* /s > c:\dl\m_$.txt

O:
cd \
dir $*.* /s > c:\dl\o_$.txt

P:
cd \
dir $*.* /s > c:\dl\p_$.txt

rem ===============================================================================================

c:
cd \dl
copy c:\dl\h_$.txt+c:\dl\i_$.txt+c:\dl\j_$.txt+c:\dl\k_$.txt+c:\dl\l_$.txt+c:\dl\m_$.txt+c:\dl\o_$.txt+c:\dl\p_$.txt tempfiles.txt

del %PATH%\HTML_Reports\Large_temp_files_on_%COMPUTERNAME%.html
del %PATH%\HTML_Reports\ALL_temp_files_on_%COMPUTERNAME%.html

rem Run a SAS program to look for any files that start with a $ sign
"D:\Program Files\SASHome\SASFoundation\9.4\sas.exe" -CONFIG "Y:\SAS\%COMPUTERNAME%\9.4\S4\sasv9.cfg" -sasinitialfolder "W:\ServerTools\ServerDiskSpaceReport\Version_3.0" -sysin "W:\ServerTools\ServerDiskSpaceReport\Version_3.0\Find temp files that start with a dollar sign.sas"

rem Send out an email to PEER admins
if not exist "%PATH%\HTML_Reports\Large_temp_files_on_%COMPUTERNAME%.html" goto SKIP1
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe send-mailmessage -BodyAsHtml -from "amcannally@uabmc.edu" -to "amcannally@uabmc.edu" -subject 'NOTE: Large files that start with a $ sign' -Priority High -smtp hssmtp.hs.uab.edu -body (Get-Content -Path %PATH%\HTML_Reports\Large_temp_files_on_%COMPUTERNAME%.html -raw) -attachments "%PATH%\HTML_Reports\ALL_temp_files_on_%COMPUTERNAME%.html"
GOTO END

:SKIP1
if not exist "%PATH%\HTML_Reports\All_temp_files_on_%COMPUTERNAME%.html" goto END
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe send-mailmessage -BodyAsHtml -from "amcannally@uabmc.edu" -to "amcannally@uabmc.edu" -subject 'NOTE: Files that start with a $ sign' -smtp hssmtp.hs.uab.edu -body 'Check attachment for files that start with a $ sign' -attachments "%PATH%\HTML_Reports\ALL_temp_files_on_%COMPUTERNAME%.html"

GOTO END

rem ###############################################################################################
:PEER4
rem ###############################################################################################
del C:\dl\tempfiles.txt
copy C:\dl\blank.dat  c:\dl\q_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\r_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\s_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\t_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\u_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\v_$.txt  /Y
copy C:\dl\blank.dat  c:\dl\x_$.txt  /Y

Q:
cd \
dir $*.* /s > c:\dl\q_$.txt

R:
cd \
dir $*.* /s > c:\dl\r_$.txt

S:
cd \
dir $*.* /s > c:\dl\s_$.txt

T:
cd \
dir $*.* /s > c:\dl\t_$.txt

U:
cd \
dir $*.* /s > c:\dl\u_$.txt

V:
cd \
dir $*.* /s > c:\dl\v_$.txt

X:
cd \
dir $*.* /s > c:\dl\x_$.txt
rem ===============================================================================================

c:
cd \dl
copy c:\dl\q_$.txt+c:\dl\r_$.txt+c:\dl\s_$.txt+c:\dl\t_$.txt+c:\dl\u_$.txt+c:\dl\v_$.txt+c:\dl\x_$.txt tempfiles.txt

del %PATH%\HTML_Reports\Large_temp_files_on_%COMPUTERNAME%.html
del %PATH%\HTML_Reports\ALL_temp_files_on_%COMPUTERNAME%.html

rem Run a SAS program to look for any files that start with a $ sign
"D:\Program Files\SASHome\SASFoundation\9.4\sas.exe" -CONFIG "Y:\SAS\%COMPUTERNAME%\9.4\S4\sasv9.cfg" -sasinitialfolder "W:\ServerTools\ServerDiskSpaceReport\Version_3.0" -sysin "W:\ServerTools\ServerDiskSpaceReport\Version_3.0\Find temp files that start with a dollar sign.sas"

rem Send out an email to PEER admins
if not exist "%PATH%\HTML_Reports\Large_temp_files_on_%COMPUTERNAME%.html" goto SKIP1
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe send-mailmessage -BodyAsHtml -from "amcannally@uabmc.edu" -to "amcannally@uabmc.edu" -subject 'NOTE: Large files that start with a $ sign' -Priority High -smtp hssmtp.hs.uab.edu -body (Get-Content -Path %PATH%\HTML_Reports\Large_temp_files_on_%COMPUTERNAME%.html -raw) -attachments "%PATH%\HTML_Reports\ALL_temp_files_on_%COMPUTERNAME%.html"
GOTO END

:SKIP1
if not exist "%PATH%\HTML_Reports\All_temp_files_on_%COMPUTERNAME%html" goto END
%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe send-mailmessage -BodyAsHtml -from "amcannally@uabmc.edu" -to "amcannally@uabmc.edu" -subject 'NOTE: Files that start with a $ sign' -smtp hssmtp.hs.uab.edu -body 'Check attachment for files that start with a $ sign' -attachments "%PATH%\HTML_Reports\ALL_temp_files_on_%COMPUTERNAME%.html"

rem ===============================================================================================
:end
rem pause

