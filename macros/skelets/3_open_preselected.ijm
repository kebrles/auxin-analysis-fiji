
path = File.openDialog("Select image");
open(path);

imageDirectory = File.getDirectory(path);

roiManager("open", imageDirectory + "/" + File.nameWithoutExtension +"_preselected_ROIs.zip");


