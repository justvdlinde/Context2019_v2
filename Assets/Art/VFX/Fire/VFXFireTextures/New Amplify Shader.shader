// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Emissive Panner"
{
	Properties
	{
		_Emissive("Emissive", 2D) = "white" {}
		_Smoothness("Smoothness", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_Albedo("Albedo", 2D) = "white" {}
		_noise("noise", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Emissive;
		uniform float4 _Emissive_ST;
		uniform sampler2D _noise;
		uniform sampler2D _Smoothness;
		uniform float4 _Smoothness_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Albedo = tex2D( _Albedo, uv_Albedo ).rgb;
			float2 uv_Emissive = i.uv_texcoord * _Emissive_ST.xy + _Emissive_ST.zw;
			float2 uv_TexCoord14 = i.uv_texcoord * float2( 0.5,0.5 );
			float2 panner15 = ( _Time.y * float2( 0.3,0.1 ) + uv_TexCoord14);
			float4 blendOpSrc13 = tex2D( _Emissive, uv_Emissive );
			float4 blendOpDest13 = tex2D( _noise, panner15 );
			o.Emission = ( saturate( (( blendOpSrc13 > 0.5 ) ? ( blendOpDest13 / ( ( 1.0 - blendOpSrc13 ) * 2.0 ) ) : ( 1.0 - ( ( ( 1.0 - blendOpDest13 ) * 0.5 ) / blendOpSrc13 ) ) ) )).rgb;
			float2 uv_Smoothness = i.uv_texcoord * _Smoothness_ST.xy + _Smoothness_ST.zw;
			float4 tex2DNode2 = tex2D( _Smoothness, uv_Smoothness );
			o.Metallic = tex2DNode2.r;
			o.Smoothness = tex2DNode2.a;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
6.4;7.2;1524;796;1771.499;278.5065;1;True;True
Node;AmplifyShaderEditor.Vector2Node;17;-2431.669,162.3862;Float;False;Constant;_PannerSpeed;PannerSpeed;5;0;Create;True;0;0;False;0;0.3,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-2433.771,-27.97862;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;0.5,0.5;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;9;-2474.843,513.36;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;15;-1812.802,73.48731;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-1592.852,-9.094526;Float;True;Property;_noise;noise;4;0;Create;True;0;0;False;0;9789d23040cb1fb45ad60392430c3c15;9789d23040cb1fb45ad60392430c3c15;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1234.801,-156.4998;Float;True;Property;_Emissive;Emissive;0;0;Create;True;0;0;False;0;c9e4b21a74779c84e8b8d1603f513fe4;c9e4b21a74779c84e8b8d1603f513fe4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-622.9443,474.043;Float;True;Property;_Smoothness;Smoothness;1;0;Create;True;0;0;False;0;e762adc78a7c93a4d9e365e3471259f9;e762adc78a7c93a4d9e365e3471259f9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-605.5414,-183.5661;Float;True;Property;_Normal;Normal;2;0;Create;True;0;0;False;0;f41e6bcf002c08440ba445ceedbb39da;f41e6bcf002c08440ba445ceedbb39da;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-622.4826,-392.4152;Float;True;Property;_Albedo;Albedo;3;0;Create;True;0;0;False;0;919526e8c78159247b3481094695969f;919526e8c78159247b3481094695969f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;13;-835.6561,18.76907;Float;True;VividLight;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Emissive Panner;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;14;0
WireConnection;15;2;17;0
WireConnection;15;1;9;0
WireConnection;11;1;15;0
WireConnection;13;0;1;0
WireConnection;13;1;11;0
WireConnection;0;0;4;0
WireConnection;0;1;3;0
WireConnection;0;2;13;0
WireConnection;0;3;2;0
WireConnection;0;4;2;4
ASEEND*/
//CHKSM=9A26BE42043E13FB44D1100EAE05714B1B2F752B