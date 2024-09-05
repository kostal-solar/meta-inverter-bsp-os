Setup for build
---------------

Please use the *kas* tool (https://github.com/siemens/kas) to setup the repos
and the configuration.

You can use with :

	kas shell doc/project.yml

The required repos will be downloaded and set and the project will be configured.
You can start working with `bitbake`.

Build the image
---------------

	bitbake kie-image-base

Install bootloader on board
---------------------------

This uses the imx_usb_loader tool. 

1. Start the Board in SDP mode
..............................

An empty board runs automatically in SDP mode. You can force the SDp on a bricked board
with a bootloader on the eMMC by shortcutting the TP 1204 and TP 1205.

Connect a USB-OTG adapter (see picture) to your host. Run `lsusb` on the host, the inverter should be listed as
Freescale Device:

	Bus 005 Device 020: ID 15a2:0080 Freescale Semiconductor, Inc. USB2.0 Hub

2. Go into the deploy directory
-------------------------------

Go into build/tmp/deploy/images/mx6ul-kie-inverter

3. Install SPL
--------------

	sudo ~/Projects/imx_usb_loader/imx_usb SPL

if it runs, you get something like this on the output:

	config file </home/stefano/Projects/imx_usb_loader//imx_usb.conf>
	vid=0x066f pid=0x3780 file_name=mx23_usb_work.conf
	vid=0x15a2 pid=0x004f file_name=mx28_usb_work.conf
	vid=0x15a2 pid=0x0052 file_name=mx50_usb_work.conf
	vid=0x15a2 pid=0x0054 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0061 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0063 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0071 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x007d file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0080 file_name=mx6_usb_work.conf
	vid=0x1fc9 pid=0x0128 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0076 file_name=mx7_usb_work.conf
	vid=0x1fc9 pid=0x0126 file_name=mx7ulp_usb_work.conf
	vid=0x15a2 pid=0x0041 file_name=mx51_usb_work.conf
	vid=0x15a2 pid=0x004e file_name=mx53_usb_work.conf
	vid=0x15a2 pid=0x006a file_name=vybrid_usb_work.conf
	vid=0x066f pid=0x37ff file_name=linux_gadget.conf
	vid=0x1b67 pid=0x4fff file_name=mx6_usb_sdp_spl.conf
	vid=0x0525 pid=0xb4a4 file_name=mx6_usb_sdp_spl.conf
	vid=0x0525 pid=0xa4a5 file_name=mx6_usb_sdp_spl.conf
	vid=0x1b67 pid=0x5ffe file_name=mx6_usb_sdp_spl.conf
	config file </home/stefano/Projects/imx_usb_loader//mx6_usb_work.conf>
	parse /home/stefano/Projects/imx_usb_loader//mx6_usb_work.conf
	Trying to open device vid=0x15a2 pid=0x0080
	Interface 0 claimed
	HAB security state: development mode (0x56787856)
	== work item
	filename SPL
	load_size 0 bytes
	load_addr 0x00000000
	dcd 1
	clear_dcd 0
	plug 1
	jump_mode 2
	jump_addr 0x00000000
	== end work item
	No dcd table, barker=402000d1

	loading binary file(SPL) to 00907400, skip=0, fsize=ac00 type=aa

	<<<44032, 44032 bytes>>>
	succeeded (status 0x88888888)
	jumping to 0x00907400

On the console, you will get the output from SPL, waiting for u-boot.img:


	U-Boot SPL 2020.07-rc4 (Jun 09 2020 - 00:30:26 +0000)
	Trying to boot from USB SDP
	SDP: initialize...
	SDP: handle requests...

4. Load u-boot.img
------------------

	sudo ~/Projects/imx_usb_loader/imx_usb u-boot-ivt.img

The output of the command will lokk like as:

	config file </home/stefano/Projects/imx_usb_loader//imx_usb.conf>
	vid=0x066f pid=0x3780 file_name=mx23_usb_work.conf
	vid=0x15a2 pid=0x004f file_name=mx28_usb_work.conf
	vid=0x15a2 pid=0x0052 file_name=mx50_usb_work.conf
	vid=0x15a2 pid=0x0054 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0061 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0063 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0071 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x007d file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0080 file_name=mx6_usb_work.conf
	vid=0x1fc9 pid=0x0128 file_name=mx6_usb_work.conf
	vid=0x15a2 pid=0x0076 file_name=mx7_usb_work.conf
	vid=0x1fc9 pid=0x0126 file_name=mx7ulp_usb_work.conf
	vid=0x15a2 pid=0x0041 file_name=mx51_usb_work.conf
	vid=0x15a2 pid=0x004e file_name=mx53_usb_work.conf
	vid=0x15a2 pid=0x006a file_name=vybrid_usb_work.conf
	vid=0x066f pid=0x37ff file_name=linux_gadget.conf
	vid=0x1b67 pid=0x4fff file_name=mx6_usb_sdp_spl.conf
	vid=0x0525 pid=0xb4a4 file_name=mx6_usb_sdp_spl.conf
	vid=0x0525 pid=0xa4a5 file_name=mx6_usb_sdp_spl.conf
	vid=0x1b67 pid=0x5ffe file_name=mx6_usb_sdp_spl.conf
	config file </home/stefano/Projects/imx_usb_loader//mx6_usb_sdp_spl.conf>
	parse /home/stefano/Projects/imx_usb_loader//mx6_usb_sdp_spl.conf
	Trying to open device vid=0x0525 pid=0xb4a4
	Interface 0 claimed
	HAB security state: development mode (0x56787856)
	== work item
	filename u-boot-ivt.img
	load_size 0 bytes
	load_addr 0x00000000
	dcd 1
	clear_dcd 0
	plug 1
	jump_mode 2
	jump_addr 0x00000000
	== end work item

	loading binary file(u-boot-ivt.img) to 877fffc0, skip=0, fsize=69020 type=aa

	<<<430112, 431104 bytes>>>
	succeeded (status 0x88888888)
	jumping to 0x877fffc0


On the console, you will get the U-Boot shell:

	Downloading file of size 430112 to 0x877fffc0... done
	Jumping to header at 0x877fffc0
	Header Tag is not an IMX image
	hab fuse not enabled


	U-Boot 2020.07-rc4 (Jun 09 2020 - 00:30:26 +0000)

	CPU:   Freescale i.MX6ULL rev1.1 792 MHz (running at 396 MHz)
	CPU:   Industrial temperature grade (-40C to 105C) at 50C
	Reset cause: POR
	Model: Kostal KIE imx6 Ultra Lite Inverter
	Board: Kostal KIE inverter-i.MX6ULL
	DRAM:  512 MiB
	MMC:   FSL_SDHC: 0
	Loading Environment from MMC... OK
	In:    serial@2020000
	Out:   serial@2020000
	Err:   serial@2020000
	Net:   eth0: ethernet@20b4000
	Hit any key to stop autoboot:  0 
	=> 

Note : bootloader is now running on RAm. You have to flash it to eMMC with 
U-Boot.

Debrick the 'inverter' board with 'uuu' utility
-----------------------------------------------

cat <<- EOF >> kostal_imx6ull.lst
uuu_version 1.3.0
SDP: boot -f /srv/tftp/kostal/SPL
SDPU: write -f /srv/tftp/kostal/u-boot-ivt.img -addr 0x877fffc0
SDPU: jump -addr 0x877fffc0
SDPU: done
EOF

Then on the host PC
./uuu -lsusb
sudo ./uuu kostal_imx6ull.lst

Copying Bootloader into eMMC
----------------------------

After U-Boot is running, you need to copy it to eMMC. First copy SPL and u-boot-ivt.img
to a USB stick. Insert the stick into the board, and from the U-Boot shell:

	usb start

You get:

	starting USB...
	Bus usb@2184000: USB EHCI 1.00
	Bus usb@2184200: USB EHCI 1.00
	scanning bus usb@2184000 for devices... 1 USB Device(s) found
	scanning bus usb@2184200 for devices... 2 USB Device(s) found
        scanning usb for storage devices... 1 Storage Device(s) found

Let's say your files are on the first partition on USB. Then:

	ls usb 0:1 

	=> ls usb 0:1
	  9703736   fitImage
	   490442   u-boot-with-spl.imx
	    44032   SPL
	   430112   u-boot-ivt.img
	   293108   ethtool
	 16181652   rescue-initramfs-mx6ul-kie-inverter.itb
	 73871360   kie-image-base-mx6ul-kie-inverter.ext4

	7 file(s), 0 dir(s)


Your files should be in the list. Then:

    load usb 0:1 ${loadaddr} SPL
    setexpr fw_sz ${filesize} / 0x200
    setexpr fw_sz ${fw_sz} + 1
    mmc write ${loadaddr} 2 ${fw_sz}
    load usb 0:1 ${loadaddr} u-boot-ivt.img
    setexpr fw_sz ${filesize} / 0x200
    setexpr fw_sz ${fw_sz} + 1
    mmc write ${loadaddr} 8a ${fw_sz}

Defalt environment has an "update_uboot" script that contains these commands. It does not check
if an image was successfully loaded, so be careful before resetting the board. Then
a "run update_uboot" will load and update the bootloader. Please consider that
the environment remains unchanged after an update. To load the new default environment,
the procedure is the following:

	run update_uboot
	reset
	env default -f -a
	saveenv

Note: u-boot-ivt.img should be less that 512KB (400 in the last line).

U-Boot is now on the board, you have to burn the fuses before resetting.


Setting eFuses to boot from eMMC
--------------------------------

Two fuses must be burned to boot automatically from eMMC. Warning: burning the fuses
is a one-way operation. It is not possible to set the fuses again to the original status.
If wrong values are burned, the board is broken.

	fuse prog -y 0 5 0x4860
	fuse prog -y 0 6 0x10


Setting eFuses for MAC Address
------------------------------

The fuses for MAC are om bank 4, with the 32 lsbs in word 2 and the
16 msbs in word 3[15:0]. The second MAC address
is stored in fuse bank 4, with the 16 lsb in word 3[31:16] and the 32 msbs in
word 4. Kostal MAC Address prefix is 24:0B::B1 (MSB part of MAC).

For example, if you have reserved these two MAC Addresses:

	eth0 24:0B:B1:42:7E:90
	eth1 24:0B:B1:42:7E:91

You can program with:

	=> fuse prog -y 4 2 0xB1427e90
	Programming bank 4 word 0x00000002 to 0xb1427e90...

	=> fuse prog -y 4 3 0x7e91240b
	Programming bank 4 word 0x00000003 to 0x7e91240b...
	=> fuse prog -y 4 4 0x240bb142
	Programming bank 4 word 0x00000004 to 0x240bb142...

After then, power-cycle the board.


First install Software / Linux
------------------------------

The only requirement is to have installed U-Boot with the default environment. Run

	env default -f -a
	saveenv

to be sure that default environment is used.

Prepare a rescue image:

	DISTRO=poky bitbake rescue-initramfs

This creates a rescue-initramfs-mx6ul-kie-inverter.itb in deploy directory.
Copy it on a USB stick and attach it to the board.
The environment has a "swupdate_usb" script, and you can run it. Board comes up
with a rescue system and network (if DHCP is available) running.

Prepare the update package (SWU):

	bitbake kie-image-base-swu

The result is a SWU file in deploy directory.

Connect to the board with a browser, http://<ip address of board>:8080. Download the SWU
to the board: if everything is correct, SWUpdate will partition the eMMC, install the image
and set the environment to boot next time from eMMC. At the end, restart the board.

Dunfell setup of 'inverter' board (with 88E6020 and 88W8801)
------------------------------------------------------------
------------------------------------------------------------

Update U-Boot:
--------------

Via TFTP, USB pen drive, USB cable connected to PC (imx_usb utility):

	https://github.com/toradex/imx_loader.git
	SHA1: 30b43d69770cd69e84c045dc9dcabb1f3e9d97

```
> reboot
> env default -a
> setenv serverip 192.168.0.1
> saveenv
> saveenv
```

To update the rootfs image on the 'inverter' board:
---------------------------------------------------

Creating image (SWUpdate one) to be flashed:

```
bitbake kie-image-base -c cleansstate && \
bitbake kie-image-base-swu -c cleansstate && \
bitbake linux-stable -c cleansstate && \
bitbake kie-image-base-swu1
```


The build/tmp/deploy/images/mx6ul-kie-inverter/kie-image-base-swu-mx6ul-kie-inverter.swu
image shall be built.

Please also build: rescue-initramfs-mx6ul-kie-inverter.itb with
```
DISTRO=poky bitbake rescue-initramfs -c cleansstate && \
DISTRO=poky bitbake rescue-initramfs
```

Please put those two files to USB (or use tftp) [*]

After reboot:
1. Either use 'run swupdate_usb' or
2. 'run swupdate_tftp'

After loging in, please check the IP address on lan1 (192.168.0.10).
In your HOST browser type: http://192.168.0.10:8080/
And download the kie-image-base-swu-mx6ul-kie-inverter.swu

Wi-Fi AW-NM191 (88W8801) testing scenario:
------------------------------------------
```
iperf3 -s
iperf3 -i 2 -c 192.168.2.222 -P 8 -t 10800 -w 32768
```


Secure 'inverter' board (transition from development):
------------------------------------------------------

1. Setup the 'boot0' eMMC HW partition as the one for booting
```
=> mmc partconf 0 0 1 0
=> mmc partconf 0
```
EXT_CSD[179], PARTITION_CONFIG:
BOOT_ACK: 0x0
BOOT_PARTITION_ENABLE: 0x1
PARTITION_ACCESS: 0x0

(The PARTITION_CONFIG = 0x08)

Which means
EXT_CSD -> BOOT_ACK [6] = 0 (NO ACK during boot)

as in
```
=> md.l 0x20D8004 1
020d8004: 00004860 -> eMMC SDHC2, 8-bit
```
BOOT_CFG1, bit 4 = 0, so we do have "Regular" (i.e. no fast)
boot and ACK is not required (bit 2 only is considered when bit 4=1).


2. Write u-boot to it:
```
=> run net_update_uboot
```

3. Now the GPT will not override the SPL

Secure 'inverter' board:
========================

Signed *.swu IMAGES (kie-image-base-swu) with SWUpdate:
-------------------------------------------------------

1. Generate public and private keys (as described [1])
```
cd meta-inverter-bsp/build/keys/conf/swu
echo "XXXX" > inverter_pki_priv.pass
openssl genrsa -aes256 -passout file:inverter_pki_priv.pass -out inverter_pki_priv.pem
openssl rsa -in inverter_pki_priv.pem -out inverter_pki_public.pem -outform PEM -pubout
```

The inverter_pki_priv.pass is stored as a plain text, so it shall be protected.

2. After the CONFIG_SIGNED_IMAGES in SWUpdates configuration is enabled - the swupdate
REQUIRES -k <public key file> switch to be provided. Otherwise it will return error.

Links:
[1] - https://sbabic.github.io/swupdate/signed_images.html#usage-with-rsa-pkcs-1-5-or-rsa-pss


Factory setup:
==============

0. The 'inveter' PCB board will come from the production
with eMMC pre-programmed with `SPL-emmc.signed` and
`u-boot-ivt.img-emmc.signed` (also including the u-boot envs
stored in /dev/mmcblk1boot1)
Moreover, the boot configuration gpios will allow booting
directly from the eMMC.

**Important**
The eMMC shall be configured to boot from /dev/mmcblk1boot0
HW partition (**NOT** user eMMC area).
The eMMC shall be programmed by the manufacturer to have
`BOOT_PARTITION_ENABLE: 0x1` (as presented above).

1. Provide encryption key to `meta-inverter-bsp` - based on:
https://source.denx.de/denx/meta-secure-imx/-/blob/dunfell/README.md

  - HAB support in the BSP

Please use the NXP's CST tool (in my case cst-3.1.0.tgz):
https://source.denx.de/denx/meta-secure-imx/-/blob/dunfell/README.md#nxp-signing-tool-cst

Please add following code to local.conf:
```
# HAB Settings
HAB_ENABLE= "1"
HAB_BASE ?= "${TOPDIR}/keys"
HAB_DIR ?= "${HAB_BASE}/conf/hab"
SRKTAB ?= "${HAB_DIR}/crts/SRK_1_2_3_4_table.bin"
CSFK ?= "${HAB_DIR}/crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem"
SIGN_CERT ?= "${HAB_DIR}/crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem"
```

and place followng files into `build/keys/conf/hab/crts`:
```
CA1_sha256_4096_65537_v3_ca_crt.der
CSF2_1_sha256_4096_65537_v3_usr_crt.pem
IMG1_1_sha256_4096_65537_v3_usr_crt.der
IMG3_1_sha256_4096_65537_v3_usr_crt.pem
SRK1_sha256_4096_65537_v3_ca_crt.der
SRK3_sha256_4096_65537_v3_ca_crt.pem
CA1_sha256_4096_65537_v3_ca_crt.pem
CSF3_1_sha256_4096_65537_v3_usr_crt.der
IMG1_1_sha256_4096_65537_v3_usr_crt.pem
IMG4_1_sha256_4096_65537_v3_usr_crt.der
SRK1_sha256_4096_65537_v3_ca_crt.pem
SRK4_sha256_4096_65537_v3_ca_crt.der
CSF1_1_sha256_4096_65537_v3_usr_crt.der
CSF3_1_sha256_4096_65537_v3_usr_crt.pem
IMG2_1_sha256_4096_65537_v3_usr_crt.der
IMG4_1_sha256_4096_65537_v3_usr_crt.pem
SRK2_sha256_4096_65537_v3_ca_crt.der
SRK4_sha256_4096_65537_v3_ca_crt.pem
CSF1_1_sha256_4096_65537_v3_usr_crt.pem
CSF4_1_sha256_4096_65537_v3_usr_crt.der
IMG2_1_sha256_4096_65537_v3_usr_crt.pem
SRK_1_2_3_4_fuse.bin
SRK2_sha256_4096_65537_v3_ca_crt.pem
CSF2_1_sha256_4096_65537_v3_usr_crt.der
CSF4_1_sha256_4096_65537_v3_usr_crt.pem
IMG3_1_sha256_4096_65537_v3_usr_crt.der
SRK_1_2_3_4_table.bin
SRK3_sha256_4096_65537_v3_ca_crt.der
```

  - Encryption AES-128-GCM key for rootfs


The `ENC_KEY_RAW` variable shall be defined in local.conf as described here:
https://source.denx.de/denx/meta-secure-imx/-/blob/dunfell/README.md#raw-key-definitions


2. Build the factory image:
```
bitbake crypt-image-initramfs -c cleansstate &&
bitbake initramfs-init -c cleansstate &&
bitbake factory-image-fit
```

3. Please build the SWUpdate image `kie-image-base-swu-mx6ul-kie-inverter.swu`
First, one needs to follow steps from "Signed *.swu IMAGES (kie-image-base-swu)
with SWUpdate:" to provide RSA public/private keys to sign *.swu file.

4. Build the rescue image `rescue-initramfs-mx6ul-kie-inverter.itb.signed`
```
DISTRO=poky bitbake rescue-initramfs -c cleansstate &&
DISTRO=poky bitbake rescue-initramfs
```

and place it into the USB memory (it will have public key to check *swu file
signature in its rootfs).

5. Place the factory initramfs image (factory-image-fit.itb.signed) in the tftp
exported directory. Please pay attention to the ".signed" suffix - it indicates
that the image is eligible for HAB verification.

6. Power up the board with pressing 'X' and '<' keys on the display pannel,
the factory initramfs is downloaded via tftp and executed.

7. It then downloads and programs:
  - MAC address from tftp accessible `imx6ull-inverter-mac.txt`
  - SRK from tftp accessible `SRK_1_2_3_4_fuse.bin`
  - create rootfs encryption blob - it needs to download (temporarily only)
	the `imx6ull-inverter-rootfs-enc-key.txt` with encryption key (it is the same
	as one passed to `ENC_KEY_RAW` and will **NOT** be stored on the `inverter`
	board)
  - enable secure booting (a.k.a locking the board) -> PERMANENT
  - sets the eMMC boot areas as RO (read only) -> PERMANENT.

8. After reboot one needs to press 'OK' and '>' keys on the display pannel,
   so the rescue image is executed (here also the image's HAB signature is
   checked).

9. The SWUpdate is started - one needs to check the board's IP address
   (for example it would be 192.168.0.8).

10. On the host web browser type: `http://192.168.0.8:8080/` and navigate to
	*.swu image.

11. Setting up board by SWUpdate (this step will be omitted when the eMMC
	'user' area is going to be programmed by the eMMC manufacturer):

  - Checking if the image signature is correct (with PKI)
  - Creating the GPT partition on eMMC's user HW partition
  - Formatting partitions where kernel's fitImage is stored
  - Flash the encrypted roofs images

12. Power cycle the board


**NOTE**
--------

The factory image (`factory-image-fit.itb.signed`):

- By default will try to fuse the inverter board. However, it will break the
process when required files (with e.g. MAC address data) are not present.

- The eMMC is programmed as RO, but **ONLY** till the power cycle of the board.
As this change is permanent one needs to apply following patch to the
`meta-inverter-bsp`:
`doc/0001-mmc-boot-ro-Set-the-eMMC-boot-aread-as-RO-PERMANENT.patch`
