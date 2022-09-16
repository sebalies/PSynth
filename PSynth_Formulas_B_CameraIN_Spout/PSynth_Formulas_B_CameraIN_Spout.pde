import controlP5.*;
import processing.video.*;
import spout.*;

Spout server;

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

  canvasIN = createGraphics(W, H, P2D);
  canvasOut = createGraphics(W, H, P2D);
  canvasOut.textureWrap(REPEAT);

  server = new Spout(this);
  server.createSender("Synth");

  shader = loadShader("ShaderB.glsl");
  img = loadImage("test.jpg");

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    cam = new Capture(this, cameras[0]);
    cam.start();
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }

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
  canvasOut.image(cam, 0, 0, width, height);
  canvasOut.endDraw();

  if (SyphonOutOn) {
     server.sendTexture(canvasOut);
  }
  canvasOut.resetShader();
  image(canvasOut, 0, 0, width, height);
}
