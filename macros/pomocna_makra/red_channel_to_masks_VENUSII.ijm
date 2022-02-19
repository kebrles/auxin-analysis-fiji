// define channel names
imageName = getInfo("image.filename");

greenChannelName = imageName + " - C=0";

// close white channel
selectWindow(imageName + " - C=1");
close();

// preprocess green
run("Duplicate...", "duplicate");
selectWindow(greenChannelName);
run("Enhance Contrast...", "saturated=2.5 normalize process_all");
run("Gaussian Blur...", "sigma=5 stack");

// threshold
selectWindow(greenChannelName);
run("8-bit");
run("Convert to Mask", "method=Huang background=Dark calculate");