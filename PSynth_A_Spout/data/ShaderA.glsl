#ifdef GL_ES
  precision mediump float;
precision mediump int;
#endif

  #define PROCESSING_TEXTURE_SHADER

  #define pi 3.14159265359

  uniform float time; 

varying vec4 vertTexCoord;
uniform sampler2D texture;
uniform vec2 rmult;
uniform vec2 gmult;
uniform vec2 bmult;
uniform float tile;
uniform float rotate;

uniform float Formula_A_Freq;
uniform float Formula_A_Amp;
uniform float Formula_A_Vel;
uniform int Formula_A_Modo;
uniform int Formula_A_Coords;
uniform float Formula_A_Cant;

uniform float Formula_B_Freq;
uniform float Formula_B_Amp;
uniform float Formula_B_Vel;
uniform int Formula_B_Modo;
uniform int Formula_B_Coords;
uniform float Formula_B_Cant;

uniform float Formula_C_Freq;
uniform float Formula_C_Amp;
uniform float Formula_C_Vel;
uniform int Formula_C_Modo;
uniform int Formula_C_Coords;
uniform float Formula_C_Cant;

uniform float FaseR;
uniform float FaseG;
uniform float FaseB;

uniform int Operation;


float map(float value, float inputMin, float inputMax, float outputMin, float outputMax) {
  return outputMin + (outputMax - outputMin) * (value - inputMin) / (inputMax - inputMin);
}

float formula(vec2 uv, float freq, float ampl, float vel, int modo, int coords, float fase, float cant) {
  float resultado=0.0;
  int _cant = int(cant);

  if (modo == 0) {
    if (coords == 0) {
      resultado = sin(uv.x * freq + time * vel + fase) * ampl;
    }
    if (coords == 1) {
      resultado = sin(uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 2) {
      resultado = sin(uv.x + uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 3) {
      resultado = sin(uv.x - uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 4) {
      float angulo;
      for (int x=0; x<cant; x++) {
        for (int y=0; y<_cant; y++) {
          vec2 pos = vec2((y/cant)+(0.5/cant), (x/cant)+(0.5/cant)) - uv;
          angulo = atan(pos.x, pos.y);

          resultado+= sin(angulo * floor(freq) + time * vel + fase) * ampl;
        }
      }
    }
    if (coords == 5) {
      float radio;
      for (int x=0; x<cant; x++) {
        for (int y=0; y<_cant; y++) {
          vec2 pos = vec2((y/cant)+(0.5/cant), (x/cant)+(0.5/cant)) - uv;
          radio = length(pos);

          resultado+= sin(radio * pi * freq + time * vel + fase) * ampl;
        }
      }
    }
  }
  if (modo == 1) {
    if (coords == 0) {
      resultado = cos(uv.x * freq + time * vel + fase) * ampl;
    }
    if (coords == 1) {
      resultado = cos(uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 2) {
      resultado = cos(uv.x + uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 3) {
      resultado = cos(uv.x - uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 4) {
      float angulo;
      for (int x=0; x<cant; x++) {
        for (int y=0; y<_cant; y++) {
          vec2 pos = vec2((y/cant)+(0.5/cant), (x/cant)+(0.5/cant)) - uv;
          angulo = atan(pos.x, pos.y);


          resultado+= cos(angulo * floor(freq) + time * vel + fase) * ampl;
        }
      }
    }
    if (coords == 5) {
      float radio;
      for (int x=0; x<cant; x++) {
        for (int y=0; y<_cant; y++) {
          vec2 pos = vec2((y/cant)+(0.5/cant), (x/cant)+(0.5/cant)) - uv;
          radio = length(pos);

          resultado+= sin(radio * pi * freq + time * vel + fase) * ampl;
        }
      }
    }
  }
  if (modo == 2) {
    if (coords == 0) {
      resultado = tan(uv.x * freq + time * vel + fase) * ampl;
    }
    if (coords == 1) {
      resultado = tan(uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 2) {
      resultado = tan(uv.x + uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 3) {
      resultado = tan(uv.x - uv.y * freq + time * vel + fase) * ampl;
    }
    if (coords == 4) {
      float angulo;
      for (int x=0; x<cant; x++) {
        for (int y=0; y<_cant; y++) {
          vec2 pos = vec2((y/cant)+(0.5/cant), (x/cant)+(0.5/cant)) - uv;
          angulo = atan(pos.x, pos.y);

          resultado+= tan(angulo * floor(freq) + time * vel + fase) * ampl;
        }
      }
    }
    if (coords == 5) {
      vec2 pos = vec2(0.5) - uv;
      float radio = length(pos);
      resultado = tan(radio * pi * freq + time * vel + fase) * ampl;
    }
  }
  return resultado;
}

mat2 rotate2d(float _angle) {
  return mat2(cos(_angle), -sin(_angle), 
    sin(_angle), cos(_angle));
}

mat2 scale(vec2 _scale) {
  return mat2(_scale.x, 0.0, 
    0.0, _scale.y);
}

void main(void) {  

  vec2 uv = vertTexCoord.st;

  uv-= vec2(0.5, 0.5);
  uv = rotate2d(time*rotate) * uv;
  uv = scale(vec2(tile)) * uv;
  uv+= vec2(0.5, 0.5);  

  vec2 pos = vec2(0.5, 0.5) - uv;
  float radio = length(pos);
  float angulo = atan(pos.x, pos.y);  

  vec2 pr = uv.st ;
  vec2 pg = uv.st ;
  vec2 pb = uv.st ;

  if (Operation == 0) {
    pr+= formula(pr, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseR, Formula_A_Cant) + 
      formula(pr, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseR, Formula_B_Cant ) +
      formula(pr, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseR, Formula_C_Cant);

    pg+= formula(pg, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseG, Formula_A_Cant) + 
      formula(pg, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseG, Formula_B_Cant) + 
      formula(pg, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseG, Formula_C_Cant);

    pb+= formula(pb, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseB, Formula_A_Cant) + 
      formula(pb, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseB, Formula_B_Cant) + 
      formula(pb, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseB, Formula_C_Cant);
  }
  if (Operation == 1) {
    pr+= formula(pr, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseR, Formula_A_Cant) - 
      formula(pr, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseR, Formula_B_Cant) -
      formula(pr, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseR, Formula_C_Cant);

    pg+= formula(pg, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseG, Formula_A_Cant) - 
      formula(pg, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseG, Formula_B_Cant) - 
      formula(pg, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseG, Formula_C_Cant);

    pb+= formula(pb, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseB, Formula_A_Cant) - 
      formula(pb, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseB, Formula_B_Cant) - 
      formula(pb, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseB, Formula_C_Cant);
  }
  if (Operation == 2) {
    pr+= formula(pr, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseR, Formula_A_Cant) * 
      formula(pr, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseR, Formula_B_Cant) *
      formula(pr, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseR, Formula_C_Cant);

    pg+= formula(pg, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseG, Formula_A_Cant) * 
      formula(pg, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseG, Formula_B_Cant) * 
      formula(pg, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseG, Formula_C_Cant);

    pb+= formula(pb, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseB, Formula_A_Cant) * 
      formula(pb, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseB, Formula_B_Cant) * 
      formula(pb, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseB, Formula_C_Cant);
  }
  if (Operation == 3) {
    pr+= formula(pr, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseR, Formula_A_Cant) / 
      formula(pr, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseR, Formula_B_Cant) /
      formula(pr, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseR, Formula_C_Cant);

    pg+= formula(pg, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseG, Formula_A_Cant) / 
      formula(pg, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseG, Formula_B_Cant) / 
      formula(pg, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseG, Formula_C_Cant);

    pb+= formula(pb, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, Formula_A_Coords, FaseB, Formula_A_Cant) / 
      formula(pb, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, Formula_B_Coords, FaseB, Formula_B_Cant) / 
      formula(pb, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, Formula_C_Coords, FaseB, Formula_C_Cant);
  }

  float r = texture2D(texture, pr).r;
  float g = texture2D(texture, pg).g;
  float b = texture2D(texture, pb).b;

  gl_FragColor = vec4(r, g, b, 1.0);
}
