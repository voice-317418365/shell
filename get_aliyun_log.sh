#!/bin/bash
########################
#获取阿里云服务器日志
#########################
#当天日期
year=`date +%Y`
month=`date +%m`
day=`date +%d`
#前一天日期
lastYear=`date -d last-day +%Y`
lastMonth=`date -d last-day +%m`
lastDay=`date -d last-day +%d`
#以 - 分割的前一天日期
lastDayFile=${lastYear}-${lastMonth}-${lastDay}
#last2DayFile=${lastYear}${lastMonth}${lastDay}
#落地文件的本地日期路径
lastDayFile2=${lastYear}${lastMonth}${lastDay}
fullDayPath=/mnt/yunwei/${year}${month}/${year}${month}${day}
mkdir -p ${fullDayPath}

ip=(


192.168.1.1

192.168.1.2

192.168.1.3

192.168.1.4
)

function my_scp()
{
        mkdir -p ${localPath}
        for i in ${svrPath[*]}
        do
                scp ${m}:$i ${localPath}
        done
        cd ${fullDayPath}
        zip -r ${zip_file} ${localPath}
}



for m in ${ip[*]}
do
        case $m in

                192.168.1.1)
                tomcat_path=/mydata/apache-tomcat-7.0.55/logs
                nginx_path=/var/log/nginx
                service_name=cfn_front_01
                svrPath=(${tomcat_path}/cfniuerror.log.${lastDayFile}.log 
                        ${tomcat_path}/cfniuwarn.log.${lastDayFile}.log 
                        ${nginx_path}/error.log-${lastDayFile2}.gz 
                        ${nginx_path}/www-access.log-${lastDayFile2}.gz)
                ;;
                192.168.1.2)
                tomcat_path=/mydata/apache-tomcat-7.0.55/logs
                nginx_path=/var/log/nginx
                service_name=cfn_front_02
                svrPath=(${tomcat_path}/cfniuerror.log.${lastDayFile}.log
                        ${tomcat_path}/cfniuwarn.log.${lastDayFile}.log
                        ${nginx_path}/error.log-${lastDayFile}.gz)
                ;;
                192.168.1.3)
                tomcat_path=/mydata/apache-tomcat-7.0/logs
                nginx_path=/var/log/nginx
                service_name=cfn_back
                svrPath=(${tomcat_path}/cfniu-ryManageerror.log.${lastDayFile}.log
                        ${tomcat_path}/cfniu-ryManagewarn.log.${lastDayFile}.log
                        )
                ;;
                192.168.1.4)
                tomcat_path=/mydata/apache-tomcat-7.0.55/logs
                nginx_path=/var/log/nginx
                service_name=niu100_front_01
                svrPath=(${tomcat_path}/niu100error.log.${lastDayFile}.log
                        ${tomcat_path}/niu100warn.log.${lastDayFile}.log
                        ${nginx_path}/error.log-${lastDayFile2}.gz
                        ${nginx_path}/www-access.log-${lastDayFile2}.gz)
                ;;
                
        esac
        localPath=${fullDayPath}/${service_name}_${m}
        zip_file=${service_name}_${m}.zip
        my_scp
done
