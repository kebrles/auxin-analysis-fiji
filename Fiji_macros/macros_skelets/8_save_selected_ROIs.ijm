
imageDirectory = File.directory;
// definice jmena souboru upravenych ROIu
roiManager("save", imageDirectory + File.nameWithoutExtension + "_selected_ROIs.zip");

close("*");

run("Clear Results");

roiManager("reset");

