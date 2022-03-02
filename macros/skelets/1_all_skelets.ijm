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

skeletonFolder = imageDirectory + "/skeleton/";

list = getFileList(skeletonFolder);
found = false;
for (i = 0; i < list.length; i++) {
	if(matches(list[i], ".*" + imageName + ".*")){
		found = true;
		open(skeletonFolder +  list[i]);
		break;
	}
}

runMacro("my_macros/skelets/1_find_skelets.ijm");
close();
runMacro("my_macros/skelets/1_best_stack.ijm");

roiManager("save", imageDirectory + "/" + imageName + "_raw_ROIs.zip");
