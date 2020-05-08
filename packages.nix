{ pkgs , ... }:

{

	programs.cdemu.enable = true;

	environment.systemPackages = with pkgs; [
		xboxdrv
		git-cola
		firefox
		steam
		mumble
		htop
		gimp
		git
		multimc
		lutris
		godot
		discord
		screenfetch
		protontricks
		winetricks
		mono
		SDL2
		libvorbis
		expat
		flameshot
		atom
		steam-run-native
		(steam.override { extraPkgs = pkgs: [ mono gtk3 gtk3-x11 libgdiplus zlib ]; nativeOnly = true; }).run
		synergy
		quicksynergy
		blender
		ark
		unrar
		dosbox
		clementine
		kdeconnect
		jre
		nestopia
	];
}
