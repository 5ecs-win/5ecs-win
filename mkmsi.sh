#!/bin/sh
#######################################################
#			diff -Naru orig-file changed-file
#

	# just run it again .. without installing WiX.py etc
if [ -n "$1" ]
then
	export PATH=~/.local/bin:$PATH
	wix.py ~/5ecs/msi/5ecs-win-update.json
	ls -l /tmp/*msi
	exit 0
fi

cd /tmp
tar xzf - < ~/WiX.Py-0.1.tar.gz
cd /tmp/WiX.Py-0.1/utils
patch -u -b  dist.py -i ~/5ecs/wix-py.patch
cd ../scripts/py3
patch -u -b wix.py ~/5ecs/wix-py-1.patch
cd ../..
python3 -m pip install -e . --break-system-packages

export PATH=~/.local/bin:$PATH

cd /tmp/

mkdir /tmp/5ecs-win-update /tmp/dndcsc

cp ~/5ecs-win/5eCS.exe /tmp/5ecs-win-update

cp ~/5ecs/msi/*.ico /tmp/

vi ~/5ecs/msi/5ecs-win-update.json

wix.py ~/5ecs/msi/5ecs-win-update.json
