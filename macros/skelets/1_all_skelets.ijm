/*
	pick image
	- autonavigate to skeleton
	- magic wand, close skelet
	- place rois in layer
	


 */

path = File.openDialog("Select image");

open(path);
imageDirectory = File.getDirectory(path);
imageName = File.nameWithoutExtension;
skeletonFileName = "SUM_" + imageName + "-denoised-skeleton.tif";
skeleton = imageDirectory + "/projections/denoised/skeleton/" + skeletonFileName;

open(skeleton);
runMacro("my_macros/skelets/1_find_skelets.ijm");
close();
runMacro("my_macros/skelets/1_best_stack.ijm");

roiManager("save", imageDirectory + "/" + imageName + "_raw_ROIs.zip");
