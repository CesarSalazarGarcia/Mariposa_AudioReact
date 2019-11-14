//Using the FFT function and the Soundfile   
import processing.sound.*;


//Audio Processing Variables
SoundFile       file;
int             bands         =         64;
FFT             fft;
float[]         spectrum      =         new float[bands];

//Movement  /   Updated variables
float           angle         =         0;
int             counter       =         0;
int             secondC       =         0;

//RGB ARRAY for color Storaging
//Variables for color changing arithmethic
int             rgb[]         =         new int[9];
int             a, b, c, cControl;

//Frame Counter
int             fCounter      =         0;
color           Color[]       =         new color[2];

//Variables needed to create a "Tap Tempo"
int             tCount        , tCount2;

//Intialize the Counter to some value
int             resultCount   =         120;
int             beat;
boolean         iteration     =         false;

void setup() {
  //We need a 3D Canvas
  size(1000, 720, P3D);
  
  background(255);
  
  //Store The Main Colors of the show for further use
  Color[0] = color(204, 255, 255);
  Color[1] = color(189, 126, 126);
    
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "Mariposa.wav");
  file.play();
  
  //Create a new Fast Fourier Transform funciton and pass it the audio file to analyze 
  fft = new FFT(this, bands);
  fft.input(file);
  //Define an specific frameRate so we can save GPU
  frameRate(30);
  
  //Define packages of Rgb Values in the RGB Array so we can arithmetically iterate between them
  
  //pink
  rgb[0]=255;        //Red
  rgb[1]=204;        //Green
  rgb[2]=255;        //Blue

  //Blueish 
  rgb[3]=204;        //Red
  rgb[4]=255;        //Green
  rgb[5]=255;        //Blue 
  
  //Dark Red
  rgb[6] = 102;      //Red
  rgb[7] = 0;        //Green
  rgb[8] = 0;        //Blue
  
}      

void draw() {

  fCounter++;   //Count every frame

  //Color selecting function explained below
  colorPick(cControl);

  //Control the Rotation of the figure
  angle+= 0.01 + counter;

  //Frame Counter to give a little bit of variation to the code
  if(frameCount%1801 >= 1800){counter+=0.05; secondC+=10;}
  
  //Assign the value to the beat variable to control things with the tap tempo
  if(fCounter%resultCount >= resultCount-1){

  //  print("DEBUG");
    beat = 20;


  }else{beat=0;}
  
  //Lighting Functions
  directionalLight(240, 166, 166, 0, 6, -1);
  ambientLight(189, 126, 126);
  
  //Active de frequency amplitude analyzer with this function attached to the FFT object
  fft.analyze(spectrum);
  
  //Background Color controlled by the FFT.analyze() function which has to be rounded and mapped 
  //to regular values
  background(map(roundNum(spectrum[4]), 0, 1, rgb[a], 0), map(roundNum(spectrum[4]), 0, 1, rgb[b], 0), map(roundNum(spectrum[4]), 0, 1, rgb[c], 0));
  strokeWeight(1 - map(roundNum(spectrum[31]), 0, 0.2, 0, 0.9));
  //noStroke();
  stroke(50 - secondC);
  
  translate(width/2, height/2, 0 - (angle * -2)); //Center the sphere()function.
  
  //Color of the sphere controlled by the FFT.analyze() function values of an specific band of the spectrum
  fill(map(roundNum(spectrum[20]), 0, 1, 0, rgb[a]), map(roundNum(spectrum[20]), 0, 1, 0, rgb[b]), map(roundNum(spectrum[20]), 0, 1, 0, rgb[c]));
  //rotate the sphere
  rotateX(angle + map(spectrum[5], 0, 1, 0, 20));
  rotateY(angle *-1);
  //Controls the number of sides of the sphere
  sphereDetail((14+beat) / 4);
  
  sphere(200 + beat);
  
  //BG color changes
  if (fCounter >= 930  && fCounter <= 1860){cControl = 3;}
  if (fCounter > 1860  && fCounter >= 3720){cControl = 0;} 

  // The result of the FFT is normalized


}
