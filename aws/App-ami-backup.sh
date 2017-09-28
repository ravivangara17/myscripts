#!/bin/bash
function testresult()
{
  if [ $? -eq 0 ] ; then
    echo "$1 Successful "
  else
    echo "$1 FAILED"
    exit 1
  fi
}


if [[ -a /mnt/img-mnt/image ]]; then
echo "removing previous backup files"
rm /mnt/img-mnt/image
rm /mnt/image
else
echo "No previous backups files"
fi

ec2-bundle-vol  -r i386 -d /mnt/img-mnt -k /root/pk-STABAGZM3ZBTECVYVHYTITSHBCYAE3KN.pem -c /root/cert-STABAGZM3ZBTECVYVHYTITSHBCYAE3KN.pem -u 722990294360
testresult BUNDLEVOLUME

ec2-upload-bundle -b quick-air-amis/app-server-new -m /mnt/img-mnt/image.manifest.xml   -a XXXXXXXX -s YYYYYYYYYY

testresult UPLOADBUNDLE


#ec2-register --name "quick-air-amis/lamt-server-new/image"  quick-air-amis/lamt-server-new/image.manifest.xml
#ec2-deregister ami-XXX
#Delete the AMI bundle in S3:
#ec2-delete-bundle   --access-key $AWS_ACCESS_KEY_ID   --secret-key $AWS_SECRET__KEY   --bucket $bucket   --prefix $prefix
#(bucket = -b option - quick-air-amis/app-server-new , PREFIX = image )
