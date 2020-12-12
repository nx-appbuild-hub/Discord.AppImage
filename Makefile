# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)


all: clean

	mkdir --parents $(PWD)/build/Boilerplate.AppDir/discord
	apprepo --destination=$(PWD)/build appdir boilerplate libatk1.0-0 libatk-bridge2.0-0 libgtk-3-0
	echo "LD_LIBRARY_PATH=\$${LD_LIBRARY_PATH}:\$${APPDIR}/discord" >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "export LD_LIBRARY_PATH=\$${LD_LIBRARY_PATH}" >> $(PWD)/build/Boilerplate.AppDir/AppRun
	echo "exec \$${APPDIR}/discord/Discord \"\$${@}\"" >> $(PWD)/build/Boilerplate.AppDir/AppRun


	wget --output-document="$(PWD)/build/build.deb" "https://discord.com/api/download?platform=linux&format=deb"
	dpkg -x $(PWD)/build/build.deb $(PWD)/build

	cp --force --recursive $(PWD)/build/usr/share/discord*/* $(PWD)/build/Boilerplate.AppDir/discord

	rm --force $(PWD)/build/Boilerplate.AppDir/*.desktop

	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Boilerplate.AppDir/
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Boilerplate.AppDir/ || true
	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Boilerplate.AppDir/ || true

	export ARCH=x86_64 && $(PWD)/bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Discord.AppImage
	chmod +x $(PWD)/Discord.AppImage

clean:
	rm -rf $(PWD)/build