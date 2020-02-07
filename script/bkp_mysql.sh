#!/bin/bash
#########################################
#Function:    每天备份本地数据库 和 删除旧文件
#########################################

currentDay=`date +%F`
mainPath=/mnt/VM_Backup
childPath=${currentDay}/mysql_1.60
bkpPath=${mainPath}/${childPath}
dbPath=/var/lib/mysql

#备份数据库

if [ ! -d "$bkpPath" ]; then
    mkdir -p "$bkpPath"
fi

cd $dbPath
for db in $(ls ${dbPath})
do
    if [ -d $db ];then
        if [ $db == mysql -o $db == test -o $db == performance_schema ];then
            continue
        fi
        mysqldump -u root -proot $db > $bkpPath/${db}.sql
    fi
done

#删除旧文件

existDays=5

find $mainPath -maxdepth 1 -type d  -mtime +$existDays  -exec rm -rf {} \;