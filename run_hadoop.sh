#!/bin/sh
your_PC_name="YouKnowMe"
local_hadoop_home="/home/users/${your_PC_name}/hadoopclient/hadoop-client/hadoop"
hadoop="${local_hadoop_home}/bin/hadoop"

dir_path=""
log_path=""

function run()
{
    input_path=$1
    output_path=$2
    task_name=$3

    ${hadoop} fs -rmr ${output_path}

    ${hadoop} streaming \
        -jobconf mapred.output.key.comparator.class=org.apache.hadoop.mapred.lib.KeyFieldBasedComparator \
        -partitioner org.apache.hadoop.mapred.lib.KeyFieldBasedPartitioner \
        -jobconf num.key.fields.for.partition=1 \
        -jobconf stream.num.map.output.key.fields=2 \
        -input ${input_path} \
        -output ${output_path} \
        -jobconf mapred.job.name=$task_name \
        -jobconf mapred.job.priority=VERY_HIGH \
        -jobconf mapred.job.map.capacity=1000 \
        -jobconf mapred.job.reduce.capacity=1000 \
        -jobconf mapred.reduce.tasks=1000 \
        -jobconf mapred.map.memory.limit=100 \
        -jobconf mapred.reduce.memory.limit=200 \
        -mapper  "python26/bin/python mapper.py" \
        -reducer "python26/bin/python reducer.py" \
        -file ${dir_path}/mapper.py \
        -file ${dir_path}/reducer.py \
        -cacheArchive '/python26.tar.gz#python26'
}

function main()
{   
    day_date=`date -d "1 day ago" +"%Y%m%d"`
    input_path=""
    for((j=2;j<=2;j++))
    do
        let day_before=1+$j
        day_date_input=`date -d "$day_before day ago" +"%Y%m%d"`
        $hadoop fs -test -e "/data/my_test-${day_date_input}"
        if [[ $? -ne 0 ]]  ; then
            continue
        fi
        
        input_path="/data/my_test-${day_date_input}"

        output_path="/data/OUT-${day_date_input}"
        task_name="map-reduce-${day_date_input}"
        run $input_path $output_path $task_name

        sleep 10
    done
}

main
