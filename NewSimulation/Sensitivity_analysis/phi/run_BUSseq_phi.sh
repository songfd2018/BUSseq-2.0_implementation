#!/bin/sh

# compile the source code
make

# Sensitivity Analysis for phi

para=phi

for index in 1 2 3 4
do

cd "/scratch/data01/BUSseq_cpp/Revision/GitHub_sub/NewSimulation/Sensitivity_analysis/$para"

wkdir="$para$index"
echo $wkdir

if [ ! -d "$wkdir" ]
then
    echo "Folder doesn't exist. Creating now"
    mkdir $wkdir
    echo "Folder created"
fi

BUSseq_"$wkdir" -d./$wkdir/  -r../RawCountData/ -p simulation -v 1 -K 5 -i 4000 -o 1000 -s 9123 -c 8
BUSseq_inference -d./$wkdir/  -r../RawCountData/ -p simulation -v 1 -K 5 -i 4000 -b 2000 -c 8

done

# Collect the ARI
R-351 --vanilla --slave < "Collect_inference_$para.R"