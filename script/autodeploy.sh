##########################
#tomcat自动发布脚本
##########################
#!/bin/bash
now=`date +%Y%m%d%H%M%S`
tomcatPath=/mydata/apache-tomcat-7.0.55
backupPath=$tomcatPath/history_edition
testsvr="192.168.1.1"
war="root"

closeTomcat()
{
	echo 'try to stop tomcat...'
	tomcat_pid=`ps aux|grep "java"|grep $tomcatPath|awk '{printf $2}'`
	bash $tomcatPath/bin/shutdown.sh
	sleep 10
	if [ -n $tomcat_pid ]; then
	  echo "tomcat pid: $tomcat_pid"
	  kill -9 $tomcat_pid
	fi
	echo 'stop tomcat finished...'

}

back_old_war()
{
	echo 'try to backup old war...'
	cd $tomcatPath/webapps
	if [ -d "$tomcatPath/webapps/root" ]; then
	   tar -cf $war_$now.tar $tomcatPath/webapps/root
	   mv $war_$now.tar $tomcatPath/history_edition/
	fi
	rm -rf $tomcatPath/webapps/ROOT*
	echo 'backup old archive finished'
}

startTomcat()
{
	pid_count=`ps aux|grep "java"|grep $tomcatPath|wc -l`
		if [[ $pid_count ge 1 ]]; then
			echo "start tomcat..."
			bash $tomcatPath/bin/startup.sh
			sleep 5
		else
			echo "tomcat is exist 
			please check"
			exit 1
		fi
}


#######关闭tomcat
closeTomcat

#创建备份文件夹
if [ ! -d "$backupPath" ]; then
  mkdir "$backupPath"
fi
echo "tomcat path: $tomcatPath"
echo "backup path: $backupPath"

##备份
back_old_war



#从测试服务器拷贝root.war到本机
scp root@$testsvr:$tomcatPath/webapps/ROOT.war $tomcatPath/webapps/$war.war
cd $tomcatPath/update
if [ ! -f "$war.war" ]; then
  echo "war is not exist
  please check"
  exit 1
fi

#本机开始发布
startTomcat



####检测tomcat是否启动
if [[ $pid_count ge 1 ]]; then
	echo "start tomcat failed 
	please check"
	exit 1
else
	echo 'Deploy project sucessfully !!!'
fi


