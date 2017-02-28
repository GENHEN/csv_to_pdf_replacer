REM ======================================================
rem Author: genhen
color B
@echo off
title PDF RENAMER USING CSV
mode con: cols=47 lines=20
setlocal EnableDelayedExpansion
REM ======================================================

REM ======================================================
rem Ensure that all the files are in the same
rem folder/directory
REM ======================================================
echo Have you placed all the .csv and .pdf files in
echo the same folder as this .cmd file? If not,
echo quit and restart
pause

REM ======================================================
rem First we find the .csv file and save path
rem Name the variable CSV_LOC
REM ======================================================
For /R . %%G IN (*.csv) do SET CSV_LOC=%%G
cls

REM ======================================================
rem Then we use each line in the CSV file to get
rem the .pdf files and rename them
REM ======================================================
REM %%L in for loop stands for lines (string, not line
REM     number) in csv file
REM %%N in for loop stands for ID Number in csv file
REM %%B in for loop stands for first name
REM %%C in for loop stands for last name
REM ORIGINAL_NAME is the name of the file before renaming
REM NAME_REPLACE is the name of the file after renaming
SET ORIGINAL_NAME=hi
SET NAME_REPLACE=hi
FOR /F "usebackq skip=1 tokens=* delims=," %%L IN ("%CSV_LOC%") DO (
	FOR /F "tokens=3 delims=," %%N IN ("%%L") DO (
		FOR /F "tokens=1,2 delims=," %%B IN ("%%L") DO (
			SET "ORIGINAL_NAME=%%N.pdf"
			SET "NAME_REPLACE=%%B_%%C_!ORIGINAL_NAME!"

			rem ACTUALLY DOING THE RENAMING HERE
			REN "!ORIGINAL_NAME!" "!NAME_REPLACE!"
		)
	)
)
exit