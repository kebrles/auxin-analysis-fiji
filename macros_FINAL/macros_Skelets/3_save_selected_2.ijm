/*

3) rozdeleni na pavement cells a stomatal cells
- rucne vymazu stomata a zbyde pavement 
- stomaty se pak udelaji auto jako doplnek
- ulozit jako _selected
*/

imageDirectory = File.directory;
// definice jmena souboru upravenych ROIu
roiManager("save", imageDirectory + File.nameWithoutExtension + "_selected_ROIs.zip");

close("*");

run("Clear Results");

roiManager("reset");

