void setShaderParameters(float time) {

  shader.set("tile", Tile);
  shader.set("time", time);
  shader.set("rotate", Rotate);

  shader.set("Formula_A_Freq", Freq_0);
  shader.set("Formula_A_Amp", Amp_0);
  shader.set("Formula_A_Vel", Vel_0);
  shader.set("Formula_A_Modo", int(Formula_0));
  shader.set("Formula_A_Coords", Coords_0);
  shader.set("Formula_A_Cant", Cant_0);

  shader.set("Formula_B_Freq", Freq_1);
  shader.set("Formula_B_Amp", Amp_1);
  shader.set("Formula_B_Vel", Vel_1);
  shader.set("Formula_B_Modo", int(Formula_1));
  shader.set("Formula_B_Coords", Coords_1);
  shader.set("Formula_B_Cant", Cant_1);

  shader.set("Formula_C_Freq", Freq_2);
  shader.set("Formula_C_Amp", Amp_2);
  shader.set("Formula_C_Vel", Vel_2);
  shader.set("Formula_C_Modo", int(Formula_2));
  shader.set("Formula_C_Coords", Coords_2);
  shader.set("Formula_C_Cant", Cant_2);  

  shader.set("FaseR", FaseR);
  shader.set("FaseG", FaseG);
  shader.set("FaseB", FaseB);
  shader.set("PosX", PosX);
  shader.set("PosY", PosY);
}
