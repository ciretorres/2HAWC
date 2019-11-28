import peasy.*;
import oscP5.*;
import netP5.*;
/*
 * Title:
 * Authors: Eric Torres, Emilio Ocelotl, Marianne Teixido, Rodrigo Treviño.
 * Update: 6/03/2019 
 * Description: A 39 gamma-ray sources visualization from the 2HAWC catalogue for the 2018 Astronomy Hackathon. 
 * Reference: https://data.hawc-observatory.org/datasets/2hwc-survey/catalog.php
 */
PeasyCam cam;
OscP5 oscP5;
NetAddress myRemoteLocation;

PVector[][] sphere;
PVector[] source;
int[] flux_crab;
int[] flux_mrk421;
int[] flux_mrk501;

int sources = 41;
int total = 50; // Resolution of the sphere
float radius = 200; // Radius
float count = 0;
int flux_1 = 473;
int flux_2 = 472;
int flux_3 = 480;
float f_crab;
float f_mrk421;
float f_mrk501;
String typed = "";
int frameratecounter = 2;
int getal = 0;

boolean rotate = true;
boolean send = false;

/* Color */
int bg_color = 0;
int r = 0;
int g = 0;
int b = 255;
int opacity = 127;

void setup() {
  //size(displayWidth, displayHeight, P3D);
  //size(600, 600, P3D);
  fullScreen(P3D);
  textFont(createFont("Futura", 30));
  textAlign(LEFT);
  colorMode(RGB);
  loadPixels();
  smooth();
  
  /* Read Databases CSV */
  String[] HAWC_2 = loadStrings("data/2HWC_modified-2.csv");
  String[] fluxlc_Crab = loadStrings("data/HAWC_fluxlc_Crab_.csv");
  String[] fluxlc_Mrk421 = loadStrings("data/HAWC_fluxlc_Mrk421_.csv");
  String[] fluxlc_Mrk501 = loadStrings("data/HAWC_fluxlc_Mrk501_.csv");
  
  /* Initialize */
  sphere = new PVector[total+1][total+1];    
  source = new PVector[sources];
  flux_crab = new int[flux_1];
  flux_mrk421 = new int[flux_2];
  flux_mrk501 = new int[flux_3];

  /* Start camera position */
  cam = new PeasyCam(this, 0, 0, 0, 500); // camera pixel's away
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  
  //cam.setRotations(,,);

  /* Start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12000);  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", 12000); // Local
  //myRemoteLocation = new NetAddress("192.168.1.100", 5612); // Emilio

  /* 
   * PARSE DATABASES with:
   * spherical coordinates from gamaray sources – pulsar, super nebulae, source collision, galaxy centers –,
   * flux+ from Crab Nebulae,
   * flux+ from Markarian 421,
   * flux+ from Markarian 501.
   */
  println("\nloading... 2HWC.CSV"); //------------------------------------- GAMARAY SOURCES
  for (int i = 0; i < source.length; i++) { // 41 rows length
    String[] row = split(HAWC_2[i], ','); // Split CSV row by ','
    // Assign x, y, z coordinates
    float x = float(row[6]);
    float y = float(row[7]);
    float z = float(row[8]);
    // Assign Pvector
    source[i] = new PVector(x, y, z);
    if (i>0) {
      //println("source", i, " RA=", row[3], "Dec=", row[4], '|', "x=", x, "y=", y, "z=", z);
    }
  }
  
  println("loading database... HAWC_fluxlc_Crab.CSV"); //---------------------------- FLUX CRAB
  for (int i = 1; i < fluxlc_Crab.length; i++) { // 473 rows length
    String[] row = split(fluxlc_Crab[i], ','); // Split CSV row by ','
    // Assign flux_crab    
    flux_crab[i] = int(float(row[1])*1000000*1000000);
    //println(i, flux_crab[i]);
  }
  println("loading database... HAWC_fluxlc_Mrk421.CSV"); //-------------------------- FLUX MRK421
  for (int i = 1; i < fluxlc_Mrk421.length; i++) { // 472 rows length
    String[] row = split(fluxlc_Mrk421[i], ','); // Split CSV row by ','
    // Assign flux_mrk421    
    flux_mrk421[i] = int(float(row[1])*10000000*100000);
    //println(i, flux_mrk421[i]);
  }
  println("loading database... HAWC_fluxlc_Mrk501.CSV"); //-------------------------- FLUX MRK501
  for (int i = 1; i < fluxlc_Mrk501.length; i++) { // 480 rows length
    String[] row = split(fluxlc_Mrk501[i], ','); // Split CSV row by ','
    // Assign flux_mrk501    
    flux_mrk501[i] = int(float(row[1])*10000000*1000000);
    //println(i, flux_mrk501[i]);
  }

  println("\nCrab Nebulae| x:", 20.5772, ", y:", 184.26, ", z:", 74.99995846026627); // Crab Nebulae
  println("Geminga| x:", -26.6122, ", y:", 189.404, ", z:", 58.463658826701725); // Geminga 
  println("2HWC J0635+180| x:", -29.1991, ", y:", 187.899, ", z:", 30.989661262299755); //  2HWC J0635+180 
  println("Markarian 421| x:", -152.664, ", y:", 37.7438, ", z:", 123.56780557911655); // Markarian 421
  println("Markarian 501| x:", -43.7064, ", y:", -147.333, ", z:", 127.99485157236046); // Markarian 501
} //------------------------------------------------------------------------------------------------------ setup   

void draw() {
  background(bg_color);
  stroke(255, 0, 0);
  fill(255, 255, 0);
    
  noFill();
  stroke(r, g, b, opacity);
  strokeWeight(1);
  lights();
  //translate(width/2, height/2);
  
  /* Rotate camera */
  if (rotate) {
    cam.setRotations(count/200, count/200, count/200);
    count++;
  } else {    
    cam.setRotations(count/200, count/200, count/200);
  } //------------------------------------------------- Rotate camera

  /* 
   * Calculate 
   * SPHERICAL COORDINATES
   * by converting the cartesian system.
   */
  for (int i = 0; i < total+1; i++) {    
    float lat = map(i, 0, total, 0, PI); //------------ Latitude    
    for (int j = 0; j < total+1; j++) {      
      float lon = map(j, 0, total, 0, TWO_PI); //------ Longitude      
      float x = radius * sin(lat) * cos(lon);
      float y = radius * sin(lat) * sin(lon);
      float z = radius * cos(lat); 
      // Assign x, y, z coordinates to sphere in a two-dimensional array
      sphere[i][j] = new PVector(x, y, z);
      //println("vector", i,  j, " lat=", lat, "lon=", lon, '|', "x=", x, "y=", y, "z=", z);
    }
  } 
  /* 
   * Draw 
   * SPHERICAL SYSTEM
   */  
  for (int i = 0; i < total; i++) {
    beginShape(LINES); //------------- RIGHT ASCENSION    
    for (int j = 0; j < total; j++) {           
      if (i < 50 && j < 50) {
        // Assign coordinates x, y, z from globe array to v1 PVector object
        PVector v1 = sphere[i][j];    
        vertex(v1.x, v1.y, v1.z);
        // Assign coordinates x, y, z from globe array to v2 PVector object
        PVector v2 = sphere[i+1][j];
        vertex(v2.x, v2.y, v2.z);
      }
    }
    endShape();
    beginShape(); //------------------- DECLINATION
    for (int j = 0; j < total+1; j++) {      
      if (i < 50 && j < 51) {
        // Assign coordinates x, y, z from globe array to v2 PVector object
        PVector v2 = sphere[i+1][j];
        vertex(v2.x, v2.y, v2.z);
      }
    }
    endShape(CLOSE);
  } //------------------------------------ for

  /* 
   * Draw 
   * GAMARAY SOURCES 
   * – pulsar, super nebulae, star collision, galaxy centers –
   */
  for (int i = 0; i < source.length; i++) {
    PVector v1 = source[i]; // PVector
    //----------------------------------------- The Sun at the center in color white
    stroke(255, 255, 0);
    strokeWeight(7);
    point(0, 0, 0); 
    if (i == 1) { //--------------------------------------------- Draw Crab Nebulae
      stroke(random(255), random(255), random(255));      
      //strokeWeight(int(f_crab*5000));
      strokeWeight(flux_crab[int(random(flux_crab.length))]);
      //println(flux_crab[j]);
      //println("source", i, "x=", v1.x, "y=", v1.y, "z=", v1.z);
      point(v1.x, v1.y, v1.z);
    } else {
      if (i == 7) { //------------------------------------------- Draw Markarian 421
        stroke(random(255), random(255), random(255));
        //strokeWeight(int(f_mrk421*5000));
        strokeWeight(flux_mrk421[int(random(flux_mrk421.length))]);
        //println(flux_mrk421[j]);
        //println("source", i, "x=", v1.x, "y=", v1.y, "z=", v1.z);
        point(v1.x, v1.y, v1.z);
      } else {
        if (i == 9) { //----------------------------------------- Draw Markarian 501
          stroke(random(255), random(255), random(255));
          //strokeWeight(int(f_mrk501*5000));
          strokeWeight(flux_mrk501[int(random(flux_mrk501.length))]);
          //println(flux_mrk501[j]);
          //println("source", i, "x=", v1.x, "y=", v1.y, "z=", v1.z);
          point(v1.x, v1.y, v1.z);
        } else { //-------------------------------------------- Draw the rest of the sources          
          stroke(random(255), 0, 255);
          strokeWeight(6);        
          point(v1.x, v1.y, v1.z);
          //println("source", i, "x=", v1.x, "y=", v1.y, "z=", v1.z);
        }
      }
    }
    //--------- Draw the ray from the source (PENDING) ----------//
    stroke(random(255), random(255), random(255));
    strokeWeight(1);       
    line(0, 0, 0, 20.577173, 184.25957, 74.99996); // Crab Nebulae
    line(0, 0, 0, -152.664, 37.7438, 123.56780557911655); // Markarian 421
    line(0, 0, 0, -43.7064, -147.333, 127.99485157236046); // Markarian 501
  } //------------------------------------------------------------------ for
  
  //------------------------------ Typed Interface
  cam.beginHUD();
  if (round(frameCount/30) % 2 == 0){
    text(":"+typed, 5, 50);  
  } else {
    text(":"+typed+"_", 5, 50);   
  }
  cam.endHUD();
  
} //------------------------------------------------------------------------------------------------------ draw

void keyPressed() {  
  if (keyCode == BACKSPACE) {
    typed = "";
  }
  if (key == ENTER && typed.equals("osc")) {
    /* in the following different ways of creating osc messages are shown by example */
    OscMessage myMessage = new OscMessage("/fuente");    
    myMessage.add(3); /* add an int to the osc message */

    /* send the message */
    oscP5.send(myMessage, myRemoteLocation);
  }
  
  if (key == ENTER && typed.equals("rotar")) {   
    rotate = !rotate;
  }
  if (key == ENTER && (typed.equals("reset") || typed.equals("r"))) {
    float[] r = cam.getRotations();    
    //cam.setRotations(-r[0], -r[1], -r[2]);
    cam.reset();  
  }
  if (key == ENTER && typed.equals("dist 1")) {
    cam.setDistance(75);
  } else {
    if (key == ENTER && typed.equals("dist 2")){
      cam.setDistance(500);      
    }
  }
  if (key == '5') {
    //print(cam.getDistance());
    float[] look = cam.getLookAt();
    println("\nlook_x:", look[0], "look_y:", look[1], "look_z:", look[2]);
    float[] position;
    position = cam.getPosition();
    println("position_x:", position[0], "position_y:", position[1], "position_z:", position[2]);    
    float[] r = cam.getRotations();
    println("rotation_x", r[0], "rotation_y", r[1], "rotation_z", r[2]);
    //cam.lookAt(20.577173, 184.25957, 74.99996, 100.0);
  }
  if (key == CODED){
    if(keyCode == UP){
      
    } else {
      if(keyCode == DOWN){
        
      }
    }
  }
} //------------------------------------------------------------------------------------------------------ keyPressed

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* parse theOscMessage and extract the values from the osc message arguments. */
  if (theOscMessage.addrPattern().equals("/crabSend")) {
    f_crab = theOscMessage.get(0).floatValue();
    //println("### values from /crabSend pattern: "+f_crab);
  } else {
    if (theOscMessage.addrPattern().equals("/mrk421Send")) {
      f_mrk421 = theOscMessage.get(0).floatValue();
      //println("### values from /mrk421Send pattern: "+f_mrk421);
    } else {
      if (theOscMessage.addrPattern().equals("/mrk501Send")) {
        f_mrk501 = theOscMessage.get(0).floatValue();
        //println("### values from /mrk501Send pattern: "+f_mrk501);
      }
    }
  }
  int firstValue = theOscMessage.get(0).intValue();
  println("\n### values from the osc message: "+firstValue);
  /* print the address pattern and the typetag of the received OscMessage */
  //println(" typetag: "+theOscMessage.typetag());
  println("### received an osc message. with address pattern: "+theOscMessage.addrPattern());
  println("### IP address: "+theOscMessage.address());
  println("### port: "+theOscMessage.port());
  println("### NetAddress: "+theOscMessage.netAddress());
} //------------------------------------------------------------------------------------------------------ oscEvent
void keyTyped() {
  if (keyCode == RETURN) {
    //NO HAGO NADA Y TERMINA
    //Aquí podemos hacer las comparaciones con TYPED
  } else {
    typed += key;
  }
} //------------------------------------------------------------------------------------------------------ keyTyped
