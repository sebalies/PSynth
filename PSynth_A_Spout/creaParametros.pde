int cantParametros = 0;

void creaParametro(String name, float posX, float posY, float rangeMin, float rangeMax, float value) {

  posX = posX + 40;

  paramSelect =  cp5.addDropdownList(name+"_Modo")
    .setPosition(posX, posY)
    .setSize(30, 200)
    .setColorActive(ColorActive)
    .setColorForeground(ColorActive)
    .setColorBackground(ColorBackground)
    ; 

  customizeParamSelect(paramSelect);

  cp5.addSlider(name)
    .setLabel(name)
    .setPosition(posX + 40, posY)
    .setValue(value)
    .setRange(rangeMin, rangeMax)
    .setSize(80, 15)
    ;
  cp5.addSlider(name + "_MIN")
    .setLabel("")
    .setPosition(posX + 160, posY)
    .setValue(rangeMin)
    .setRange(rangeMin, rangeMax)
    .setSize(60, 15)
    .setVisible(false)
    .setColorActive(ColorActive)
    .setColorForeground(ColorActive)
    .setColorBackground(ColorBackground)
    ;
  cp5.addSlider(name + "_MAX")
    .setLabel("")
    .setPosition(posX + 240, posY)
    .setValue(rangeMax)
    .setRange(rangeMin, rangeMax)
    .setSize(60, 15)
    .setVisible(false)
    .setColorActive(ColorActive)
    .setColorForeground(ColorActive)
    .setColorBackground(ColorBackground)
    ;

  cantParametros = cantParametros + 1;
}

void customizeParamSelect(DropdownList ddl) {
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(10);
  ddl.setBarHeight(10);
  ddl.getCaptionLabel().set("-");
  ddl.addItem("-", 0);
  ddl.addItem("OSC 1", 1);
  ddl.addItem("OSC 2", 2);
  ddl.addItem("OSC 3", 3);
  ddl.addItem("TIME", 3);
  ddl.close();
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
