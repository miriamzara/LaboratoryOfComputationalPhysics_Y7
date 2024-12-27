#!/bin/bash
# This script prints out all input argument passed by user
# it returns an error message if no input is provided


# checking if the user provided an input
if [ -z $1 ] #if first argument is empty...
then
    echo "this script requires at least one input"
    exit
fi

# Print out the first argument
echo "first argument:"
echo $1

# Print out the second argument
echo "second argument:"
echo $2

# Loop through all input arguments
for arg in "$@"
do
    echo "$arg"
done
# Exit the script
exit