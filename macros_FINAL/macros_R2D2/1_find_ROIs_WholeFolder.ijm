
#@ File (label = "Input directory", style = "directory") input
suffix = ".czi" // !!! suffix (pripona obrazku)

processFolder(input); //volame function

function processFile(directory, imageName) {
	open(imageName);

	// NOVE VOLAME MAKRO PRO PRIPRAVU CERVENEHO KANALE
	runMacro("my_macros/pomocna_makra/red_channel_to_masks.ijm");
	
	//analyze particles
	run("Analyze Particles...", "size=7-100 circularity=0.50-1.00 exclude add stack");

	//TADY CHYBELO VYBRANI KOPIE CERVENEHO KANALE !!!
	selectWindow(getInfo("image.filename") + " - C=1-1");

	// REMOVE OVERLAPPIN MACRO CALL
	runMacro("my_macros/pomocna_makra/2_remove_overlapping_ROIs.ijm");
	
	roiManager("save", directory + "/" + imageName + "_raw_ROIs.zip");
	
	runMacro("my_macros/pomocna_makra/close_windows.ijm");
	
	//print("Processed: " + directory + File.separator + imageName);
}

function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);

// for (i = 0; i < 1; i++) {
for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], suffix)){
			processFile(input, list[i]);
		}
	}
}

