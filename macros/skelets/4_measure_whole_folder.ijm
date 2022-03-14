#@ File (label = "Input directory", style = "directory") input

processFolder(input); //volame function

function measureImage(path){
	
	open(path);
	imageDirectory = File.directory;
	imageName =  File.nameWithoutExtension;
	
	selectedRoisFilePath = imageDirectory + imageName + "_selected_ROIs.zip";
	if(File.exists(selectedRoisFilePath)){
		roiManager("open", selectedRoisFilePath);
		
		for (i = 0; i < roiManager("count"); i++) {
			//measure ROI
			roiManager("select", i);
			run("Measure");
	
			//measure line
			roiManager("select", i);
			run("Line Width...", "line=2");
			run("Area to Line");
			run("Measure");
		}
		
		saveAs("Results", imageDirectory + "/" + imageName +"_selected.csv");

		
	}else{
		Dialog.create("Selected ROIs file not found!");
		Dialog.addMessage("Selected ROIs file for image: "+ imageName+ " NOT FOUND! Ty KoXo!!!");
		Dialog.show();
	}
}

function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);

// for (i = 0; i < 1; i++) {
	for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], ".czi") || endsWith(list[i], ".tif")){
			measureImage(input+"\\"+ list[i]);
			close("*");

			run("Clear Results");

			roiManager("reset");

		}
	}
}
