#! /bin/bash
echo "Started the script"
while sleep $INTERVAL
do
  echo "Clicking an image"

  cur_time=`date +'%r'`
  /opt/vc/bin/raspistill -o /home/pi/images/image.jpg
  echo "Clicked image at $cur_time"xd
  curl -X POST -F 'image=@/home/pi/images/image.jpg' $EGRESS_API_HOST
done