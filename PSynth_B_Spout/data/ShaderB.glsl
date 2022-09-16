#ifdef GL_ES
  precision mediump float;
precision mediump int;
#endif

  #define PROCESSING_TEXTURE_SHADER

#define pi 3.14159265359


uniform float time; 

uniform vec2 resolution;
uniform vec4 vertTexCoord;
uniform sampler2D texture;

uniform float tile;
uniform float rotate;

uniform float Formula_A_Freq;
uniform float Formula_A_Amp;
uniform float Formula_A_Vel;
uniform int Formula_A_Modo;
uniform float Formula_A_Cant;

uniform float Formula_B_Freq;
uniform float Formula_B_Amp;
uniform float Formula_B_Vel;
uniform int Formula_B_Modo;
uniform float Formula_B_Cant;

uniform float Formula_C_Freq;
uniform float Formula_C_Amp;
uniform float Formula_C_Vel;
uniform int Formula_C_Modo;
uniform float Formula_C_Cant;

uniform float FaseR;
uniform float FaseG;
uniform float FaseB;

uniform float PosX;
uniform float PosY;


uniform int Operation;


float map(float value, float inputMin, float inputMax, float outputMin, float outputMax) {
  return outputMin + (outputMax - outputMin) * (value - inputMin) / (inputMax - inputMin);
}

vec2 formula(vec2 uv, float freq, float ampl, float vel, int modo, float fase, float cant) {
  vec2 resultado = vec2(0.0,0.0);
  int _cant = int(cant);

  if (modo == 0) {
  
      vec2 forma = vec2(pow(max(0.0, abs(1.0 - uv.x) * 2.0 - 1.0), 1.0) + pow(max(0.0, abs(uv.x) * 2.0 - 1.0), 1.0));
      //forma*= vec2(sin(forma.x * freq + time * vel + fase) * ampl, cos(forma.y * freq + time * vel + fase))  * ampl;
	forma*= vec2(tan(forma.x * freq + time * vel + fase) * ampl, cos(forma.y * freq + time * vel + fase))  * ampl;
      
      resultado = vec2(forma);    
      }
    if (modo == 1) {
    
      float forma = pow(max(0.0, abs(1.0 - uv.x * uv.y) * 2.0 - 1.0), 3.0) + pow(max(0.0, abs(uv.x) * 2.0 - 1.0), 3.0);
      //forma= 1.0 - forma;
      forma*=sin(forma * freq + time * vel + fase) * ampl;
      resultado = vec2(forma);   
    }
    if (modo == 2) {
       float forma = pow(max(0.0, abs(1.0 - uv.x * uv.y) * 2.0 - 1.0), 8.0) - pow(max(0.0, abs(uv.x-uv.y) * 2.0 - 1.0), 3.0);
      forma= 1.0 - forma;
      forma*=tan(forma * freq + time * vel + fase) * ampl;
      resultado = vec2(forma);   
    }
    if (modo == 3) {
    float forma = sin(pow(abs(uv.x), 1.0) * freq * pi + time * vel + fase) * ampl;
            forma*=sin(pow(abs(uv.y), 4.0) * freq * pi) * ampl;
            resultado = vec2(forma);   
    }
    if (modo == 4) {
    	float forma = pow(min(cos(pi * uv.y * freq / 2.0 + time * vel + fase), 1.0 - abs(uv.x)),3.0) * ampl;
    	resultado = vec2(forma);   
    }
    if (modo == 5) {
    	float forma = pow(max(cos(pi * uv.y * freq  + time * vel+ fase), 1.0 - abs(uv.x)),1.0) * ampl;
   		      forma *= pow(max(sin(pi * uv.x * freq + time * vel+ fase ), 1.0 - abs(uv.x)),1.0) * ampl;
   		      resultado = vec2(forma);   
    }
    if (modo == 6) {
    	float forma = pow(min(cos(pi * uv.y / 2.0), 1.0 - abs(uv.x)),3.0);
              forma = sin(forma * freq * pi + time * vel+ fase) * ampl;
              resultado = vec2(forma);   
    }
    if (modo == 7) {
	vec2 pos = vec2(sin(time * vel + fase), cos(time * vel + fase))  - uv;
	float rad = length(pos);

    	float forma = pow(min(cos(pi * uv.x / 2.0), 3.0 - abs(uv.y)),1.0);
              forma = sin(rad * forma * freq * pi + time * vel + fase) * ampl;
              resultado = vec2(forma);   
    }	
    if (modo == 8) {
	vec2 pos = vec2(sin(time * vel + fase)/2.+(tile/2.), cos(time * vel + fase)/2.+(tile/2.)) - uv;
        float rad = length(pos);
	float ang = atan(pos.x,pos.y);

        float forma = pow(min(cos(pi * uv.x / 2.0), 1.0 - abs(uv.y/2.0)),1.0);
              forma = sin(rad * freq * forma  * pi + time * vel + fase) * ampl;
              resultado = vec2(forma); 
    }
    if (modo == 9) {
	vec2 pos = vec2(sin(time * vel + fase)/2.+(tile/2.), cos(time * vel + fase)/2.+(tile/2.)) - uv;
        float rad = length(pos);
	float ang = atan(pos.x,pos.y);

        float forma = pow(min(cos(pi * uv.x / 2.0), 1.0 - abs(uv.y/2.0)),1.0);
              forma*= sin(ang * freq * pi * forma  + time * vel + fase) * ampl;
              resultado = vec2(forma); 
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
	
	

  	vec2 uv = (tile * gl_FragCoord.st ) / resolution - tile * 0.5 + 0.5;

	uv -= vec2(PosX, PosY);
  	uv-= vec2(0.5, 0.5);
	uv = rotate2d(time * rotate) * uv;
	uv = scale(vec2(tile, -tile)) * uv;     // Di vuelta el input en y -title
	uv+= vec2(0.5, 0.5);  

	vec2 pos = vec2(0.5, 0.5) - uv;
	float radio = length(pos);
	float angulo = atan(pos.x, pos.y);  

	vec2 pr = uv.st ;
	vec2 pg = uv.st ;
	vec2 pb = uv.st ;
  
	pr+= formula(pr, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, FaseR, Formula_A_Cant);
	pr+= formula(pr, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, FaseR, Formula_B_Cant);
	pr+= formula(pr, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, FaseR, Formula_C_Cant);

	pg+= formula(pg, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, FaseG, Formula_A_Cant);
	pg+= formula(pg, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, FaseG, Formula_B_Cant);
	pg+= formula(pg, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, FaseG, Formula_C_Cant);

	pb+= formula(pb, Formula_A_Freq, Formula_A_Amp, Formula_A_Vel, Formula_A_Modo, FaseB, Formula_A_Cant);
	pb+= formula(pb, Formula_B_Freq, Formula_B_Amp, Formula_B_Vel, Formula_B_Modo, FaseB, Formula_B_Cant);
	pb+= formula(pb, Formula_C_Freq, Formula_C_Amp, Formula_C_Vel, Formula_C_Modo, FaseB, Formula_C_Cant); 
   
	float r = texture2D(texture, pr).r;
	float g = texture2D(texture, pg).g;
	float b = texture2D(texture, pb).b;


  gl_FragColor = vec4(r, g, b, 1.0);
}
