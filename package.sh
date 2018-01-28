#!/bin/bash
mkdir /data
cd /data
cp /root/app/{server,LICENSE} .
mkdir lib
cd lib
cp /lib/ld-linux.so.2 .
cp /lib/i386-linux-gnu/lib{c,m}.so.6 . 

