//class for spacial coordinates
import java.util.*;

public class fourier_point {
  float y, x, r, d;
  int s;
  
  fourier_point(float r_speed, int sense, float denom) {
    r = r_speed;
    s = sense;
    d = denom;
  }
  
   //coordinate definition
  void doPos(){
    x = (longg*cos(s*r*angle))/(d);
    y = (longg*sin(s*r*angle))/(d);
    
  }
}

//drawing functions based on center of screen
void ocircle(float originx, float originy, float x, float y, float o_width) {
  circle(x+originx, y+originy, o_width);
}
void oline(float originx, float originy, float x1, float y1, float x2, float y2) {
  line(x1+originx, y1+originy, x2+originx, y2+originy);
}

//switch variables
boolean sw = true;
boolean ps = false;
boolean husw = true;
boolean movsw = false;

//math stuff
float angle = 0;
float center_x = 600;
float center_y = 400;
float hue = 0;
float dta = 0.02;
public int longg = 100;
processing.core.PImage pix;
List<fourier_point> fourier_exp = new ArrayList<fourier_point>();

void setup() {
  
  frameRate(800);
  size(1000, 700);
  //clear();
  background(#000000);
  pix = get();
  
  //Wave definitions, uncomment to change
  
  //square
  /*for (int i = 1; i<=5;i += 2){
    fourier_exp.add(new fourier_point(i,1,i));
  }*/
  
  //sawtooth
  for (int i = 1; i<=5;i++){
    fourier_exp.add(new fourier_point(i,1,i));
  }
  
  //triangular
  //for (int i = 1; i<=5;i += 2){
  //  if(i % 3 == 0){
  //    fourier_exp.add(new fourier_point(i,-1,(i*i)));
  //  }else{
  //    fourier_exp.add(new fourier_point(i,1,(i*i)));
  //  }
  //}
  
  //sine
  //for (int i=1; i<=3; i++){
  //  fourier_exp.add(new fourier_point(1,1,2));
  //}
  
}

void draw() {
  
  //Toggle static or moving line
  if (movsw == true) {
    image(pix, 0, 0);
  }else{
    image(pix, -1, 0);
  }
  noStroke();
  
  //Toggle rgb
  if (husw == true) {
    colorMode(HSB);
    fill(hue, 360, 360);
    if (hue > 320) {
      hue = 0;
    }
    hue += 1;
  } else {
    fill(#0000FF);
  }
  
  //Toggle pause
  if (ps == false) {
    angle = angle - dta;
  }
  
  //Actually do the series
  float evalx = 0; float evaly = 0; 
  for(int i = 0; i < fourier_exp.size(); i++){
    fourier_exp.get(i).doPos();
    evaly = evaly + fourier_exp.get(i).y;
    evalx = evalx + fourier_exp.get(i).x;
  }
  
  //Main plot circle
  if (movsw == true){
    ocircle(center_x+evalx, center_y+evaly, 0,0, 20);
  }else{
    ocircle(center_x, center_y+evaly, 0,0, 20);
  }
  
  //Store pixels for next iteration
  loadPixels();
  pix = get();
  updatePixels();
  
  //Toggle skeleton
  if (sw == true) {
    noFill();
    strokeWeight(5);
    stroke(hue, 360, 360, 50);
    float sumx = 0;
    float sumy = 0;
    
    //Print intermediate vectors
    for(int i=0; i < fourier_exp.size(); i++){
      oline(center_x+sumx, center_y+sumy, fourier_exp.get(i).x, fourier_exp.get(i).y, 0, 0);
      circle(center_x+sumx, center_y+sumy, 2*sqrt(pow(fourier_exp.get(i).x,2) + pow(fourier_exp.get(i).y,2)));
      sumx = sumx + fourier_exp.get(i).x;
      sumy = sumy + fourier_exp.get(i).y;
      ocircle(center_x+sumx, center_y+sumy, 0, 0,20);
      }
      if (movsw==false){
        oline(center_x, center_y, sumx, sumy,  0, sumy);
      }
  }
}

//Key inputs
void keyPressed() {
  //Show skeleton
  if (key == 'k') {
    clear();
    sw = !sw;
  }
  //Pause
  if (key == 'j') {
    clear();
    ps = !ps;
  }
  //Toggle rgb
  if (key == 'h') {
    husw = !husw;
  }
  //Toggle line movement
  if (key == 'l') {
    background(0,0,0,100);
    loadPixels();
    pix = get();
    updatePixels();
  
    movsw = !movsw;
  }
}
