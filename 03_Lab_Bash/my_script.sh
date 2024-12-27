#!/bin/bash
# This simple script creates a new txt file with the name provided by the user
# if no name is provided, the text file is created anyway and by default named "newfile.txt"
# Then it writes 5 lines of content in the file through a for loop.

# checking if the user provided an input
if [ -z $1 ]
then
    echo "this script requires as input the name of the file to be created"
    exit
fi

# If input is given...

# check if the file is there
if [ ! -f "./$1" ] #-f: This flag checks if a file exists and is a regular file (not a directory, device file, etc.).
then
    echo "the file ./$1 does not exist! Setting a default value"
    file="newfile.txt" 
else
    file=./$1
fi

touch $file

for (( i=1; i<=5; i++ ))
do
    echo "add line $i" >> $file
done
