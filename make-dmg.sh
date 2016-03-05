#!/bin/bash

WORKDIR=MPlayerX

if [[ -e ${WORKDIR}/MPlayerX.app ]]; then

	echo "===============re-codesign the installer==============="
	codesign --force -s "Developer ID Application: Zongyao Qu" -v ${WORKDIR}/MPlayerX.app/Contents/bin/AssetsChanger
	echo ""
	codesign --force -s "Developer ID Application: Zongyao Qu" -v ${WORKDIR}/MPlayerX.app
	echo ""

	echo "===============check the result==============="
	codesign -dvvv ${WORKDIR}/MPlayerX.app/Contents/bin/AssetsChanger
	echo
	codesign -dvvv ${WORKDIR}/MPlayerX.app
	echo
	spctl --verbose=4 --assess --type execute ${WORKDIR}/MPlayerX.app
	echo ""

	echo "===============Make the DMG==============="
	./create-dmg --volname MPlayerX --background resources/dmg_background.jpg  --window-size 548 455 --icon-size 128 --icon MPlayerX 274 227 MPlayerX.dmg ${WORKDIR}/	
else 
	echo "installer app does not exist."
	exit 1
fi

