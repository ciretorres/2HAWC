import peasy.*;
import oscP5.*;
import netP5.*;

/*
 * Title: Hackatón 2018
 * Author: Eric Torres, Emilio Ocelotl, Marianne Teixido, Rodrigo
 * Date: 
 * Description: 39 sources of gama ray 
 */
PeasyCam cam;
OscP5 oscP5;
NetAddress puredata;

PVector[][] sphere;
PVector[] star;
float[] magnitude;

int stars = 41;
int total = 50; // Resolution of the sphere
float radius = 200; // Radius
float count = 0;

boolean rotate = true;
boolean send = false;

/* Color */
int bg_color = 255;
int r = 0;
int g = 0;
int b = 0;
int opacity = 127;

void setup() {
  /* Read CSV */
  String[] lines = loadStrings("data/2HWC_modified-2.csv");
  size(600, 600, P3D);
  colorMode(RGB);
  loadPixels();
  smooth();

  /* Start camera position */
  cam = new PeasyCam(this, 0, 0, 0, 100); // camera pixel's away
  //cam.lookAt(0, 0, 0);

  /* Port */
  oscP5 = new OscP5(this, 12000);
  /* PureData address */
  puredata =  new NetAddress("192.168.1.100", 5612); // pendiente

  sphere = new PVector[total+1][total+1];    
  star = new PVector[stars];
  magnitude = new float[stars];    

  /* 
   * Calculate
   * CELESTIAL OBJECT – pulsar, super nebulae, stars collision, galaxy center –
   * spherical coordinates
   */
  println("\nGAMARAY SOURCES FROM 2HWC.CSV");
  for (int i = 0; i < star.length; i++) {
    // Split CSV row by ','
    String[] row = split(lines[i], ',');
    // Assign x, y, z coordinates
    float x = float(row[6]);
    float y = float(row[7]);
    float z = float(row[8]);
    // Assign Pvector
    star[i] = new PVector(x, y, z);
    magnitude[i] =  6;        
    if (i>0) {
      println("star", i, " RA=", row[3], "Dec=", row[4], '|', "x=", x, "y=", y, "z=", z);
    }
  }
} // setup   

void draw() {    

  background(bg_color);
  noFill();
  stroke(r, g, b, opacity);
  strokeWeight(1);
  lights();
  //translate(width/2, height/2); 

  //point(20.5772, 184.26, 74.99995846026627); // Crab Nebulae
  
  
  //rotateX(300);
  //rotateY(-50);


  /* Rotate camera */
  if (rotate) {
    //rotateX(count/200);
    //rotateY(count/200);
    //rotateZ(count/200);
    count++;
  } else {
    rotateX(count/200);
    rotateY(count/200);
  }

  /* 
   * Calculate 
   * SPHERICAL COORDINATES
   */
  for (int i = 0; i < total+1; i++) {    
    float lat = map(i, 0, total, 0, PI); // Latitude    
    for (int j = 0; j < total+1; j++) {      
      float lon = map(j, 0, total, 0, TWO_PI); // Longitude      
      float x = radius * sin(lat) * cos(lon);
      float y = radius * sin(lat) * sin(lon);
      float z = radius * cos(lat); 
      // Assign x, y, z coordinates to sphere in a two-dimensional array
      sphere[i][j] = new PVector(x, y, z);
      //println("sphere", i,  j, " lat=", lat, "lon=", lon, '|', "x=", x, "y=", y, "z=", z);
    }
  }  

  /* 
   * Draw 
   * SPHERICAL COORDINATES  
   */
  for (int i = 0; i < total; i++) {

    beginShape(LINES); // RIGHT ASCENSION    
    for (int j = 0; j < total; j++) {           
      if (i < 50 && j < 50) {
        // Assign coordinates x, y, z from globe array to v1 PVector object
        PVector v1 = sphere[i][j];    
        //vertex(v1.x, v1.y, v1.z);
        // Assign coordinates x, y, z from globe array to v2 PVector object
        PVector v2 = sphere[i+1][j];
        //vertex(v2.x, v2.y, v2.z);
      }
    }
    endShape();

    beginShape(); // DECLINATION
    for (int j = 0; j < total+1; j++) {      
      if (i < 50 && j < 51) {
        // Assign coordinates (x,y,z) from globe array to v2 PVector object
        PVector v2 = sphere[i+1][j];
        //vertex(v2.x, v2.y, v2.z);
      }
    }
    endShape(CLOSE);
  } // for
  //sphere(200);
  /* 
   * Draw 
   * CELESTIAL OBJECT – pulsar, super nebulae, stars collision, galaxy center –
   */
  for (int i = 0; i < star.length; i++) {
    // PVector
    PVector v1 = star[i];
    if (i == 0) {
      // Draw Sun at the center in white
      stroke(0);
      strokeWeight(6);        
      point(0, 0, 0);
    }

    stroke(random(255), random(255), random(255));
    strokeWeight(magnitude[i]);        
    point(v1.x, v1.y, v1.z);
    strokeWeight(1);        
    //line(0,0,0, v1.x, v1.y, v1.z);
    //println("star", i, "x=", v1.x, "y=", v1.y, "z=", v1.z);
  }
  strokeWeight(1);        

  line(0, 0, 0, 20.577173, 184.25957, 74.99996);

  if (send) {
  }


  //point(20.5772, 184.26, 74.99995846026627); // Crab Nebulae
  //point(-26.6122, 189.404, 58.463658826701725); // Geminga 
  //point(-29.1991, 187.899, 30.989661262299755); //  2HWC J0635+180 
  //point(-152.664, 37.7438, 123.56780557911655); // Markarian 421
  //point(-43.7064, -147.333, 127.99485157236046); // Markarian 501
  
}

void keyPressed() { 

  if (key == ENTER) {   
    rotate = !rotate;
    //zoom++;
  }
  if (key == 's') { 
    cam.lookAt(20.5772, 184.26, 74.99995846026627);
    oscP5.send(new OscMessage("/star").add(3), puredata);    
    println("Sent OSC Message");    
    //send = !send;
  }
  if (key == '1') {
    cam.setDistance(52);  // distance from looked-at point
  } else {
    if (key == '2'){
      cam.setDistance(450);  // distance from looked-at point
    }
  }
  //if (key == CODED){
  //  if(keyCode == UP){
  //    zoom = !zoom;
  //  } else {
  //    if(keyCode == DOWN){
  //    zoom = !zoom;
  //    }
  //  }
  //}
}
