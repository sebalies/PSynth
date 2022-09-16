int posicionX = 20;
int posicionY = 300;

int cantidadParametros = 7;
int espacioParametros = 20;

String[] MenuTitles = {  "FaseB", "FaseG", "FaseR", "PosY", "PosX", "Rotate", "Tile"};
float[] MenuRMin =  {    -1.0, -1.0, -1.0, -0.5, -0.5, -1.0, 0.0};
float[] MenuRMax = {      1.0, 1.0, 1.0, 0.5, 0.5, 1.0, 50.0};
float[] MenuValue = {     0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0};

void creaMenu() {
  for (int x = 0; x < cantidadParametros; x ++) {
    creaParametro(MenuTitles[x], posicionX, (posicionY+(cantidadParametros*espacioParametros)) - (x * espacioParametros), MenuRMin[x], MenuRMax[x], MenuValue[x]);
  }
}

void checkeaMenu() {
  for (int x = 0; x < cantidadParametros; x ++) {
    chequeaModo(MenuTitles[x]);
    asignaParam(MenuTitles[x]);
  }
}

float[] leeModoParam = new float [1];
int cuantosParam;

void chequeaModo(String name) {
  cuantosParam = cantParametros;

  if (cuantosParam >=1) {
    for (int check = 0; check < cuantosParam; check++) {
      float modo = 0;

      leeModoParam = (float[]) append(leeModoParam, int(modo));
      leeModoParam[check] = cp5.get(DropdownList.class, name + "_Modo") .getValue();
    }
  }
}


void asignaParam(String name) {
  for (int x = 0; x < cuantosParam; x++) {
    float min = cp5.get(Slider.class, name + "_MIN") .getValue();
    float max = cp5.get(Slider.class, name + "_MAX") .getValue();

    if (leeModoParam[x] == 1) {
      cp5.get(Slider.class, name) .setColorActive(OSC1ColorActive);
      cp5.get(Slider.class, name).setColorForeground(OSC1ColorActive);
      cp5.get(Slider.class, name) .setColorBackground(OSC1ColorBackground);

      cp5.get(Slider.class, name + "_MIN") . setVisible(true); 
      cp5.get(Slider.class, name + "_MAX") . setVisible(true); 
      cp5.get(Slider.class, name) .setValue(map(OSC1_Value, 0, 1, min, max));
    } else if (leeModoParam[x] == 2) {
      cp5.get(Slider.class, name) .setColorActive(OSC2ColorActive);
      cp5.get(Slider.class, name).setColorForeground(OSC2ColorActive);
      cp5.get(Slider.class, name) .setColorBackground(OSC2ColorBackground);

      cp5.get(Slider.class, name + "_MIN") . setVisible(true); 
      cp5.get(Slider.class, name + "_MAX") . setVisible(true); 
      cp5.get(Slider.class, name) .setValue(map(OSC2_Value, 0, 1, min, max));
    } else if (leeModoParam[x] == 3) {
      cp5.get(Slider.class, name) .setColorActive(OSC3ColorActive);
      cp5.get(Slider.class, name).setColorForeground(OSC3ColorActive);
      cp5.get(Slider.class, name) .setColorBackground(OSC3ColorBackground);

      cp5.get(Slider.class, name + "_MIN") . setVisible(true); 
      cp5.get(Slider.class, name + "_MAX") . setVisible(true); 
      cp5.get(Slider.class, name) .setValue(map(OSC3_Value, 0, 1, min, max));
    } else if (leeModoParam[x] == 4) {
      cp5.get(Slider.class, name) .setColorActive(TIMELINE1ColorActive);
      cp5.get(Slider.class, name) .setColorForeground(TIMELINE1ColorActive);
      cp5.get(Slider.class, name) .setColorBackground(TIMELINE1ColorBackground);

      cp5.get(Slider.class, name + "_MIN") . setVisible(true); 
      cp5.get(Slider.class, name + "_MAX") . setVisible(true); 
      cp5.get(Slider.class, name) .setValue(map(TIMELINE_Value, 0, 1, min, max));
    } else if (leeModoParam[x] == 0) {
      cp5.get(Slider.class, name + "_MIN") . setVisible(false); 
      cp5.get(Slider.class, name + "_MAX") . setVisible(false);

      cp5.get(Slider.class, name) .setColorActive(ColorActive);
      cp5.get(Slider.class, name) .setColorForeground(ColorForeground);
      cp5.get(Slider.class, name) .setColorBackground(ColorBackground);
    }
  }
}
