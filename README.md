Amazfit BIP r2versing
=====================

	CPU: Mediatek STM32L476JEY6 (this is ARM Cortex M4 with FPU)
	Details: Core: Arm® 32-bit Cortex®-M4 CPU with FPU,
		 Adaptive real-time accelerator (ART Accelerator™)
		 Allowing 0-wait-state execution from Flash memory,
		 Frequency up to 80 MHz, MPU
		 100DMIPS and DSP instructions
	Battery: 190mAh
	Memory: 128KB SRAM + 32KB hw parity check
	Storage: 1MB Flash


Peripherals/Devices:

* PPG heart rate sensor
* Triaxial acceleration sensor
* Geomagnetic sensor
* Barometric pressure sensor
* Bluetooth 4.0
* Sony 28nm GPS + Glonass Dual Core positioning

Memory Layout
-------------
STM32L476xx devices feature up to 128 Kbyte of embedded SRAM. This SRAM is split into two blocks:

* 96 Kbyte mapped at address 0x2000.0000 (SRAM1)
* 32 Kbyte located at address 0x1000.0000 with hardware parity check (SRAM2).
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
