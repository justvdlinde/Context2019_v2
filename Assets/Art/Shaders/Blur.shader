Shader "Custom/Blur"
{
	Properties
	{
		_BlurRadius("Blur Radius", Range(0.0, 20.0)) = 1.0
		_Intensity("Blur Intensity", Range(0.0, 1.0)) = 0.01
	}

	SubShader
	{
		Tags 
		{
			"Queue" = "Transparent"
		}

		GrabPass {}

		Pass
		{
			Name "HORIZONTALBLUR"

			CGPROGRAM
			//Function defines
			#pragma vertex vert
			#pragma fragment frag

			//Includes
			#include "UnityCG.cginc"


			//Structures

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 uvgrab : TEXCOORD;
			};

			//Imports
			float _BlurRadius;
			float _BlurIntensity;
			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize;

		
			//Vertex Function
			v2f vert(appdata_base IN) {
				v2f OUT;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);

			#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
			#else
				float scale = 1.0;
			#endif	

				OUT.uvgrab.xy = (float2(OUT.vertex.x, OUT.vertex.y * scale) + OUT.vertex.w) * 0.5;
				OUT.ungrab.zw = OUT.vertex.zw;

				return OUT;
			}

			//Fragment Function
			half4 frag{v2f IN} : COLOR
			{
				half4 texcol = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.uvgrab));
				half4 texsum = half(0, 0, 0, 0);

				#define GRABPIXEL



				texcol = lerp(texcol, texsum, _Intensity)
				return texcol;
			}
			ENDCG
		}

		Pass
		{
			Name "OBJECT"

			CGPROGRAM
			//Function defines
			#pragma vertex vert
			#pragma fragment frag

			//Includes
			#include "UnityCG.cginc"


			//Structures
			struct appdata 
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD;
			};

			//Imports
			float4 _Color;
			sampler2D _MainTex;

		
			//Vertex Function
			v2f vert(appdata IN) {
				v2f OUT;

				OUT.pos = UnityObjectToClipPos(IN.vertex);
				OUT.uv = IN.uv;

				return OUT;
			}

			//Fragment Function
			fixed4 frag(v2f IN) : SV_Target{
				float4 texColor = tex2D(_MainTex, IN.uv);

				return texColor * _Color;
			}
			ENDCG
		}
	}
}
