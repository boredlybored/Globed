#version 460

uniform sampler2D gtexture;
uniform sampler2D lightmap;

layout(location = 0) out vec4 outColour0;

in vec2 textcords;
in vec2 lmcoord;
in vec3 foliageColour;

void main() {
    vec4 outputColourData = texture(gtexture,textcords);
    vec3 outputColour = outputColourData.rgb * foliageColour;
    float transparency = outputColourData.a;
    if (transparency < .1) {
        discard;
    }
    
    outputColour *= texture(lightmap, lmcoord).rgb;

    outColour0 = vec4(outputColour,transparency);
}