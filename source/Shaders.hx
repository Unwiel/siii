package;
import flixel.system.FlxAssets.FlxShader;
import openfl.display.BitmapData;
import openfl.display.ShaderInput;
import openfl.utils.Assets;
import flixel.FlxG;
import openfl.Lib;
import flixel.math.FlxPoint;


class ChromaticAberration
{
	public var shader:ChromaticAberrationShader;

	public function new(offset:Float = 0.00)
	{
		shader = new ChromaticAberrationShader();
		shader.rOffset.value = [offset];
		shader.gOffset.value = [0.0];
		shader.bOffset.value = [-offset];
	}

	public function setChrome(chromeOffset:Float):Void
	{
		shader.rOffset.value = [chromeOffset, 0.0];
		shader.gOffset.value = [0.0];
		shader.bOffset.value = [-chromeOffset, 0.0];
	}
}

class ChromaticAberrationShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header
		
        uniform vec2 rOffset;
        uniform vec2 gOffset;
        uniform vec2 bOffset;

		vec4 offsetColor(vec2 offset)
        {
            return texture2D(bitmap, openfl_TextureCoordv.st - offset);
        }

		void main()
		{
                        #pragma body

			vec4 base = texture2D(bitmap, openfl_TextureCoordv);
            base.r = offsetColor(rOffset).r;
            base.g = offsetColor(gOffset).g;
            base.b = offsetColor(bOffset).b;

			gl_FragColor = base;
		}
	')
	public function new()
	{
		super();
	}
}

class VCRDistortionEffect
{
  public var shader:VCRDistortionShader = new VCRDistortionShader();
  public function new(){
    shader.iTime.value = [0];
    shader.noise.value = [true];
    var noise = Assets.getBitmapData(Paths.image("noise2"));
    shader.iChannel.input = noise;
  }

  public function update(elapsed:Float){
    shader.iTime.value[0] += elapsed;
  }

  
}

class VCRDistortionShader extends FlxShader
{

  @:glFragmentSource('
    #pragma header
    uniform float iTime; // shader playback time (in seconds)
    uniform sampler2D iChannel; // shader texture (a bitmap data)
    uniform bool noise;
    
    float noisee(vec2 p)
    {
    	float s = texture2D(iChannel,vec2(1.,2.*cos(iTime))*iTime*8. + p*1.).x;
    	s *= s;
    	return s;
    }
    
    float onOff(float a, float b, float c)
    {
    	return step(c, sin(iTime + a*cos(iTime*b)));
    }
    
    float ramp(float y, float start, float end)
    {
    	float inside = step(start,y) - step(end,y);
    	float fact = (y-start)/(end-start)*inside;
    	return (1.-fact) * inside;
    }
    
    float stripes(vec2 uv)
    {
            if (noise) {
    	        float noi = noisee(uv*vec2(0.5,1.) + vec2(1.,3.));
    	        return ramp(mod(uv.y*4. + iTime/2.+sin(iTime + sin(iTime*0.63)),1.),0.5,0.6)*noi;
            } else {
    	        return ramp(mod(uv.y*4. + iTime/2.+sin(iTime + sin(iTime*0.63)),1.),0.5,0.6);
            }
    }
    
    vec3 getVideo(vec2 uv)
    {
    	vec2 look = uv;
    	float window = 1./(1.+20.*(look.y-mod(iTime/4.,1.))*(look.y-mod(iTime/4.,1.)));
    	look.x = look.x + sin(look.y*10. + iTime)/50.*onOff(4.,4.,.3)*(1.+cos(iTime*80.))*window;
    	float vShift = 0.4*onOff(2.,3.,.9)*(sin(iTime)*sin(iTime*20.) + (0.5 + 0.1*sin(iTime*200.)*cos(iTime)));
    	look.y = mod(look.y + vShift, 1.);
    	vec3 video = vec3(texture2D(bitmap,look));
    	return video;
    }
    
    vec2 screenDistort(vec2 uv)
    {
    	uv -= vec2(.5,.5);
    	uv = uv*1.2*(1./1.2+2.*uv.x*uv.x*uv.y*uv.y);
    	uv += vec2(.5,.5);
    	return uv;
    }
    
    void main()
    {
        #pragma body
    	vec2 uv = openfl_TextureCoordv;
    	uv = screenDistort(uv);
    	vec3 video = getVideo(uv);
    	float vigAmt = 3.+.3*sin(iTime + 5.*cos(iTime*5.));
    	float vignette = (1.-vigAmt*(uv.y-.5)*(uv.y-.5))*(1.-vigAmt*(uv.x-.5)*(uv.x-.5));
    
    	video += stripes(uv);
            if (noise) {
    	        video += noisee(uv*2.)/2.;
            }
    	video *= vignette;
    	video *= (12.+mod(uv.y*30.+iTime,1.))/13.;
    
            if (noise) {
    	        gl_FragColor = vec4(video,1.0);
            } else {
                    gl_FragColor = vec4(video,0.3);
            }
    } 
  ')
  public function new()
  {
    super();
  }
}