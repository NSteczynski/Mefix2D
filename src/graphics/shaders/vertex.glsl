#version 460 core

in vec2 a_Position;
in vec2 a_Texcoord;

out vec2 v_Texcoord;

void main()
{
  v_Texcoord = a_Texcoord;
  gl_Position = vec4(a_Position, 0.0, 1.0);
}
