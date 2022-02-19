path = File.openDialog("Select image");
open(path);

imageDirectory = File.getDirectory(path);
imageName = File.getName(path);

// close green channel
selectWindow(imageName + " - C=0");
close();

// RED to masks
runMacro("my_macros/pomocna_makra/red_channel_to_masks.ijm");

//TADY CHYBELO VYBRANI CERVENEHO KANALE !!! 
selectWindow(imageName + " - C=1-1");

roiManager("open", imageDirectory + "/" + imageName+"_raw_ROIs.zip");

