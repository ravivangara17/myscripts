#!/bin/sh
EC2_ROOT=`dirname $0`
. $EC2_ROOT/exports.sh
chmod +x $EC2_ROOT/AutoScaling/bin/*
chmod -x $EC2_ROOT/AutoScaling/bin/*.cmd
chmod +x $EC2_ROOT/ELB/bin/*
chmod -x $EC2_ROOT/ELB/bin/*.cmd
chmod +x $EC2_ROOT/CloudWatch/bin/*
chmod -x $EC2_ROOT/CloudWatch/bin/*.cmd
chmod +x $EC2_ROOT/*.sh
