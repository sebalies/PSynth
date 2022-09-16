color OSC1BackgroundColor, OSC2BackgroundColor, OSC3BackgroundColor = color(20);
color OSC1ColorActive = color(250, 0, 0);
color OSC1ColorForeground = color(150, 80, 80);
color OSC1ColorBackground = color(70, 20, 20);

color OSC2ColorActive = color(0, 250, 0);
color OSC2ColorForeground = color(80, 150, 80);
color OSC2ColorBackground = color(20, 70, 20);

color OSC3ColorActive = color(0, 0, 250);
color OSC3ColorForeground = color(80, 80, 150);
color OSC3ColorBackground = color(20, 20, 70);

color TIMELINE1BackgroundColor = color(20);
color TIMELINE1ColorActive = color(250, 250, 0);
color TIMELINE1ColorForeground = color(150, 150, 80);
color TIMELINE1ColorBackground = color(70, 70, 20);

color BackgroundColor = color(20);
color ColorActive = color(150);
color ColorForeground = color(100);
color ColorBackground = color(40);

int OSC1Select, OSC2Select, OSC3Select, TIMELINE1Select;

float OSC_Y = H - 120;
float OSC_X_1 = 80;
float OSC_X_2 = OSC_X_1 + 100;
float OSC_X_3 = OSC_X_2 + 100;
float OSC_X_4 = OSC_X_3 + 100;

boolean SyphonOutOn = false;
String SyphonServerTxt = "Simple Server";

float FaseR, FaseG, FaseB;
float PosX, PosY;

float Tile = 1.0;
float Rotate;

int XcolParam = 80;
int XcolParam2 = 250;
int XcolParam3 = 430;

void controls() {
  
  cp5.addButton("AddParamBot")  // ADD PARAMETROS ----------------------
    .setLabel("+")
    .setPosition(0, 0)
    .setSize(20, 20)
    .setColorActive(OSC1ColorActive)
    .setColorForeground(OSC1ColorForeground)
    .setColorBackground(OSC1ColorBackground)
    ;

  // SYPHON- - - - - - - - - - - - - - - - - - 

  //cp5.addTextfield("SyphonServerTxt")
  //  .setLabel("Syphon Server In")
  //  .setValue("Simple Server")
  //  .setPosition(W-270, 20)
  //  .setSize(200, 20)
  //  .setAutoClear(false)
  //  .setColorActive(ColorActive)
  //  .setColorForeground(ColorActive)
  //  .setColorBackground(ColorBackground)
  //  ;
  //cp5.addBang("SyphonServerTxtClear")
  //  .setLabel("clear")
  //  .setPosition(W-70, 20)
  //  .setSize(50, 20)
  //  .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
    
  //  ;   

  cp5.addToggle("SyphonOutOn")
    .setLabel("spout out")
    .setPosition(W-70, 50)
    .setSize(50, 20)
    .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)

    ;

  // -------------------------------------------- OSCILATORS ----------------------------------------------------------------------------------------



  cp5.addTextlabel("OSC1_label")  // OSC 1 ----------------------
    .setText("OSCILATOR 1")
    .setPosition(OSC_X_1-2, OSC_Y + 10)
    .setColorValue(0xffffffff)
    ;  

  cp5.addSlider("OSC_1_Preview") 
    .setLabel("OSC 1")
    .setLabelVisible(false)
    .setPosition(OSC_X_1, OSC_Y)
    .setSize(50, 4)
    .setRange(0, max)
    .setColorActive(OSC1ColorActive)
    .setColorForeground(OSC1ColorActive)
    .setColorBackground(OSC1ColorBackground)
    ;

  cp5.addSlider("OSC1_Value_Rate")  
    .setLabel("RATE")
    .setPosition(OSC_X_1, OSC_Y + 50)
    .setRange(0, 1)
    .setSize(50, 10)
    .setValue(0.01)
    .setColorActive(OSC1ColorActive)
    .setColorForeground(OSC1ColorForeground)
    .setColorBackground(OSC1ColorBackground)
    ;  
  cp5.addSlider("OSC1_Value_Offset")  
    .setLabel("Offset")
    .setPosition(OSC_X_1, OSC_Y + 70)
    .setRange(0, 2)
    .setSize(50, 10)
    .setValue(0)
    .setColorActive(OSC1ColorActive)
    .setColorForeground(OSC1ColorForeground)
    .setColorBackground(OSC1ColorBackground)
    ;  

  OSCSelect = cp5.addDropdownList("OSC1Select")
    .setLabel("Sin")
    .setPosition(OSC_X_1, OSC_Y + 25)
    .setSize(50, 100)  
    .setColorActive(OSC1ColorActive)
    .setColorForeground(OSC1ColorForeground)
    .setColorBackground(OSC1ColorBackground)
    ; 
  OSCSelect.close();
  customizeOSCSelect(OSCSelect);


  cp5.addTextlabel("OSC2_label")  // OSC 2 ----------------------
    .setText("OSCILATOR 2")
    .setPosition(OSC_X_2-2, OSC_Y + 10)
    .setColorValue(0xffffffff)
    ;  

  cp5.addSlider("OSC_2_Preview") 
    .setLabel("OSC 2")
    .setLabelVisible(false)
    .setPosition(OSC_X_2, OSC_Y)
    .setSize(50, 4)
    .setRange(0, max)
    .setColorActive(OSC2ColorActive)
    .setColorForeground(OSC2ColorActive)
    .setColorBackground(OSC2ColorBackground)
    ;

  cp5.addSlider("OSC2_Value_Rate")  
    .setLabel("RATE")
    .setPosition(OSC_X_2, OSC_Y + 50)
    .setRange(0, 1)
    .setSize(50, 10)
    .setValue(0.01)
    .setColorActive(OSC2ColorActive)
    .setColorForeground(OSC2ColorForeground)
    .setColorBackground(OSC2ColorBackground)
    ;  
  cp5.addSlider("OSC2_Value_Offset")  
    .setLabel("Offset")
    .setPosition(OSC_X_2, OSC_Y + 70)
    .setRange(0, 2)
    .setSize(50, 10)
    .setValue(0)
    .setColorActive(OSC2ColorActive)
    .setColorForeground(OSC2ColorForeground)
    .setColorBackground(OSC2ColorBackground)
    ;  

  OSCSelect = cp5.addDropdownList("OSC2Select")
    .setLabel("Sin")
    .setPosition(OSC_X_2, OSC_Y + 25)
    .setSize(50, 100)  
    .setColorActive(OSC2ColorActive)
    .setColorForeground(OSC2ColorForeground)
    .setColorBackground(OSC2ColorBackground)
    ; 
  OSCSelect.close();
  customizeOSCSelect(OSCSelect);


  cp5.addTextlabel("OSC3_label")  // OSC 3 ----------------------
    .setText("OSCILATOR 3")
    .setPosition(OSC_X_3-2, OSC_Y + 10)
    .setColorValue(0xffffffff)
    ;  

  cp5.addSlider("OSC_3_Preview") 
    .setLabel("OSC 3")
    .setLabelVisible(false)
    .setPosition(OSC_X_3, OSC_Y)
    .setSize(50, 4)
    .setRange(0, max)
    .setColorActive(OSC3ColorActive)
    .setColorForeground(OSC3ColorActive)
    .setColorBackground(OSC3ColorBackground)
    ;

  cp5.addSlider("OSC3_Value_Rate")  
    .setLabel("RATE")
    .setPosition(OSC_X_3, OSC_Y + 50)
    .setRange(0, 1)
    .setSize(50, 10)
    .setValue(0.01)
    .setColorActive(OSC3ColorActive)
    .setColorForeground(OSC3ColorForeground)
    .setColorBackground(OSC3ColorBackground)
    ; 
  cp5.addSlider("OSC3_Value_Offset")  
    .setLabel("Offset")
    .setPosition(OSC_X_3, OSC_Y + 70)
    .setRange(0, 2)
    .setSize(50, 10)
    .setValue(0)
    .setColorActive(OSC3ColorActive)
    .setColorForeground(OSC3ColorForeground)
    .setColorBackground(OSC3ColorBackground)
    ;  

  OSCSelect = cp5.addDropdownList("OSC3Select")
    .setLabel("Sin")
    .setPosition(OSC_X_3, OSC_Y + 25)
    .setSize(50, 100)  
    .setColorActive(OSC3ColorActive)
    .setColorForeground(OSC3ColorForeground)
    .setColorBackground(OSC3ColorBackground)
    ; 
  OSCSelect.close();
  customizeOSCSelect(OSCSelect);


  // -------------------------------------------- TIMELINE ----------------------------------------------------------------------------------------



  cp5.addTextlabel("TIMELINE_1_label")  // OSC 1 ----------------------
    .setText("TIMELINE 1")
    .setPosition(OSC_X_4, OSC_Y + 10)
    .setColorValue(0xffffffff)
    ;  

  cp5.addSlider("TIMELINE_1_Preview") 
    .setLabel("OSC 1")
    .setLabelVisible(false)
    .setPosition(OSC_X_4, OSC_Y)
    .setSize(50, 4)
    .setRange(0, max)
    .setColorActive(TIMELINE1ColorActive)
    .setColorForeground(TIMELINE1ColorActive)
    .setColorBackground(TIMELINE1ColorBackground)
    ;

  cp5.addSlider("TIMELINE_1_Speed")  
    .setLabel("SPEED")
    .setPosition(OSC_X_4, OSC_Y + 50)
    .setRange(-0.1, 0.1)
    .setSize(50, 10)
    .setValue(0.01)
    .setColorActive(TIMELINE1ColorActive)
    .setColorForeground(TIMELINE1ColorForeground)
    .setColorBackground(TIMELINE1ColorBackground)
    ;  

  cp5.addToggle("TIMELINE_RandBot")  // ADD PARAMETROS ----------------------
    .setLabel("")
    .setPosition(OSC_X_4, OSC_Y + 70)
    .setSize(10, 10)
    .setColorActive(TIMELINE1ColorActive)
    .setColorForeground(TIMELINE1ColorForeground)
    .setColorBackground(TIMELINE1ColorBackground)
    ;
  cp5.addTextlabel("TIMELINE_RandBot_label")
    .setText("R")
    .setPosition(OSC_X_4-2, OSC_Y + 70 +1)
    .setColorValue(0xffffffff)
    ;
}

//void customizeModo(DropdownList ddl) {
//  ddl.setBackgroundColor(color(190));
//  ddl.setItemHeight(20);
//  ddl.setBarHeight(15);
//  ddl.getCaptionLabel().set("0");

//  ddl.addItem("0", 0);
//  ddl.addItem("1", 1);
//  ddl.addItem("2", 2);
//  ddl.addItem("3", 3);
//  ddl.addItem("4", 4);
//  ddl.addItem("5", 5);
//  ddl.addItem("6", 6);
//  ddl.addItem("7", 7);
//  ddl.addItem("8", 8);
//  ddl.addItem("9", 9);
//  ddl.close();
//  ddl.setColorBackground(color(60));
//  ddl.setColorActive(color(255, 128));
//}

void customizeOSCSelect(DropdownList ddl) {
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.addItem("Sin", 0);
  ddl.addItem("Cos", 1);
  ddl.addItem("Tan", 2);
  ddl.addItem("-Tan", 3);
}

//void controlEvent(ControlEvent theEvent) {
//  if (theEvent.isAssignableFrom(Textfield.class)) {
//    println("controlEvent: accessing a string from controller '"
//      +theEvent.getName()+"': "
//      +theEvent.getStringValue()
//      );
//    client = new SyphonClient(this, SyphonServerTxt, "");
//    syphonComprueba();
//  }
//}

//public void SyphonServerTxtClear() {
//  cp5.get(Textfield.class, "SyphonServerTxt").clear();
//}
