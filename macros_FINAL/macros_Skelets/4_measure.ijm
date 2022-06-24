

path = File.openDialog("Select image");
open(path);
imageDirectory = File.directory;
imageName =  File.nameWithoutExtension


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

//run("Clear Results");
//roiManager("reset");

//runMacro("my_macros/pomocna_makra/close_windows.ijm");