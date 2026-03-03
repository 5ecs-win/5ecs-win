#!/bin/sh
######################################################

cd /tmp/tmp

for s in `cat ~/5ecs/2024-spells.txt`
do
	fn=`basename $s`
	wget -q -O ${fn}-2024 $s
	echo -e "<html>\n<body>" > /tmp/sdc/${fn}-2024.html
	grep "<h1>" ${fn}-2024 | sed "s?<strong>?</p><strong>?g" >> /tmp/sdc/${fn}-2024.html
	echo -e "</html>\n</body>" >> /tmp/sdc/${fn}-2024.html
done
