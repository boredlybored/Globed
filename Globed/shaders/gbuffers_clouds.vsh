#version 330 compatibility

uniform vec3 chunkOffset;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelViewInverse;

out vec2 texcoord;
out vec2 lmcoord;
out vec4 glcolor;

void main() {
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	
	//curvey world
	vec3 worldSpaceVertexPosition = cameraPosition + (gbufferModelViewInverse * gl_ModelViewMatrix * vec4(gl_Vertex.xyz + chunkOffset, 1)).xyz;
	float distanceFromCam = distance(worldSpaceVertexPosition, cameraPosition);
	gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * vec4(gl_Vertex.xyz + chunkOffset + .5 * distanceFromCam - .5 ,1);
}