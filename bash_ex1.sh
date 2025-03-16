# 1
mkdir students
curl -L -O "https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1"
cd students
ls
cd ..
cp LCP_22-23_students.csv students/LCP_22-23_students.csv
cd students
ls
# 2
grep "PoD" LCP_22-23_students.csv  >> "PoD_students.csv"
grep "Physics" LCP_22-23_students.csv  >> "Physics_students.csv"
# 3,4
max_counts=$(grep -c "^A" LCP_22-23_students.csv)
max_counts_letter=A
for letter in {A..Z}; do
    counts=$(grep -c "^$letter" LCP_22-23_students.csv)
    if [ $counts -gt $max_counts ]; then
        max_counts_letter=$letter
        max_counts=$counts
    fi
done
echo "letter with max counts is $max_counts_letter, with $max_counts counts"

#5
index=0
while IFS= read -r line; do
    if ((index > 0 ));then #skip header line
        module=$(( index % 18 ))
        echo "$line" >> "students_$module_mod_18.csv"
    fi
    ((index++))
done < LCP_22-23_students.csv