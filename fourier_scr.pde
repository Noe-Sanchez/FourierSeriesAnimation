//class for spacial coordinates
import java.util.*;

public class fourier_point {
  float y, x, r;
  fourier_point(float r_speed) {
    r = r_speed;
  }
  void doPos(){
    x = (longg*cos(r*angle))/(r);
    y = (longg*sin(r*angle))/(r);
  }
}

//drawing functions based on center of screen
void ocircle(float originx, float originy, float x, float y, float o_width) {
  circle(x+originx, y+originy, o_width);
}
void oline(float originx, float originy, float x1, float y1, float x2, float y2) {
  line(x1+originx, y1+originy, x2+originx, y2+originy);
}
void concat(){
  
}

boolean sw = true;
boolean ps = false;
boolean husw = true;
float angle = 0;
float center_x = 600;
float center_y = 400;
float hue = 0;
float dta = 0.02;
public int longg = 100;
processing.core.PImage pix;
List<fourier_point> fourier_exp = new ArrayList<fourier_point>();

fourier_point v1 = new fourier_point(1);
fourier_point v2 = new fourier_point(2);
fourier_point v3 = new fourier_point(3);
fourier_point v4 = new fourier_point(4);
fourier_point v5 = new fourier_point(5);
fourier_point v6 = new fourier_point(6);
fourier_point v7 = new fourier_point(7);
fourier_point v8 = new fourier_point(8);
fourier_point v9 = new fourier_point(9);
fourier_point v10 = new fourier_point(10);
fourier_point v11 = new fourier_point(11);
fourier_point v12 = new fourier_point(12);
fourier_point v13 = new fourier_point(13);
fourier_point v14 = new fourier_point(14);

void setup() {
  frameRate(800);
  size(1000, 800);
  clear();
  pix = get();
  
  fourier_exp.add(v1);
  fourier_exp.add(v2);
  fourier_exp.add(v3);
  fourier_exp.add(v4);
  fourier_exp.add(v5);
  fourier_exp.add(v6);
  fourier_exp.add(v7);
  fourier_exp.add(v8);
  fourier_exp.add(v9);
  fourier_exp.add(v10);
  fourier_exp.add(v11);
  fourier_exp.add(v12);
  fourier_exp.add(v13);
  fourier_exp.add(v14);
}

void draw() {
  
  image(pix, -1, 0);
  noStroke();
  //toggle rgb
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
  
  //toggle pause
  if (ps == false) {
    angle = angle - dta;
  }
  float eval = 0;
  int arr_size = fourier_exp.size();
  for(int i = 0; i < arr_size; i++){
    fourier_exp.get(i).doPos();
    eval = eval + fourier_exp.get(i).y;
  }
  noStroke();
  ocircle(center_x, center_y+eval, 0,0, 20);
  
  loadPixels();
  pix = get();
  updatePixels();
  
  if (sw == true) {
    noFill();
    strokeWeight(5);
    stroke(hue, 360, 360, 50);
    float sumx = 0;
    float sumy = 0;
    for(int i=0; i < arr_size; i++){
      oline(center_x+sumx, center_y+sumy, fourier_exp.get(i).x, fourier_exp.get(i).y, 0, 0);
      sumx = sumx + fourier_exp.get(i).x;
      sumy = sumy + fourier_exp.get(i).y;
      ocircle(center_x+sumx, center_y+sumy, 0, 0,20);
      //ocircle(center_x+sumx, center_y+sumy, 0, 0, sqrt((fourier_exp.get(i).x*fourier_exp.get(i).x)+(fourier_exp.get(i).y*fourier_exp.get(i).y)));
      }
    oline(center_x, center_y, sumx, sumy,  0, sumy);
  }
}

//inputs
void keyPressed() {
  //show skeleton
  if (key == 'k') {
    clear();
    sw = !sw;
  }
  //pause
  if (key == 'p') {
    clear();
    ps = !ps;
  }
  //toggle rgb
  if (key == 'h') {
    husw = !husw;
  }
}
