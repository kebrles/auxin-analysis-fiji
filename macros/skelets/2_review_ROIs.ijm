path = File.openDialog("Select image");
open(path);

imageid=getImageID();

imageDirectory = File.getDirectory(path);

roiManager("open", imageDirectory + "/" + File.nameWithoutExtension +"_raw_ROIs.zip");

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
if(found == false){
	exit("Skeleton for image not found!!!.");
}

selectImage(imageid);