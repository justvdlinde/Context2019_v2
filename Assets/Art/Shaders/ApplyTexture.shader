Shader "Custom/ApplyTexture"
{
	Properties
	{
		_MainTex("Main Texture", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)

	}

	SubShader
	{
		Pass
		{
			//CGPROGRAM

			//#pragma vertex vert
			//#pragma fragment frag
			//#include "UnityCG.cginc"

			//struct appdata 
			//{
			//	float4 vertex : POSITION;
			//	float2 uv : TEXTCOORD0;
			//};

			//struct v2f
			//{
			//	float4 pos : SV_POSITION
			//	float2 uv : TEXCOORD;
			//};

			ENDCG
		}


	}
}
