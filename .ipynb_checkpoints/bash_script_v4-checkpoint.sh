
if [ -z $1 ]
then
    echo "this script requires as input an integer"
    exit
else
    n=$1
fi


# 2.a
grep -v "^#" data.csv > data.txt
sed -i " " 's/,//g' data.txt

# 2.b
even_counter=0
odd_counter=0
while IFS= read -r line; do

    for field in $line; do
        if (( field % 2 == 0 )); then
            (( even_counter++ ))
        else
            (( odd_counter++ ))
        fi
    done   
done < data.txt
total=$(( $even_counter + $odd_counter ))
echo "even numbers are $even_counter and odd numbers are $odd_counter"

# 2.c
max_sqrt=$(echo "scale=4; (100*sqrt(3))/2" | bc)
echo "$max_sqrt"
counter=0
while IFS= read -r line; do
    x=$(echo "$line" | cut -f 1 -d " ")
    y=$(echo "$line" | cut -f 2 -d " ")
    z=$(echo "$line" | cut -f 3 -d " ")
    sqrt=$(echo "scale=4; sqrt($x^2+$y^2+$z^2)" | bc)
    if (( $(echo "scale=4; $sqrt <= $max_sqrt" | bc) )); then
        ((counter++))
    fi
    #echo "$x $y $z $sqrt $counter"
done < data.txt
echo "entries are $counter"

#2.d

for (( i=1; i<=n; i++ )); do
    while IFS= read -r line; do
        (echo "$line" | awk -v "divisor=$i" '{for (j=1; j<=NF; j++) $j=sprintf($j/divisor)} 1' ) >> "data_copy_$i.txt"
    done < data.txt
done