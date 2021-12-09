function colorTile(color) {
	switch (color) {
		case 0:
            return ("transparent");

		case 2:
			return ("#EDE1D7");

		case 4:
            return ("#F4D4A2");

		case 8:
			return ("#EEAE77");

		case 16:
			return ("#EB905E");
			
		case 32:
			return ("#F47858");

		case 64:
			return ("#F05B3A");

		case 128:
			return ("#EFCE73");

		case 256:
			return ("#EFCA63");

		case 512:
			return ("#ECBF4A");

		case 1024:
			return ("#EEC542");

		case 2048:
			return ("#EEC231");

		case 4096:
			return ("#6BCA10");

		case 8192:
			return ("#63BE08");

		case 16384:
			return ("#5ABA00");

		case 32768:
			return ("#52AA00");

		case 65536:
			return ("#4A8A10");

		case 131072:
			return ("#5A8AF7");
		
		default:
			return ("red");
			
	}

}
