path = File.openDialog("Select image");
open(path);

//volame makro na pripravu cerveneho kanale
runMacro("./my_macros/pomocna_makra/red_channel_to_masks.ijm");

//analyze particles
run("Analyze Particles...", "size=7-100 circularity=0.8-1.00 exclude add stack");

//TADY CHYBELO VYBRANI KOPIE ORIGINALU CERVENEHO KANALE !!! 
selectWindow(getInfo("image.filename") + " - C=1-1");
