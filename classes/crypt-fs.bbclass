# bbclass to take care of generating crypted FS image

inherit image_types

CONVERSION_CMD_crypt(){
	echo "2" >> /tmp/dummy
}
