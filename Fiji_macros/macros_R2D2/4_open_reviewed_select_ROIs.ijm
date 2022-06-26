path = File.openDialog("Select image");
open(path);

imageDirectory = File.getDirectory(path);
imageName = File.getName(path);

// close green channel
selectWindow(imageName + " - C=0");
close();

selectWindow(imageName + " - C=2");
close();

run("Enhance Contrast...", "saturated=0.9 normalize process_all");

roiManager("open", imageDirectory + "/" + imageName+"_reviewed_ROIs.zip");

