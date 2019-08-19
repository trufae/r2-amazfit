all:
	r2 -e anal.hasnext=true -e anal.strings=true -i r2/project.r2 -a arm -b 16 -e asm.cpu=cortex -m 0x20000000 -c "aac" fw/354/Mili_chaohu.fw
