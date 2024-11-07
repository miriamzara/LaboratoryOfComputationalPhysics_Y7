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
for (( i=0; i<=17; i++ )); do
    echo $i
    if [ -e "${i}_mod18_students.csv" ]; then rm "${i}_mod18_students.csv"; fi
    echo $header_line > "${i}_mod18_students.csv"; done