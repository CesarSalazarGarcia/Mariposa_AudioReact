  
import processing.sound.*;
SoundFile file;
int bands = 64;
FFT fft;
float[] spectrum = new float[bands];
LowPass lowpass;
float angle = 0;
int counter = 0;
int secondC = 0;
int rgb[] = new int[9];

int a, b, c, cControl;
int  fCounter = 0;
color Color[] = new color[2];

int tCount, tCount2;
int resultCount = 120;
int beat;

boolean iteration = false;

void setup() {
  size(1000, 720, P3D);
  background(255);
  
  Color[0] = color(204, 255, 255);
  Color[1] = color(189, 126, 126);
    
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "Mariposa.wav");

  file.loop();
  fft = new FFT(this, bands);
  fft.input(file);

  frameRate(30);
  print((30*60)*30);
  
  
  lowpass = new LowPass(this);
  rgb[0]=255;
  rgb[1]=204;
  rgb[2]=255;

  
  
  rgb[3]=204;
  rgb[4]=255;
  rgb[5]=255;  
  
  
  
  
  rgb[6] = 102;
  rgb[7] = 0;
  rgb[8] = 0;
  
}      

void draw() {
  fCounter++;
  //println(fCounter);
  a = cControl;
  b = a + 1;
  c = b + 1;
  
  angle+= 0.01 + counter;
  //255, 204, 255
  
  if(frameCount%1801 >= 1800){counter+=0.05; secondC+=10;}
  
  if(fCounter%resultCount >= resultCount-1){

    print("YA MERO");
    beat = 20;


  }else{beat=0;}
  
  
  directionalLight(240, 166, 166, 0, 6, -1);
  ambientLight(189, 126, 126);
  fft.analyze(spectrum);
  background(map(roundNum(spectrum[4]), 0, 1, rgb[a], 0), map(roundNum(spectrum[4]), 0, 1, rgb[b], 0), map(roundNum(spectrum[4]), 0, 1, rgb[c], 0));
  strokeWeight(1 - map(roundNum(spectrum[31]), 0, 0.2, 0, 0.9));
  //noStroke();
  stroke(30 - secondC);
  
  translate(width/2, height/2, 0 - (angle * -2));
//  rotateX(mouseY * 0.05);
//  rotateY(mouseX * 0.05);
  fill(map(roundNum(spectrum[20]), 0, 1, 0, rgb[a]), map(roundNum(spectrum[20]), 0, 1, 0, rgb[b]), map(roundNum(spectrum[20]), 0, 1, 0, rgb[c]));
  rotateX(angle + map(spectrum[5], 0, 1, 0, 20));
  rotateY(angle *-1);
  sphereDetail((14+beat) / 4);
  sphere(200 + beat);
  if (fCounter >= 930){cControl = 3;}

  // The result of the FFT is normalized
  // draw the line for frequency band i scaling it up by 5 to get more amplitude.
//println(map(roundNum(spectrum[10]), 0, 1, 0, 255));

}

float roundNum(float a){
  float result;
  result = (a * 100)/0.9;
  return result;
}

void keyPressed(){

   if(key == 'c' || key == 'C'){
     if(cControl != 3){
     cControl = 3;
     }else{cControl=0;}
   }
   
   
   
   if(key == 't'){
     if(iteration == false){
       
       tCount = fCounter;
       iteration = !iteration; 
           print("BEAT 1");
     
     }else if(iteration == true){
       tCount2 = fCounter;
       iteration = !iteration;
       resultCount = tCount2 - tCount;
           print("BEAT 2");
           print(resultCount);
     }

   }


}
