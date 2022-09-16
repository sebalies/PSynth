float Freq_0, Amp_0, Vel_0, Cant_0, Formula_0;
float Freq_1, Amp_1, Vel_1, Cant_1, Formula_1;
float Freq_2, Amp_2, Vel_2, Cant_2, Formula_2;
int Coords_0, Coords_1, Coords_2, Coords_3, Coords_4, Coords_5, Coords_6, Coords_7;

int grupoCantidad = 0;

int controlPosX = 20;
int controlPosY = 20;

int cantidadControles = 4;
int[] rengControles = new int[cantidadControles];

int cantidadGrupos = 3;
int[] rengGrupos = new int[cantidadGrupos];
int[] grupos = new int[cantidadGrupos];
int espacioGrupos = 120;

int espacioControles = 20;

String[] controlTitles = {  "Cant", "Vel",   "Amp", "Freq"};
float[] controlesRMin = {    1.0,   -10.0,   -1.0,   0.0};
float[] controlesRMax = {    10.0,   10.0,    1.0,   50.0};
float[] controlesValue = {   1.0,    0.0,    0.0,    0.0};

float posYFormula = 0;


void AddParamBot() {
  if (grupoCantidad < 3) {

    coordSelect = cp5.addDropdownList("Coords_" + grupoCantidad)
      .setPosition(controlPosX, (controlPosY + 20) + (grupoCantidad * 100 ))
      .setSize(30, 200)
      .setColorActive(ColorActive)
      .setColorForeground(ColorActive)
      .setColorBackground(ColorBackground)
      ; 
    customizeCoordSelect(coordSelect);
    
    println("Coords_" + grupoCantidad);

    formulaSelect = cp5.addDropdownList("Formula_" + grupoCantidad)
      .setPosition(controlPosX, controlPosY + (grupoCantidad * 100 ))
      .setSize(30, 200)
      .setColorActive(ColorActive)
      .setColorForeground(ColorActive)
      .setColorBackground(ColorBackground)
      ; 
    customFormulaSelect(formulaSelect);

    for (int i=0; i < cantidadControles; i++) {
      rengControles[i]=controlPosY+(espacioControles*i);
      float total = cantidadControles * espacioControles;

      //float rePosY = (grupoCantidad * (espacioControles * (cantidadControles + 1))) + rengControles[i];
      float rePosY =  ((controlPosY + total) - rengControles[i])+(grupoCantidad*100);

      creaParametro(controlTitles[i]+"_"+grupoCantidad, controlPosX, rePosY, controlesRMin[i], controlesRMax[i], controlesValue[i]);
    }
    grupoCantidad = grupoCantidad + 1;
    cree = true;
  }
}

void checkeaControl() {
  for (int x = 0; x < cantidadControles; x ++) { 
    chequeaModoControles(controlTitles[x]);
    asignaControles(controlTitles[x]);
  }
}

float[] leeModoControles = new float [1];
int cuantosControles;

void chequeaModoControles(String name) {
  cuantosControles = 4;

  if (grupoCantidad >=1) {
    for (int check = 0; check < grupoCantidad; check++) {
      float modo = 0;

      leeModoControles = (float[]) append(leeModoControles, int(modo));
      leeModoControles[check] = cp5.get(DropdownList.class, name + "_"+ check + "_Modo") .getValue();
    }
  }
}

void asignaControles(String name) {

  for (int x = 0; x < grupoCantidad; x++) {

    float min = cp5.get(Slider.class, name + "_" + x + "_MIN") .getValue();
    float max = cp5.get(Slider.class, name + "_" + x + "_MAX") .getValue();

    if (leeModoControles[x] == 1) {
      cp5.get(Slider.class, name + "_" + x ) .setColorActive(OSC1ColorActive);
      cp5.get(Slider.class, name + "_" + x ).setColorForeground(OSC1ColorActive);
      cp5.get(Slider.class, name + "_" + x ) .setColorBackground(OSC1ColorBackground);

      cp5.get(Slider.class, name + "_" + x + "_MIN") . setVisible(true); 
      cp5.get(Slider.class, name + "_" + x + "_MAX") . setVisible(true); 
      cp5.get(Slider.class, name + "_" + x ) .setValue(map(OSC1_Value, 0, 1, min, max));
    } else if (leeModoControles[x] == 2) {
      cp5.get(Slider.class, name + "_" + x ) .setColorActive(OSC2ColorActive);
      cp5.get(Slider.class, name + "_" + x ).setColorForeground(OSC2ColorActive);
      cp5.get(Slider.class, name + "_" + x ) .setColorBackground(OSC2ColorBackground);

      cp5.get(Slider.class, name + "_" + x + "_MIN") . setVisible(true); 
      cp5.get(Slider.class, name + "_" + x + "_MAX") . setVisible(true); 
      cp5.get(Slider.class, name + "_" + x) .setValue(map(OSC2_Value, 0, 1, min, max));
    } else if (leeModoControles[x] == 3) {
      cp5.get(Slider.class, name + "_" + x ) .setColorActive(OSC3ColorActive);
      cp5.get(Slider.class, name + "_" + x ).setColorForeground(OSC3ColorActive);
      cp5.get(Slider.class, name + "_" + x ) .setColorBackground(OSC3ColorBackground);

      cp5.get(Slider.class, name + "_" + x + "_MIN") . setVisible(true); 
      cp5.get(Slider.class, name + "_" + x + "_MAX") . setVisible(true); 
      cp5.get(Slider.class, name + "_" + x) .setValue(map(OSC3_Value, 0, 1, min, max));
    } else if (leeModoControles[x] == 4) {
      cp5.get(Slider.class, name + "_" + x ) .setColorActive(TIMELINE1ColorActive);
      cp5.get(Slider.class, name + "_" + x ) .setColorForeground(TIMELINE1ColorActive);
      cp5.get(Slider.class, name + "_" + x ) .setColorBackground(TIMELINE1ColorBackground);

      cp5.get(Slider.class, name + "_" + x + "_MIN") . setVisible(true); 
      cp5.get(Slider.class, name + "_" + x + "_MAX") . setVisible(true); 
      cp5.get(Slider.class, name + "_" + x) .setValue(map(TIMELINE_Value, 0, 1, min, max));
    } else if (leeModoControles[x] == 0) {
      cp5.get(Slider.class, name + "_" + x + "_MIN") . setVisible(false); 
      cp5.get(Slider.class, name + "_" + x + "_MAX") . setVisible(false);

      cp5.get(Slider.class, name + "_" + x ) .setColorActive(ColorActive);
      cp5.get(Slider.class, name + "_" + x ) .setColorForeground(ColorForeground);
      cp5.get(Slider.class, name + "_" + x ) .setColorBackground(ColorBackground);
    }
  }
}

void customFormulaSelect(DropdownList ddl) {
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("sin");
  ddl.addItem("sin", 0);
  ddl.addItem("cos", 1);
  ddl.addItem("tan", 2);
  ddl.close();
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void customizeCoordSelect(DropdownList ddl) {
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(10);
  ddl.setBarHeight(10);
  ddl.getCaptionLabel().set("x");
  ddl.addItem("x", 0);
  ddl.addItem("y", 1);
  ddl.addItem("x+y", 2);
  ddl.addItem("x-y", 3);
  ddl.addItem("ang", 4);
  ddl.addItem("rad", 5);
  ddl.close();
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
