path = File.openDialog("Select image");
open(path);

imageDirectory = File.getDirectory(path);
imageName = File.getName(path);

greenChannelName = imageName + " - C=0";

// close white channel
selectWindow(imageName + " - C=1");
close();

run("Enhance Contrast...", "saturated=0.9 normalize process_all");

roiManager("open", imageDirectory + "/" + imageName+"_reviewed_ROIs.zip");

