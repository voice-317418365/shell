#!/bin/bash
serverdir=/mydata/nodeProject

cd $serverdir

for dir in ls $serverdir/
do
    if [ -f "$serverdir/$dir/bin/www.js" ]; then
          cd $dir
          forever start -s ./bin/www.js
          cd ../
          sleep 2
    fi
done
