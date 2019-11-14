
//FFT Value calibration to get numbers between 0 and 1.
float roundNum(float a){
  float result;
  result = (a * 100)/0.9;
  return result;
}

  //Simple Arithmetic 
  //Assign 0 or 3 to pick the right package of colors
void colorPick(int number){

a = number;
b = a + 1;
c = b + 1;


}


void keyPressed(){
    //Voluntarily change the color of the sketch
   if(key == 'c' || key == 'C'){
     if(cControl != 3){
     cControl = 3;
     }else{cControl=0;}
   }
   
   
   //Tap tempo 
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
