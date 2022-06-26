path = File.openDialog("Select image");
open(path);

imageDirectory = File.getDirectory(path);
imageName = File.getName(path);

greenChannelName = imageName + " - C=0";

selectWindow(imageName + " - C=0");
close();

selectWindow(imageName + " - C=1");

roiManager("open", imageDirectory + "/" + imageName+"_selected_ROIs.zip");

