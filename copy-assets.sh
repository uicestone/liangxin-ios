PROJECT=$PWD
DIRS=`find $HOME/Library/Developer/CoreSimulator/Devices/ -name Liangxin.app`
for DIR in $DIRS
do
	echo "cp -R $PROJECT $DIR"
	cp -R $PROJECT $DIR
done