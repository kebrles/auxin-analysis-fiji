imageDirectory = getDirectory("current");

imageName = getInfo("image.filename");


roiManager("save", imageDirectory + imageName + "_selected_ROIs.zip");

runMacro("my_macros/pomocna_makra/close_windows.ijm");