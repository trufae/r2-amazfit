om-*
# om 3 0 $s 0x00000440 rwx

f entry0=0x20000000
om 3 entry0 $s 0x440 rwx

e anal.hasnext=true
e anal.strings=true
e asm.arch=arm
e asm.bits=16
e asm.cpu=cortex

e anal.verbose=false
aac
aae
f~str?
s entry0
