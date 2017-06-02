#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

uniform vec2 size;
uniform int samples; // 5 pixels per axis; higher = bigger glow, worse performance
uniform float quality; //2.5 lower = smaller glow, better quality

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main(void) {
  vec4 source = texture2D(texture, vertTexCoord.st);
  vec4 sum = vec4(0,0,0,0);
  int diff = (samples - 1) / 2;
  vec2 sizeFactor = vec2(1,1) / size * quality;
  
  for (int x = -diff; x <= diff; x++) {
    for (int y = -diff; y <= diff; y++) {
      vec2 offset = vec2(x, y) * sizeFactor;
      sum += texture2D(texture, vertTexCoord.xy + offset);
    }
  }
  
  gl_FragColor = ((sum / (float(samples * samples))) + source) * vertColor;
}
