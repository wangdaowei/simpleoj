#! /bin/sh
#filename: python.sh
filePath=$1
args0=$2
args1=$3
args2=$4


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


echo  "compileTime:0"


python2  $filePath/t.py "${args0}" "${args1}" "${args2}" >/dev/null
if [ $? != 0 ]
        then
                exit 1
fi


run_start_time=$(date +%s.%N)
(
python2  $filePath/t.py "${args0}" "${args1}" "${args2}"
)&

(
sleep 0.001
pid=`ps -ef | grep "${filePath}/t.py" | awk 'NR==1 {print $2}'`
cat /proc/$pid/status | grep -e VmRSS
)&
wait
run_end_time=$(date +%s.%N)

echo -n  "runTime:"
getTiming $run_start_time $run_end_time