path = File.openDialog("Select image");

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
}

roiManager("save", imageDirectory + "/" + imageName + "_raw_ROIs.zip");
