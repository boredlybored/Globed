#version 330 compatibility

out vec2 textcords;
out vec2 lmcoord;
out vec3 foliageColour;

uniform vec3 chunkOffset;
uniform vec3 cameraPosition;
uniform mat4 gbufferModelViewInverse;

void main(){
    textcords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    foliageColour = gl_Color.rgb;
    
    gl_Position = ftransform();
    
    //curvey world funny hehe
    vec3 worldSpaceVertexPosition = cameraPosition + (gbufferModelViewInverse * gl_ModelViewMatrix * vec4(gl_Vertex.xyz + chunkOffset, 1)).xyz;
    float distanceFromCam = distance(worldSpaceVertexPosition, cameraPosition);
    gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * vec4(gl_Vertex.xyz + chunkOffset + .5 * distanceFromCam - .5 ,1);
}