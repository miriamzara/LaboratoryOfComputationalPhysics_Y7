max_count=$(cut -d',' -f1 LCP_22-23_students.csv | grep "^A" | wc -l)
max_count_letter=A
for letter in {A..Z}; do
    count=$(cut -d',' -f1 LCP_22-23_students.csv | grep "^$letter" | wc -l)
    echo "$letter: $count"
    if [ $count -gt $max_count ]; then
        max_count=$count
        max_count_letter=$letter; fi
    done
echo "The letter with maximum counts is $max_count_letter, with $max_count counts"


total_students=$(($(wc -l < LCP_22-23_students.csv) -1))
header_line=$(head -n 1 LCP_22-23_students.csv)

# Numerate the lines of the file, skipping the first one which is the header
#tail -n +2 LCP_22-23_students.csv | nl # pipe in with nl, that stands for number lines
#tail -n +1 LCP_22-23_students.csv  #this prints all lines
#tail -n +1 LCP_22-23_students.csv  #this starts from line 2

for (( i=0; i<=17; i++ )); do
    echo "writing on file ${i}_mod18_students.csv..."
    if [ -e "${i}_mod18_students.csv" ]; then rm "${i}_mod18_students.csv"; fi #if file exists from previous execution, delete it
    echo $header_line > "${i}_mod18_students.csv"; done # copy paste the header the header line on each separate file
    
# Fill the files
index=1 #loops through lines of the source file
while IFS= read -r line; do 
    # Skip the header line in the source file
    if (( index == 1 )); then ((index++)); continue; fi
    # Write the line in the appropriate file
    for (( i=0; i<=17; i++ )); do
        if (( index % 18 == i )); then #careful, here do not write $i but i
            echo "$line" >> "${i}_mod18_students.csv" #write the line inside the file
            #echo "${index} mod${i}" #for debugging
        fi
    done
    ((index++))
done < LCP_22-23_students.csv # specifies file to read from

    # what the conditional statement means:
    # IFS (Internal Field Separator) is set to an empty value.
	# This prevents leading or trailing whitespace in the lines from being trimmed.
	# Without this, read would split the line based on default delimiters (whitespace).
    # 	read is a Bash built-in command that reads a single line of input.
	#	-r prevents backslashes (\) from being interpreted as escape characters.
	#	For example, without -r, \n would be treated as a newline.
	#	The line is the name of the variable where the content of the line will be stored.

