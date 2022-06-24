
roiCount = roiManager("count");

for (i=roiCount-1; i>=0; i--) {

	
	roiManager("select", i);
	roiManager("Measure");
	area = getResult("Area", nResults-1);
	mean = getResult("Mean", nResults-1);
	perimeter = getResult("Perim.", nResults-1);
	

	//convex hull measurements for malformed ROI removal
	run("Convex Hull");
	run("Measure");
	convexArea = getResult("Area", nResults-1);
	convexPerimeter = getResult("Perim.", nResults-1);

	// vypis udaju pro predstavu
//	Array.print(newArray(i+1,perimeter,convexPerimeter));

	roiManager("select", i);

	//podminka jestli je bunka s klikatym perimetrem
	if(convexPerimeter/perimeter < 0.80){
		roiManager("rename", "Remove");
		/*
		Jeste bysme chteli vymazat hnusnej ROI z masky,
		to by
		*/

		// odkomentuj, kdyz chces tenhle ROI smazat
		//roiManager("delete");
	}
}
