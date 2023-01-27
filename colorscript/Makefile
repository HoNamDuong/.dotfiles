clean: 
	rm -rf /opt/colorscript

install: clean
	mkdir -p /opt/colorscript/colorscripts
	cp -rf colorscripts/* /opt/colorscript/colorscripts
	cp colorscript.sh /usr/local/bin/colorscript

uninstall:
	rm -rf /opt/colorscript
	rm -f /usr/local/bin/colorscript
