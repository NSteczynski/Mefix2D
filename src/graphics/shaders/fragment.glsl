#version 460 core

in vec2 v_Texcoord;

out vec4 f_Color;

uniform sampler2D texture0;
uniform vec4 color;

void main() {
  f_Color = texture(texture0, v_Texcoord) * color;
}
