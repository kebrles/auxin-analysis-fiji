#@ File (label = "Input directory", style = "directory") input

processFolder(input); //volame function

function processFile(path){

	open(path);
	imageDirectory = File.getDirectory(path);
	imageName = File.nameWithoutExtension;
	
	skeletonFolder = imageDirectory + "/skeleton/";
	
	list = getFileList(skeletonFolder);
	found = false;
	for (i = 0; i < list.length; i++) {
		if(matches(list[i], ".*" + imageName + ".*")){
			found = true;
			open(skeletonFolder +  list[i]);
			break;
		}
	}
	if(found == false){
		exit("Skeleton for image not found!!!.");
	}
	
	runMacro("repository/macros/skelets/1_find_skelets.ijm");
	close();
	
	
	for(i = 0; i < roiManager("count"); i++){
		maxValue = 0;
		bestSlice = 0;
		for( j = 1; j <= nSlices; j++){
			roiManager("select", i);
			Roi.setPosition(j);
			setSlice(j);
			run("Line Width...", "line=2");
			run("Area to Line");
			run("Measure");
			
			currentValue = getResult("Mean", nResults-1);
			
			if(currentValue > maxValue){
				maxValue = currentValue;
				bestSlice = j;
			}
		}
		roiManager("select", i);
		Roi.setPosition(bestSlice);	
		if(bestSlice == 0){
			exit("Slice error");
		}
		print(bestSlice);
	}
	
	roiManager("save", imageDirectory + "/" + imageName + "_raw_ROIs.zip");
}

function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);

// for (i = 0; i < 1; i++) {
for (i = 0; i < list.length; i++) {
		if(endsWith(list[i], ".czi") || endsWith(list[i], ".tif")){
			processFile(input+"\\"+ list[i]);
			close("*");

			run("Clear Results");

			roiManager("reset");

		}
	}
}


