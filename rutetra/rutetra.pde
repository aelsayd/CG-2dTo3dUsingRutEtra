//import processing.video.*;

//Capture video;
PImage pic, dith;

int res = 2;
float chaos = 4;
float RNG = 1.25;
int thicc = 23;
boolean gs = false;

int type = 3;
boolean displace = true;

int BLK = 1000; 


//void captureEvent(Capture video) {
//  video.read();
//}

void setup(){
	pic = loadImage("pic5.jpg");
	
	//video = new Capture(this, 640, 480);
  	//video.start();
	
	float ratio = 1;

	pic.resize(floor(pic.width/ratio), floor(pic.height/ratio));
	
	size(1500,1500);
	surface.setSize(pic.width, pic.height);
	System.out.println(pic.width);
	System.out.println(pic.height);
	pic.loadPixels();
	//size(640, 480);
	background(#101015);
	//background(115);
	
	dith = dither(pic);
	pic = dith;
	//dith = pic;

	//pic = video;
	//dith = video;
	
	frameRate(120);

}

int count = 0;
int count2 = 0;
boolean reversing = true; 

void draw(){

	int blink = floor(random(1, BLK*BLK));

	chaos = chaos + random(chaos*-0.25, 0.25*chaos);
	//chaos *= random(0.85, 1.25);	

	//if(chaos > 0.35 && !reversing){
	//	chaos *= 0.99;
	//}else if(chaos < 10){
	//	reversing = true;	
	//	chaos *= 1.05;
	//}else{
	//	reversing = false;
	//}

	//System.out.println(chaos);	
	if(chaos <= 0.75){
		chaos += 0.5;
	}else if(chaos >= 10){
		chaos -= 1;
	}
	
	
	float range = random(0, RNG*RNG);

	float rand = random(1);
 	//if(!(rand <= 0.75 && rand >= 0.5))
		background(#101015);

	if(count2 < 30 || count % blink == 0){
		image(dith,0, 0);
		count2++;
	}
	else{
		if((count + 1) % blink == 0){
			count2 = 0;
		}
		else

		if(type == 0 || type == 2 || (type == 3 && rand < 0.5)){
			for(int i = 0; i < width; i+=res){
				float ran = i + (random(range*-1, range));
				for(int j = 0; j < height; j+=1){	
					int pixel = pic.pixels[i+width*j];
					if(!gs)
						fill(pixel, 255/thicc);
					else
						fill(gray(pixel), 255/thicc);
					noStroke();

					if(displace)
						rect(ran, j, thicc, thicc);
					else{
						if(type > 1){
							rect(i + ((gray(pixel)-125)/chaos), j + ((gray(pixel)-125)/chaos),  thicc, thicc);
						}else
							rect(i + ((gray(pixel)-125)/chaos), j,  thicc, thicc);
					}
					
					ran = ran + (random(range*-1, range));
				}
			}	
		}
		if(type == 1 || type == 2 || (type == 3 && rand > 0.5)){
			for(int i = 0; i < height; i+=res){
				float ran = i + (random(range*-1, range));
				for(int j = 0; j < width; j+=1){	
					int pixel = pic.pixels[i*width+j];	
					if(!gs)	
						fill(pixel, 255/thicc);
					else	
						fill(gray(pixel), 255/thicc);
					noStroke();
					if(displace)
						rect(j, ran, thicc, thicc);
					else{	
						if(type > 1)
							rect(j + ((gray(pixel)-125)/(2*chaos)), i + ((gray(pixel)-125)/chaos),  thicc, thicc);

						else
							rect(j, i + ((gray(pixel)-125)/(2*chaos)),  thicc, thicc);
					}
					ran = ran + (random(range*-1, range));
				}
			}	
		}
	}

	count++;
}

float gray(color x){
	return floor((red(x)+green(x)+blue(x))/3);
}

PImage dither(PImage pic){
	int density = 10;
	pic.loadPixels();
	for(int i = 0; i < pic.width; i+=density){
		for(int j = 0; j < pic.height; j+=density){
			rectMode(CENTER);
			fill(pic.pixels[i + j*width]);
			//stroke(pic.pixels[i + j*width]);
			//noStroke();
			ellipse(i,j, 3, 3);
		}
	}
	save("dither.jpg");
	return loadImage("dither.jpg");
}
