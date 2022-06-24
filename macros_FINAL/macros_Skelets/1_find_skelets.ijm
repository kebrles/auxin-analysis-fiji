
//open("C:\\projects\\stepka\\skeletons\\projections\\denoised\\skeleton\\SUM_AUX1_arpc4_3_plant1_1_Z-Stack-denoised-skeleton.tif")

imageWidth = getWidth();
imageHeight = getHeight();
findRoisWithWand();

function isSelectionOnBoundary(){
	getSelectionBounds(x, y, width, height);
	if(x == 0 || (x +width) >= imageWidth || y == 0 || (y + height) >= imageHeight){
		return true;
	}else{
		return false;		
	}
}

function isRoiUnique(){
	getSelectionBounds(x1, y1, width1, height1);
	for (i = roiManager("count") - 1; i>=0; i--) {
		roiManager("select", i);
		getSelectionBounds(x2, y2, width2, height2);
		if(x1 == x2 && y1 == y2){
			return false;
		}
	}
	return true;
}

function findRoisWithWand(){
	searchStepSize = 20;
	for (i = 1; i < imageWidth; i = i + searchStepSize) {	
		for(j = 1; j < imageHeight; j = j + searchStepSize){
			doWand(i, j);
			if(isSelectionOnBoundary() == false){
				//pokud je unikatni, tak ho pridej do ROI manageru
				if(isRoiUnique()){
					doWand(i, j);
					roiManager("add");			
				}
			}
		}
	}
}



