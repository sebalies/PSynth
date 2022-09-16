import controlP5.*;
import processing.video.*;
import spout.*;

Spout server;
Capture cam;
ControlP5 cp5;
DropdownList OSCSelect, paramSelect, formulaSelect, coordSelect;

PShader shader;
PImage img;
PGraphics canvasOut, canvasIN;
int W = 1280;
int H = 720;
boolean cree = false;

void settings() {
  size(W, H, P3D);
  PJOGL.profile=1;
}

void setup() {
  cp5 = new ControlP5(this);
  frameRate(30);
  controls();
  creaMenu();

  canvasIN = createGraphics(W, H, P2D);
  canvasOut = createGraphics(W, H, P2D);
  canvasOut.textureWrap(REPEAT);

  server = new Spout(this);

  server.createSender("Synth");
  server.setLogLevel(3);

  shader = loadShader("ShaderA.glsl");
  img = loadImage("L_AV.jpg");

  // CAMARA INPUT VIDEO
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
  //canvasIN = client.receiveTexture(canvasIN);
  canvasOut.image(cam, 0, 0, width, height);
  canvasOut.endDraw();

  if (SyphonOutOn) {
    server.sendTexture(canvasOut);
  }
  canvasOut.resetShader();
  //server.clear();
  image(canvasOut, 0, 0, width, height);
  showInfo();
}

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
