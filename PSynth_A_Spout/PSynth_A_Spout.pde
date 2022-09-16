import controlP5.*;
import processing.video.*;
import spout.*;

Spout server;
Spout client;

Capture cam;
ControlP5 cp5;
DropdownList OSCSelect, paramSelect, formulaSelect, coordSelect;

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

  client = new Spout(this);
  server = new Spout(this);

  server.createSender("PSynth");

  canvasIN = createGraphics(W, H, P2D);
  canvasOut = createGraphics(W, H, P2D);
  canvasOut.textureWrap(REPEAT);

  shader = loadShader("ShaderA.glsl");
  img = loadImage("L_AV.jpg");
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
  canvasOut.endDraw();

  if (SyphonOutOn) {
    server.sendTexture(canvasOut);
  }
  canvasOut.resetShader();
  image(canvasOut, 0, 0, width, height);
}

void mousePressed() {
  // RH click to select a sender
  if (mouseButton == RIGHT) {
    client.selectSender();
  }
}
