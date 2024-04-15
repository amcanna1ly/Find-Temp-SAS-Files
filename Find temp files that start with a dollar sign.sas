**********************************************************************
*  University of Alabama at Birmingham                               *
*  Pharmacovigilence project                                         *
**********************************************************************;
options pagesize=45 linesize=132 pageno=1 missing=' ' nodate mergenoby=error FORMCHAR="|----|+|---+=|-/\<>*" msglevel=i;
*options orientation=landscape papersize=(14in 8.5in );

* Programmer    : Alex McAnnally
* Creation date : Tuesday, September 26, 2017 09:13:37
* Modify date   : 6/6/19 revised to output file size in GB and only produce an HTML report
				  4/15/2024 revised and cleaned up program

This program is called by the W:\ServerTools\ServerDiskSpaceReport\Version_3.0\FindTempFiles.cmd script
;
%let cmt=Find temp files that start with a dollar sign;
%let pgm=&cmt..sas;
%let opt=/missing norow nocol nopercent;
%inc "h:\studies\PV\formats\libname.txt";
footnote "&pgm.";
footnote2 "%sysfunc(datetime(),datetime14.)";
title1 '--- PEER NETWORK ---';
**********************************************************************;
options macrogen mlogic mprint symbolgen;
options nomacrogen nomlogic nomprint nosymbolgen;

%let pgms=W:\ServerTools\ServerDiskSpaceReport\Version_3.0\;
%let htmlname=%sysfunc(translate(%quote(&cmt), '_',' '))-%left(%sysfunc(datetime(),datetime8.));
%let HTML_file_path=W:\ServerTools\ServerDiskSpaceReport\Version_3.0\HTML_Reports\;
%let RTF_file_path=h:\studies\pv\shared\users\rmatthews\output\;
%let PV_output=H:\studies\PV\Shared\Results\Medication Intermediate file\;

data _null_;
	length cname $20;
	cname = sysget("COMPUTERNAME");
	%global ComputerName;
	call symputx("SRVR", cname);
	t=today();
	format t mmddyy10.;
	put t=;
run;

filename in 'C:\dl\tempfiles.txt';

data read;
	infile in lrecl=500 missover;
	length line line2 $500 Path $256 FileDate $10;
	retain Path FileDate;
	input;
	line=_infile_;
	if index(line,'$prref 2015.csv') then delete;

	if substr(line,1,1) ne ' ' then filedate=substr(line,1,10);
	line2 = left(line);
	if line2=:'Directory of' then path=substr(line2,14);
	if line2 in: ('Directory of' 'Total Files Listed:') or index(line,'File(s)');
run;

data findbig; * Identify any folders that have large files that start with a $ sign;
	file "C:\dl\deltemp.bat";
	length size_c $50 outpath $256;
	set read;
	prev=lag(line2);
	if index(line,'File(s)') and prev=:'Total Files Listed:' then
		do;
			size_c		= scan(line,3,' ');
			size			= input(compress(size_c,","),18.0);
			FileSize_GB = round(size/1000000000,.1);

			if size > 1000000000 then 
				do;
					output findbig;
					if path ne '' then 
						do;
							outpath=cat('del ', trim(path), '\$*.*');
							put 'rem ' filedate;
							put outpath /;
						end;
				end;
		end;

	drop prev line: size;
run;

data all; * Identify any folders that have files that start with a $ sign;
	file "C:\dl\deltemp_all.bat";
	length size_c $50 outpath $256;
	set read;
	prev=lag(line2);
	if index(line,'File(s)') and (prev=:'Total Files Listed:' OR prev=:'Directory of') and index(path,'$RECYCLE.BIN')=0 then
		do;
			size_c		= scan(line,3,' ');
			size			= input(size_c,comma18.0);
			FileSize_MB = round(size/1000000,.1);

			if size <= 1000000000 then 
				do;
					output;
					if path ne '' then 
						do;
							outpath=cat('del ', trim(path), '\$*.*');
							put 'rem ' filedate;
							put outpath /;
						end;
				end;
		end;

	drop prev line: size:;
run;

/*proc print data=read ; run;*/
/*proc print data=all ; run;*/

ODS NoPtitle;
ods html body="Large_temp_files_on_&SRVR..html" path="&HTML_file_path" (url=none);
*ods rtf file="&RTF_file_path.&htmlname..rtf" style=EGdefault ;

proc print data=findbig; 
	var filedate path FileSize_GB;
	title1 "Large temp files on &SRVR";
	title3 'NOTE -- Check for current dates before deleting any files';
	title4 "Batch file to delete the large temp files is located in 'c:\dl\deltemp.bat'";
run;

ods html close;
ods rtf close;

*****************************************************************************************************;

ODS NoPtitle;
ods html body="All_temp_files_on_&SRVR..html" path="&HTML_file_path" (url=none);
*ods rtf file="&RTF_file_path.&htmlname..rtf" style=EGdefault ;

proc print data=all; 
	var filedate path FileSize_MB;
	title1 "All temp files on &SRVR";
	title3 'NOTE -- Check for current dates before deleting any files';
	title4 "Batch file to delete the temp files is located in 'c:\dl\deltemp_all.bat'";
run;

ods html close;
ods rtf close;

*####################################################################################################;
