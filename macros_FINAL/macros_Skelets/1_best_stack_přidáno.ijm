
placeROIsInBestStack();

function placeROIsInBestStack(){
	/*
	1) Otevri stack image -> filename resolution
	2) for each ROI - edit stack & measure best one
	3) select brightest stack
	*/
	//open("C:\\projects\\stepka\\skeletons\\AUX1_arpc4_3_plant1_1_Z-Stack.tif");
	for(i = 0; i < roiManager("count"); i++){
		maxValue = 0;
		bestSlice = 0;
		print(nSlices);
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
		//print(currentValue);
	}
	
}
