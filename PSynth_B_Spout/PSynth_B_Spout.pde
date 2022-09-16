import controlP5.*;
import processing.video.*;
import spout.*;

Spout server;
Spout client;
Capture cam;
ControlP5 cp5;
DropdownList OSCSelect, paramSelect, formulaSelect;

PShader shader;
PImage img;
PGraphics canvasOut, canvasIN;
int cuantos;
int W = 1280;
int H = 720;
boolean cree = false;

void settings() {
  size(W, H, P2D);
  PJOGL.profile=1;
}

void setup() {
  cp5 = new ControlP5(this);
  controls();
  creaMenu();

  server = new Spout(this);
  //client = new Spout(this);

  //server.createSender("Synth");

  canvasIN = createGraphics(W, H, P2D);
  canvasOut = createGraphics(W, H, P2D);
  canvasOut.textureWrap(REPEAT);

  shader = loadShader("ShaderB.glsl");
  img = loadImage("test.jpg");
}

void draw() {
  OSCGenerate();
  TIMELINEGenerate();
  checkeaMenu();

  if (cree) {
    checkeaControl();
  }

  float time =  millis() / 1000.0;
  setShaderParameters(time);

  canvasOut.beginDraw();
  canvasOut.shader(shader);
  //canvasIN = client.receiveTexture(canvasIN);
  canvasOut.image(img, 0, 0, width, height);
  //canvasOut.image(canvasIN, 0, 0, width, height);
  canvasOut.endDraw();
 
  if (SyphonOutOn) {
    server.sendTexture(canvasOut);
  }
  
  canvasOut.resetShader();
  image(canvasOut, 0, 0, width, height);
  //SyphonClient.listServers();
  showInfo();
}

//void syphonComprueba() {
//  if (client.newFrame()) {
//    canvasIN = client.getGraphics(canvasIN);
//    canvasOut.image(canvasIN, 0, 0, width, height);
//  } else {
//    canvasOut.image(img, 0, 0, width, height);
//  }
//}

//void mousePressed() {
//  if (mouseButton == RIGHT) {
//    client.selectSender();
//  }
//}


void showInfo() {

  fill(255);
  textAlign(RIGHT);
  text(round(frameRate) + " - FPS", width - 30, height - 50);
  //if (client.isReceiverConnected()) {
  //  // Report sender fps and frame number if the option is activated
  //  // Applications < Spout 2.007 will have no frame information
  //  if (client.getSenderFrame() > 0) {
  //    text("Receiving from : " + client.getSenderName() + "  ("
  //      + client.getSenderWidth() + "x"
  //      + client.getSenderHeight() + ") - fps "
  //      + client.getSenderFps() + " : frame "
  //      + client.getSenderFrame(), width - 30, height - 30);
  //  } else {
  //    text("Receiving from : " + client.getSenderName() + "  ("
  //      + client.getSenderWidth() + "x"
  //      + client.getSenderHeight() + ")", width - 30, height - 30);
  //  }
  //} else {
  //  text("No sender", width - 30, height - 30);
  //}
}


void mousePressed() {
  // SELECT A SPOUT SENDER
  if (mouseButton == RIGHT) {
    // Bring up a dialog to select a sender.
    // SpoutSettings must have been run at least once
    // to establish the location of "SpoutPanel"
    client.selectSender();
  }
}
