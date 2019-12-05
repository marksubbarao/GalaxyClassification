// Fragment shader for  Markers. A passed value (markerType) determines the type of marker drawn
uniform float uv_fade;
uniform sampler2D galPics;
uniform float displayMode;
uniform int numDisplay;
in vec2 texcoord;
in vec2 uvcoord;
in float highlight;
in float smoothP;
in float spiralP;
out vec4 fragColor;

void main()
{
	int picSize=12;
    vec2 fromCenter = texcoord * 2. - vec2(1.);
	float dist2=dot(fromCenter,fromCenter);
	fragColor = texture(galPics, (vec2(mod(highlight,picSize), floor(highlight/picSize))+texcoord)/picSize);
	fragColor = texture(galPics, (vec2(mod(highlight,picSize), floor((highlight+0.01)/picSize))+texcoord)/picSize);
	fragColor.a=1.0;
	if (dist2 > 1.0 || highlight > numDisplay) {
		discard;
	} else if (dist2 > 0.7) {
		if (displayMode <0.5) {
			fragColor=vec4(1.);
		} else {
			float classAngle = atan(fromCenter[1],fromCenter[0])/6.283 + 0.5;
			if (classAngle <spiralP) {
				fragColor=vec4(0.1,0.1,1.0,1.0);
			} else if (classAngle <spiralP+smoothP) {
				fragColor=vec4(1.0,0.1,0.1,1.0);
			} else {
				fragColor=vec4(0.25,0.25,0.25,1.0);
			}
		}
	}
	// fragColor.a=uv_fade; We will scale down size instead
}
