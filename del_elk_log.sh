#!/bin/bash
log_path=/mydata/elklogs
logs_name=(elasticsearch-2019 logstash_9niu_output_ elasticsearch_index_search_slowlog.log elasticsearch_index_indexing_slowlog.log el
asticsearch_deprecation.log logstash.log kibana.log)
today=`date +%m-%d-%Y`
existday=10
logstash_date=`date -d '10 days ago' +%Y.%m.%d`



function cut_logstash()
{
        mv $log_path/logstash_9niu_output $log_path/logstash_$today
}

function del_logstash_data()
{
        curl -XDELETE 'http://localhost:9200/logstash-$logstash_date'
}



#cut logstash log
cut_logstash

#del logstash_data
del_logstash_data


for file in ${logs_name[*]}
do
        find $log_path -maxdepth 1 -type f -name "${file}*" -mtime +$existday  -exec rm -f {} \;
done