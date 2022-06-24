// po rucnim upraveni ROIu si pustis tohle makre na ulozeni 
// zabrani to preklepu v nazvu ROI souboru

imageDirectory = getDirectory("current");

imageName = getInfo("image.filename");

// definice jmena souboru upravenych ROIu
roiManager("save", imageDirectory + imageName + "_selected_ROIs_cells.zip");

runMacro("my_macros/pomocna_makra/close_windows.ijm");
