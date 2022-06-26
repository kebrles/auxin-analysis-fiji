imageDirectory = File.directory;

print(File.directory);
// definice jmena souboru upravenych ROIu
roiManager("save", imageDirectory + File.nameWithoutExtension + "_reviewed_ROIs.zip");
runMacro("my_macros/pomocna_makra/close_windows.ijm");