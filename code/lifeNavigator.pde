// Created by Chu-han Wu


import ddf.minim.*;

import processing.video.*;
import gab.opencv.*;

import wblut.math.*;
import wblut.processing.*;
import wblut.core.*;
import wblut.hemesh.*;
import wblut.geom.*;
import java.util.Iterator;

//audio
AudioPlayer playerBG;
AudioPlayer player1;
AudioPlayer player2;
AudioPlayer player3;
Minim bgMusic;
Minim robotVoice1;
Minim robotVoice2;
Minim robotVoice3;
Minim audioInput; 
AudioInput in; 

//cam
Capture cam;

//sphere
HE_Mesh mesh;
HE_Mesh noiseMesh;
WB_Render render;
HE_Vertex[] points;
HE_Vertex[] noisePoints;

PImage bg;
PFont welcome;
String welcome1 = "Welcome to Life Navigator";
String welcome2 = "This is a smart system with \n real data and rich life experience \n of thousands of users";
String welcome3 = "Let me hear your question \n so that I can give you advices";

int captureSpeak;

float x;
float y;
boolean isSaid;
int numberT;

Feedback[] feedbacks;
boolean pMousePressed;
PFont soup;
boolean isDrawingText;


void setup() {
  size(1024, 609, P3D);
  smooth(8);
  
  bg = loadImage("bg.jpeg");
  welcome = createFont("SmartCourierEUR-Medium.ttf", 28);
  robotVoice1 = new Minim(this);
  robotVoice2 = new Minim(this);
  robotVoice3 = new Minim(this);
  bgMusic = new Minim(this);
  audioInput = new Minim(this);
  playerBG = bgMusic.loadFile("bgMusic.wav", 1024);
  player1 = robotVoice1.loadFile("robotVoice1.wav", 1024);
  player2 = robotVoice2.loadFile("robotVoice2.wav", 1024);
  player3 = robotVoice3.loadFile("robotVoice3.wav", 1024);
  // use the getLineIn method of the Minim object to get an AudioInput
  in = audioInput.getLineIn();

  isSaid = false;
  isDrawingText = false;
  //sphere Icon
  HEC_Sphere creator=new HEC_Sphere();
  creator.setRadius(80); 
  creator.setUFacets(32);
  creator.setVFacets(32);
  mesh = new HE_Mesh(creator);
  noiseMesh = new HE_Mesh(creator);
  HET_Diagnosis.validate(mesh);
  noisePoints = noiseMesh.getVerticesAsArray().clone();


  render=new WB_Render(this);

  //prepare the text feedbacks
  soup = createFont("ArticulatCF-Bold.otf", 40);
  feedbacks = new Feedback[30];
  for (int i=0; i<30; i++) {
    feedbacks[i] = new Feedback(i, -i*1500, random(50, height-50));
  }


  // Start capturing
  cam = new Capture(this, 1024, 609);
  cam.start(); 


  // start background sound
  playerBG.play();
}



void draw() {

  if (!isDrawingText) {
    image(bg, 0, 0);
    drawIcon();
    fill(200);
    textFont(welcome);
    textAlign(CENTER, CENTER);
  }

  if (frameCount>0 && frameCount<200) {
    text(welcome1, width/2, height/4*3);
    player1.play();
  }
  if (frameCount>201 && frameCount<650) {
    text(welcome2, width/2, height/4*3);
    player2.play();
  }
  if (frameCount>651 && frameCount<950) {
    text(welcome3, width/2, height/4*3);
    player3.play();
  }

  if (frameCount>951 && isSaid == false) {

    for (int i = width/3; i < in.bufferSize()-width/3; i = i+15)
    {
      noStroke();
      fill(245);
      ellipse(i, height/4*3 + in.left.get(i)*250, 5, 5); 

      if (in.left.get(i)*1000 > 60) {
        captureSpeak = frameCount;
      }
    }
  }


  if (frameCount>1100 && frameCount - captureSpeak > 200 && in.mix.level()*1000 < 20) {
    println(frameCount - captureSpeak);
    isSaid = true;
    isDrawingText = true;
    in.disableMonitoring();

    if (cam.available() == true) {
      cam.read();
    }
    //background(0);
    fill(0, 40);
    rect(0, 0, width, height);
   
    image(cam, 311, 188, 400, 238);
    drawText();
  }
}

void drawText() {
  for (int j=0; j<30; j++) {

    feedbacks[j].display();
    feedbacks[j].run();

    if (mousePressed) {

      if (feedbacks[j].collision(mouseX, mouseY)) {
        feedbacks[j].clickOn = true;
      }
    } else {
      feedbacks[j].clickOn = false;
    }
  }
}

void drawIcon() {
  float sphereRot = 0.0;
  noLights();
  pushMatrix();
  translate(width/2, height/2);
  rotateY(radians(sphereRot));
  rotateX(radians(83));

  Iterator<HE_Face> fItr = noiseMesh.fItr();
  HE_Face f;
  int i = 0;
  colorMode(HSB);
  while (fItr.hasNext ()) {
    f = fItr.next();
    fill(155, 234*noise(frameCount/300.0 + i/7.0), 279*noise(frameCount/300.0 + i/7.0), 200); 
    //println(255*noise(frameCount/141.5 + i/7.61));
    noStroke();
    render.drawFace(f);
    i++;
  }
  sphereRot += 0.1;
  popMatrix();
}
