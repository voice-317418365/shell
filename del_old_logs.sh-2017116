#########################################
#Function:    del old logs
#Usage:       ./del_old_log.sh
#Author:      Richard
#Company:     9NIU
#Version:     1.0
#ModTime:     2017/1/16
#########################################

logPaths=( /mydata/apache-tomcat-7.0.55/logs /var/log/nginx/oldlogs /mydata/nodeLog/log /var/log/nginx)
fileList=(catalina.20  catalina.out.20  host-manager.20  localhost.20 liupeng_20 localhost_access_log.20 access.log.20 buss.log.20 error.log.20 manager.20 cfniutrade2.0.log.20 cfniuerror.log.20 cfniutrade3.0.log.20 cfniuwarn.log.20 app.log.  errors.log.  access.log-20  system.log.  access_20  activity-access_20 bg-access_20 error_20 mobile-access_20 www-access_20 )

existDays=15

for logPath in ${logPaths[*]}
do
    for file in ${fileList[*]}
        do
            find $logPath -maxdepth 1 -type f -name "${file}*" -mtime +$existDays  -exec rm -f {} \;
        done
done
