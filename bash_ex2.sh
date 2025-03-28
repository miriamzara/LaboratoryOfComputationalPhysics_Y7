# imput parameter for point 4
if [ -z $1 ]
then
    echo "this script requires as input the name of the file to be created"
    exit
else
    n=$1
    echo "imput is $n"
fi



# 1
grep -v "^#" data.csv > data.txt
sed -i "" 's/,//g' data.txt # substitute in-place, globally

#2
even_counter=0
all_counter=0
while IFS= read -r line; do
    for field in $line; do
        if ((field % 2 == 0)); then
            ((even_counter++))
        fi
        ((all_counter++))
    done
done < data.txt
echo "even numbers are $even_counter"
echo "entries are $all_counter"

#3
counter=0
max_sqrt=$(echo "100*sqrt(3/2)" | bc)
while IFS= read -r line; do
    x=$(echo "$line" | cut -f 1 -d " ")
    y=$(echo "$line" | cut -f 2 -d " ")
    z=$(echo "$line" | cut -f 3 -d " ")
    sqrt=$(echo "sqrt($x^2+$y^2+$z^2)" | bc)
    if ((sqrt <= max_sqrt)); then
        ((counter++))
    fi
done < data.txt
echo "entries are $counter"

#4 

for ((i=1; i<=n; i++)); do
    while IFS= read -r line; do
        (echo "$line" | awk -v "divisor=$i" '{for (j=1; j<=NF; j++) $j=sprintf($j/divisor)}1') >> "data_copy_{$i}.txt"
    done < data.txt
done