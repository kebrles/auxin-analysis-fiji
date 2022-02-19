

// !!!!! NASTAV VZDALENOST CENTER, PRO KTEROU SE BERE ZE SE PREKRYVAJI, TAHLE FUNGUJE DOCELA DOBRE
MAX_CENTER_DISTANCE = 5;


// 0) PRIPRAVA PROMENNYCH
roiCount = roiManager("count");
toDelete = newArray(roiCount);
means = newArray(roiCount);
centers_X = newArray(roiCount);
centers_Y = newArray(roiCount);
stacks = newArray(roiCount);

// 1) NACTENI HODNOT PRO ZPRACOVANI V DALSIM KROKU
for (i = roiCount-1; i>=0; i--) {
	roiManager("select", i);
	roiManager("Measure");
	means[i] = getResult("Mean", nResults-1);
	centers_X[i] = getResult("X", nResults-1);
	centers_Y[i] = getResult("Y", nResults-1);
	//print(Roi.getProperty("position"));
	Roi.getPosition(notInterested,sliceNumber,notInterested)
	stacks[i] = sliceNumber;
	toDelete[i] = 0;
}

// 2) VYPOCET JESTLI SE PREKRYVAJI
for (i = roiCount-1; i>=0; i--) {
	currentStack = stacks[i];
	currentX = centers_X[i];
	currentY = centers_Y[i];
	currentMean = means[i];
	
	for(j = i-1; j >=0; j--){
		// !!! distance calculation
		if(stacks[i] == stacks[j]){ continue;};
		
		distance = sqrt(pow(currentX - centers_X[j],2) + pow(currentY - centers_Y[j],2));

		// remember weaker for deletion
		if(distance < MAX_CENTER_DISTANCE){
			if(means[j] < currentMean){
				toDelete[j] = 1;
			}else{
				toDelete[i] = 1;
			}
		}	
	}
}


// 3) MAZANI A PREJMENOVANI
for (i = roiCount-1; i>=0; i--) {
	if(toDelete[i] == 1 ){
		roiManager("select", i);
		roiManager("delete");
	}
}
