float OSC1_Value, OSC2_Value, OSC3_Value, OSC1_Value_Angle, OSC2_Value_Angle, OSC3_Value_Angle, OSC1_Value_Offset, OSC2_Value_Offset, OSC3_Value_Offset;
float TIMELINE_Value, TIMELINE_1_Speed;
float OSC1_Value_Rate, OSC2_Value_Rate, OSC3_Value_Rate = 0.01;
float min = 0.0;
float max = 1.0;
float time = 0;
int TIMELINE_RandBot = 0;

void OSCGenerate() {
  if (OSC1Select == 0) { 
    OSC1_Value = (map(sin(OSC1_Value_Angle + OSC1_Value_Offset), -1, 1, min, max));
  }
  if (OSC1Select == 1) { 
    OSC1_Value = (map(cos(OSC1_Value_Angle + OSC1_Value_Offset), -1, 1, min, max));
  }
  if (OSC1Select == 2) { 
    OSC1_Value = (map(tan(OSC1_Value_Angle + OSC1_Value_Offset), -1, 1, min, max));
  }  
  if (OSC1Select == 3) { 
    OSC1_Value = (map(tan(OSC1_Value_Angle + OSC1_Value_Offset), -1, 1, max, min));
  }  


  if (OSC2Select == 0) { 
    OSC2_Value = (map(sin(OSC2_Value_Angle + OSC2_Value_Offset), -1, 1, min, max));
  }
  if (OSC2Select == 1) { 
    OSC2_Value = (map(cos(OSC2_Value_Angle + OSC2_Value_Offset), -1, 1, min, max));
  }
  if (OSC2Select == 2) { 
    OSC2_Value = (map(tan(OSC2_Value_Angle + OSC2_Value_Offset), -1, 1, min, max));
  }  
  if (OSC2Select == 3) { 
    OSC2_Value = (map(tan(OSC2_Value_Angle + OSC2_Value_Offset), -1, 1, max, min));
  } 


  if (OSC3Select == 0) { 
    OSC3_Value = (map(sin(OSC3_Value_Angle + OSC3_Value_Offset), -1, 1, min, max));
  }
  if (OSC3Select == 1) { 
    OSC3_Value = (map(cos(OSC3_Value_Angle + OSC3_Value_Offset), -1, 1, min, max));
  }
  if (OSC3Select == 2) { 
    OSC3_Value = (map(tan(OSC3_Value_Angle + OSC3_Value_Offset), -1, 1, min, max));
  }  
  if (OSC3Select == 3) { 
    OSC3_Value = (map(tan(OSC3_Value_Angle + OSC3_Value_Offset), -1, 1, max, min));
  } 


  cp5.get(Slider.class, "OSC_1_Preview") .setValue(OSC1_Value);
  cp5.get(Slider.class, "OSC_2_Preview") .setValue(OSC2_Value);
  cp5.get(Slider.class, "OSC_3_Preview") .setValue(OSC3_Value);

  OSC1_Value_Angle += (OSC1_Value_Rate/2.);
  OSC2_Value_Angle += (OSC2_Value_Rate/2.);
  OSC3_Value_Angle += (OSC3_Value_Rate/2.);
}

void TIMELINEGenerate() {

  TIMELINE_Value = (TIMELINE_Value+TIMELINE_1_Speed) % 1;

  if (TIMELINE_Value < 0) {      // SENTIDO VELOCIDAD
    TIMELINE_Value = map(TIMELINE_Value, -1, 0, min, max);
  }
  if (TIMELINE_RandBot == 1) {
    TIMELINE_Value = random(0, 1);
  }
  cp5.get(Slider.class, "TIMELINE_1_Preview") .setValue(TIMELINE_Value);
}
