SOURCE="https://dl.discordapp.net/apps/linux/0.0.10/discord-0.0.10.deb"
DESTINATION="build.deb"
OUTPUT="Discord.AppImage"


all:
	echo "Building: $(OUTPUT)"
	wget -O $(DESTINATION) -c $(SOURCE)

	dpkg -x $(DESTINATION) build
	rm -rf AppDir/opt

	mkdir --parents AppDir/opt/application
	cp -r build/usr/share/discord/* AppDir/opt/application

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)

	chmod +x $(OUTPUT)

	rm -f $(DESTINATION)
	rm -rf AppDir/opt
	rm -rf build
