#!/bin/bash
PATH=$PATH:/root/ec2apitools/bin
ec2-create-snapshot -K /root/pk-STABAGZM3ZBTECVYVHYTITSHBCYAE3KN.pem -C /root/cert-STABAGZM3ZBTECVYVHYTITSHBCYAE3KN.pem vol-7555a31c
