//class for spacial coordinates
import java.util.*;

public class fourier_point {
  float y, x, r;
  int l;
  fourier_point(float r_speed, int v_length) {
    l = v_length;
    r = r_speed;
  }
  void doPos(){
    x = (l*cos(r*angle))/r;
    y = (l*sin(r*angle))/r;
  }
}

//drawing functions based on center of screen
void ocircle(float originx, float originy, float x, float y, int o_width) {
  circle(x+originx, y+originy, o_width);
}
void oline(float originx, float originy, float x1, float y1, float x2, float y2) {
  line(x1+originx, y1+originy, x2+originx, y2+originy);
}
void concat(){
  
}

boolean sw = false;
boolean ps = false;
boolean husw = true;
float angle = 0;
float center_x = 600;
float center_y = 400;
float hue = 0;
processing.core.PImage pix;
List<fourier_point> fourier_exp = new ArrayList<fourier_point>();

fourier_point v1 = new fourier_point(1, 100);
fourier_point v2 = new fourier_point(2, 100);
fourier_point v3 = new fourier_point(3, 100);

void setup() {
  frameRate(800);
  size(1000, 800);
  clear();
  pix = get();
  
  fourier_exp.add(v1);
  fourier_exp.add(v2);
  fourier_exp.add(v3);
  
}

void draw() {
  
  image(pix, -1, 0);
  noStroke();
  
  int arr_size = fourier_exp.size();
  for(int i = 0; i < arr_size; i++){
    fourier_exp.get(i).doPos();
  }
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
    angle = angle - 0.05;
  }
  noStroke();
  ocircle(center_x, v2.y+v1.y+center_y, 0, v3.y, 20);
  loadPixels();
  pix = get();
  updatePixels();
  if (sw == true) {
    noFill();
    strokeWeight(5);
    stroke(hue, 360, 360, 50);
    
    ocircle(v1.x+center_x, v1.y+center_y, v2.x, v2.y, 20);
    ocircle(center_x, center_y, v1.x, v1.y, 20);
    ocircle(center_x, center_y, 0, 0, 20);
    
    ocircle(v1.x+center_x, v1.y+center_y, v2.x, v2.y, v3.l*2);
    ocircle(center_x, center_y, v1.x, v1.y, v2.l*2);
    ocircle(center_x, center_y, 0, 0, v1.l*2);
    
    oline(center_x, center_y, v1.x, v1.y, 0, 0);
    oline(v1.x+center_x, v1.y+center_y, v2.x, v2.y, 0, 0);
    oline(v2.x+v1.x+center_x, v2.y+v1.y+center_y, v3.x, v3.y, 0, 0);
    
    oline(center_x, center_y, v3.x+v2.x+v1.x, v3.y+v2.y+v1.y,  0, v3.y+v2.y+v1.y);
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
