#!/bin/bash

aCount=0
abCount=0

for i in 0 1 2 3 4 5 6 7 8 9
do
    # x stands for a marker to denote the duplicate digits, that is, the A or B candidate
    abFlag=`sed -n "s/${i}/x/p" code.txt | awk -Fx '{print $1}' | wc -l`
    if [ $abFlag == 2 ]; then

        ################ whether it is A or not ##########
        tmp="nothing"
        for line in `sed -n "s/${i}/x/p" code.txt | awk -Fx '{print $1}'`
        do
            if [ ${#tmp} == ${#line} ]; then
                aCount=$((${aCount}+1)) 
            fi
            tmp=$line
        done
        # special handling string like x123, that is resulting an empty string
        if [ "`sed -n "s/${i}/x/p" code.txt | awk -Fx '{print $1}'`" == "" ]; then
            aCount=$((${aCount}+1))
        fi
        ##################################################

        abCount=$((${abCount}+1))

    fi
done

echo ${aCount}A $(($abCount-$aCount))B
