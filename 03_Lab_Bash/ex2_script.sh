# 2.a: Make a copy of data.csv, removing metadata and commas
if [ ! -f "./data.csv" ]; then 
    echo "Source file does not exist"
    exit
fi
cp "./data.csv" "./data.txt"
sed -i '' '/^#/d' data.txt #delete all the lines starting with # (metadata)
sed -i '' 's/,/ /g' data.txt #substitute globally the character , with a whitespace " ", in-place (no new file created)
# note: " -i ' ' "" specifies to not create a backup of the current content of the file before doing the inplace replacement
# it is mandatory on MacOS

# 2.b: Count the even numbers
even_counter=0
odd_counter=0
while IFS= read -r line; do  
# Anatomy of the command:
# IFS: stands for "Internal Field Separator" and is set to empty
#           prevents _read_ from trimming or separating the lines based on
#           tabs or other separators
# -r: tells to treat the char "\" literally and not as escape characters
# line: this is the variable where _read_ will store its output
    for field in $line; do # iterate through line fields, i.e. the blocks separated by whitespaces
        if (( field % 2 == 0 )); then
            ((even_counter++)); else
            ((odd_counter++))
        fi
    done 
done < data.txt #specify which file you should read from
echo "Even numbers are ${even_counter}"
echo "Odd numbers are ${odd_counter}"



# 2.c Count the occurrences of sqrt(x^2 + Y^2 + Z^2) < threshold

threshold=$(echo 'scale=4; 100 * sqrt(3) / 2' | bc)
# grep "^#" data.csv # to inspect which columns contain the (X, Y, Z) values
smaller_counter=0
larger_counter=0
line_counter=0
while IFS= read -r line; do
    (( line_counter++ ))
    # Retrieve the X, Y and Z fields
    X=$(echo $line  | cut -f1 -d " ")
    Y=$(echo $line  | cut -f2 -d " ")
    Z=$(echo $line  | cut -f3 -d " ")
    sum_of_squares=$(echo "$X^2 + $Y^2 + $Z^2" | bc)
    root=$(echo "scale=4;sqrt($sum_of_squares)" | bc)
    #echo "$line_counter, $X, $Y, $Z, $sum_of_squares, $root" #for debugging
    #if [ $root -le $threshold ]; then  # this works for integers, but not for floats!
    if (( $(echo "$root <= $threshold" | bc -l) )); then
        ((smaller_counter++))
    else 
    ((larger_counter++))
    fi
done < data.txt
echo "larger than threshold fields: $larger_counter$ over $line_counter"
echo "smaller than threshold fields: $smaller_counter$ over $line_counter"

#2.d: Create n new files. In the i-th file, all values are divided by i

n=4
for ((i=2; i<=n; i++)); do
    while IFS= read -r line; do
        # Use awk to divide each number in the line by i
        #echo "$line" | awk '{for(j=1;j<=NF;j++) $j=$j/$i}1' #simpler version with default precision
        echo "$line" | awk  -v divisor="$i" '{for(j=1;j<=NF;j++) $j=sprintf("%.3f", $j/divisor)}1' >> "data_$i".txt  #custom number of digits in the output
        # the 1 at the end causes awk to print the modified line
    done < "data.txt"
done