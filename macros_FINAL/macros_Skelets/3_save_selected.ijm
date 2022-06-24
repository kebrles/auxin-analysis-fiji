/*

3) rozdeleni na pavement cells a stomatal cells
- rucne vymazu stomata a zbyde pavement 
- stomaty se pak udelaji auto jako doplnek
- ulozit jako _selected
*/

imageDirectory = File.directory;
// definice jmena souboru upravenych ROIu
roiManager("save", imageDirectory + File.nameWithoutExtension + "_selected_ROIs.zip");
pavementCount = roiManager("count");


roiManager("open", imageDirectory + "/" + File.nameWithoutExtension +"_reviewed_ROIs.zip");

for( i = 0 ; i< pavementCount; i++){
	roiManager("select", i);
	pavementName = Roi.getName;
	print("Processing: " + pavementName);
	for(j = pavementCount; j < roiManager("count"); j++){
		roiManager("select", j);
		if(pavementName == Roi.getName){
			print("Deleting: "+ Roi.getName);
			roiManager("delete");
			break;
		}
	}
}

print(roiManager("count"));
for( i = 0 ; i< pavementCount; i++){
	roiManager("select", 0);
	print("Deleting pavement: " + Roi.getName);
	roiManager("delete");
}

roiManager("save", imageDirectory + File.nameWithoutExtension + "_stomata_ROIs.zip");

// close????

