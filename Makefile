DATE = `date +'%Y%m%d'`

dummy:
	echo "true"

clean:
	rm ../nonfree-touchscreen-firmware-common_$(DATE)*.*; \
	rm -rf ../nonfree-touchscreen-firmware-common-$(DATE)

deb-pkg:
	./debian.sh
	rm -rf ../nonfree-touchscreen-firmware-common-*
