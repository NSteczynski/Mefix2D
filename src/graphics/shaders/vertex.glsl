#version 460 core

in vec2 a_Position;
in vec2 a_Texcoord;

out vec2 v_Texcoord;

uniform mat3 u_Mat;
uniform mat3 u_View;

void main()
{
  v_Texcoord = a_Texcoord;
  gl_Position = vec4(u_View * u_Mat * vec3(a_Position, 1.0), 1.0);
}
