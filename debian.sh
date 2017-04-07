#! /bin/sh
# Configure your paths and filenames
SOURCEBINPATH=.
FWFOLDER=fw
SOURCEDOC=README.md
DEBFOLDER=nonfree-touchscreen-firmware-common
DEBVERSION=$(date +%Y%m%d)

if [ -n "$BASH_VERSION" ]; then
	TOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
else
	TOME=$( cd "$( dirname "$0" )" && pwd )
fi
cd $TOME

git pull origin master

DEBFOLDERNAME="$TOME/../$DEBFOLDER-$DEBVERSION"

# Create your scripts source dir
mkdir $DEBFOLDERNAME

# Copy your script to the source dir
cp $TOME $DEBFOLDERNAME -R
cd $DEBFOLDERNAME

# Create the packaging skeleton (debian/*)
dh_make --indep --createorig


# Remove make calls
grep -v makefile debian/rules > debian/rules.new
mv debian/rules.new debian/rules

# debian/install must contain the list of scripts to install
# as well as the target directory
echo $SOURCEDOC usr/share/doc/$DEBFOLDER >> debian/install

for file in $(find . -name *.fw); do
        echo $file lib/firmware | tee -a debian/install
        echo $file | sed 's|./||'| tee -a debian/source/include-binaries
done

# Remove the example files
rm debian/*.ex
dpkg-source --commit
# Build the package.
# You  will get a lot of warnings and ../somescripts_0.1-1_i386.deb
debuild -us -uc
