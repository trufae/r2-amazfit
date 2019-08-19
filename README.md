Amazfit BIP r2versing
=====================

The main specs of the device are: 

	CPU: STM32L476JEY6 (this is ARM Cortex M4 with FPU)
	Details: Core: Arm® 32-bit Cortex®-M4 CPU with FPU,
		 Adaptive real-time accelerator (ART Accelerator™)
		 Allowing 0-wait-state execution from Flash memory,
		 Frequency up to 80 MHz, MPU
		 100DMIPS and DSP instructions
	Battery: 190mAh
	Memory: 128KB SRAM + 32KB hw parity check
	Storage: 1MB Flash


Its peripherals and devices:

* PPG heart rate sensor
* Triaxial acceleration sensor
* Geomagnetic sensor
* Barometric pressure sensor
* Bluetooth 4.0
* Sony 28nm GPS + Glonass Dual Core positioning

0000 is the boot memory, which might be Flash, ROM or SRAM
0800 is Flash
2000 is SRAM
1000 on some chips in TCRAM, which is faster for data but cannot be used for DMA or code.
4000 is ROM, I think.
E000 is IO, I think.



And the internal photos from the FCCID (2AC8UA1608):

https://fccid.io/2AC8UA1608/Internal-Photos/Internal-photos-3492001

At least for the device we are examining, there's other form factors, revisions and models: round and square shapes, some model's components are mostly populated on one side leaving the other side for test points. The model under this analysis has a high integration factor so there's barely any PCB real state left in the board. That makes JTAG probing more interesting, but we can get most of what we need from static analysis alone.

Other hobbyists have performed teardowns of the device, mostly for repair purposes. The photos are a bit higher quality and some of the IC markings are more visible, facilitating the examination of possible interconnects:

https://forum.xda-developers.com/smartwatch/amazfit/bip-teardown-pcb-close-ups-hardware-t3830395

For instance, there's a Winbond external flash memory we should be aware of when examining write addresses in the firmware:

https://www.winbond.com/resource-files/w25q64fw_revk%2007012016%20sfdp.pdf

The flash size of this IC is quite oversized for the amount of bytes needed to run the firmware and assets, but in this way, the manufacturer has enough space for possibly bulkier future upgrades.

Memory Layout
-------------
STM32L476xx devices feature up to 128 Kbyte of embedded SRAM. This SRAM is split into two blocks:

* 96 Kbyte mapped at address 0x2000.0000 (SRAM1)
* 32 Kbyte located at address 0x1000.0000 with hardware parity check (SRAM2).

And then the flash memory is divided as such:

* 2KB pages at 0x0800.0000 - 0x0808.ffff Flash main memory

Information Block (bank1+bank2)

* 2KB pages at 0x8fff.0000 - 0x1fff.6fff Page 511
* 28KB pages at 0x1fff.7000 - 0x1fff.73ff System Memory
* 28KB pages at 0x1fff.7800 - 0x1fff.f80f OTP Area
* 28KB pages at 0x1fff.f800 - 0x1fff.f80f Option bytes

Main memory 

* 256/512/1MB dual bank flash memory

* 0x0800.0000 - 0x0807.ffff pages from 0 to 511

Firewall (memory protection)

* Code segment located in flash or sram1 (executable + read-only)
* Non-volatile data (flash)
* Volateile data segment (sram1)

The start address and length of each segment is configurable

* Code segment up to 1024KB 256 bytes of granularity 
* Volatile data segment up to 96 KB of granularity of 64 bytes

Boot modes

* Boot from flash, system memory or embedded SRAM

Firmware
--------

* mifit.apk/assets/Mili_chaohu.fw

See also
--------

* https://github.com/olegv142/STM32L4SpecMon
