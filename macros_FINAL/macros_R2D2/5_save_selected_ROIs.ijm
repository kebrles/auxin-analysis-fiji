// po rucnim upraveni ROIu si pustis tohle makre na ulozeni 
// zabrani to preklepu v nazvu ROI souboru

imageDirectory = getDirectory("current");

imageName = getInfo("image.filename");


roiManager("save", imageDirectory + imageName + "_selected_ROIs.zip");

runMacro("my_macros/pomocna_makra/close_windows.ijm");