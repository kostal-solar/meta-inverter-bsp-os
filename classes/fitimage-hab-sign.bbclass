# classes/fitimage-hab-sign.bbclass
# dummy class for non-signed images
# 
# Licence: same as meta-inverter-bsp

kernel_do_deploy_append() {
    echo "1" >> /tmp/dummy
	bbwarn "HAB sign not implemented."
}