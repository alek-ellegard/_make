include index.mk

rsync-caes:
	rm -rf ~/code/work/caes/_make
	rsync -av $(MK_DIR) ~/code/work/caes/
