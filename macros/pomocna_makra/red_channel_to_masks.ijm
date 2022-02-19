// define channel names
imageName = getInfo("image.filename");

redChannelName = imageName + " - C=1";
greenChannelName = imageName + " - C=0";

// close white channel
selectWindow(imageName + " - C=2");
close();

// preprocess red
run("Duplicate...", "duplicate");
selectWindow(redChannelName);
run("Enhance Contrast...", "saturated=0.3 normalize process_all");
run("Gaussian Blur...", "sigma=2 stack");

// threshold
selectWindow(redChannelName);
run("8-bit");
run("Convert to Mask", "method=Huang background=Dark calculate");