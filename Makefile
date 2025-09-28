include index.mk

rsync-caes:
	rm -rf ~/code/work/caes/_make
	rsync -av $(MK_PATH) ~/code/work/caes/
