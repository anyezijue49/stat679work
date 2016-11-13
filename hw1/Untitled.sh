awk pattern {action} filename
#example:
awk '$3 -$2 > 18' example.bed #show all lines whose 3rd element minus 2nd element are greater than 18
awk '$1 ~ /chr1/ && $3 - $2 >18' example.bed #A ~ B means A matches pattern B, here it is: $1 matches 'chr1'
