#!/bin/sh
#filename: java.sh
filePath=$1
args0=$2
args1=$3
args2=$4

className=Test


#arg1=start,arg2=end,format:%s.%N

function getTiming(){
	start=$1
	end=$2
	start_s=$(echo $start | cut -d '.' -f 1)
	start_ns=$(echo $start | cut -d '.' -f 2)
	end_s=$(echo $end | cut -d '.' -f 1)
	end_ns=$(echo $end | cut -d '.' -f 2)

	time=$(( ( 10#$end_s - 10#$start_s ) * 1000 + ( 10#$end_ns / 1000000 - 10#$start_ns / 1000000 ) ))

	echo "$time"
}


compile_start_time=$(date +%s.%N)
javac $filePath/t.java;
if [ $? != 0 ]
	then
		exit 1
fi

compile_end_time=$(date +%s.%N)
echo -n  "compileTime:"
getTiming $compile_start_time $compile_end_time

#get .class name
files=$(ls $filePath)
for filename in $files
do
    if [ "${filename##*.}"x == "class"x ]
	then
		className=${filename%.*}
    fi
done

run_start_time=$(date +%s.%N)
cd $filePath
#java ${className};
(
java MainClass "${args0}" "${args1}" "${args2}" "${filePath}javapid"
)&

(
sleep 0.01
pid=`ps -ef | grep "${filePath}javapid" | awk 'NR==1 {print $2}'`
cat /proc/$pid/status | grep -e VmRSS

memory=`cat /proc/$pid/status | grep -e VmRSS`
memorynumstr=`echo $memory | awk '
{
string=$0
len=length(string)
for(i=0; i<=len; i++)
{
tmp=substr(string,i,1)
if(tmp ~ /[0-9]/)
{
str=tmp
str1=(str1 str)
}
}
print str1
}
'`

mem=$((10#${memorynumstr}))
echo 'mem:'$mem
cd /
echo $mem>tmpfile
)&
mem2=`cat /tmpfile`
#rm  tmpfile
limit=100000
echo 'limit:'$limit
#if [ $((10#${memorynumstr}))+1 -gt $((10#${limit})) ]

echo 'mem2:'$mem2
if [ $mem2 -gt $limit ]
        then
                exit 1
fi

wait
echo
if [ $? != 0 ]
        then
                exit 1
fi

run_end_time=$(date +%s.%N)
echo -n  "runTime:"
getTiming $run_start_time $run_end_time