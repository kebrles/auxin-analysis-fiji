#@ File (label = "Input directory", style = "directory") input
suffix = ".czi" // !!! suffix (pripona obrazku)

processFolder(input); //volame function

function measureImage(imageName){

	open(imageName);
	
	// define channel names
	imageDirectory = getDirectory("current");
	imageName = getInfo("image.filename");

	redChannelName = imageName + " - C=1";
	greenChannelName = imageName + " - C=0";
	
	// close white channel
	selectWindow(imageName + " - C=2");
	close();
	

	//TODO change "_raw_ROIs.zip" to "_reviewed_ROIs.zip" ;-)
	roisFilePath = imageDirectory + imageName+"_selected_ROIs_cells.zip";
	print(roisFilePath);
	if(File.exists(roisFilePath)){
		roiManager("open", roisFilePath);
		selectWindow(redChannelName);
		roiManager("Measure");
		saveAs("Results", imageDirectory + "/" + imageName+"_selected_RED_cells.csv");
		run("Clear Results");
	
		// measure and save green channel
		selectWindow(greenChannelName);
		roiManager("Measure");
		saveAs("Results", imageDirectory + "/" + imageName+"_selected_GREEN_cells.csv");



	}else{
		Dialog.create("ROIs file not found!");
		Dialog.addMessage("ROIs file for image: "+ imageName+ " NOT FOUND! Ty KoXo!!!");
		Dialog.show();
	}
	runMacro("my_macros/pomocna_makra/close_windows.ijm");
}


function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);

// for (i = 0; i < 1; i++) {
	for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], suffix)){
			measureImage(list[i]);
		}
	}
}