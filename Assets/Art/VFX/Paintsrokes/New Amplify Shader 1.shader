// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SiebShader/PaintStrokeMatShader"
{
	Properties
	{
		_StoneTile_basecolor("StoneTile_basecolor", 2D) = "white" {}
		_StoneTile_normal("StoneTile_normal", 2D) = "bump" {}
		_StoneTile_ambientOcclusion("StoneTile_ambientOcclusion", 2D) = "white" {}
		_DistortNormal("DistortNormal", 2D) = "bump" {}
		_Metalness("Metalness", Color) = (0,0,0,0)
		_DistortStrength("DistortStrength", Range( 0 , 10)) = 0
		_DistortTiling("DistortTiling", Vector) = (1,1,0,0)
		_Tiling("Tiling", Vector) = (1,1,0,0)
		_Roughness("Roughness", Range( 0 , 1)) = 0
		_DistortIntensity("DistortIntensity", Range( 0 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _StoneTile_normal;
		uniform float2 _Tiling;
		uniform sampler2D _StoneTile_basecolor;
		uniform float _DistortIntensity;
		uniform sampler2D _DistortNormal;
		uniform float2 _DistortTiling;
		uniform float _DistortStrength;
		uniform float4 _Metalness;
		uniform float _Roughness;
		uniform sampler2D _StoneTile_ambientOcclusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord6 = i.uv_texcoord * _Tiling;
			o.Normal = UnpackNormal( tex2D( _StoneTile_normal, uv_TexCoord6 ) );
			float4 tex2DNode1 = tex2D( _StoneTile_basecolor, uv_TexCoord6 );
			float2 uv_TexCoord11 = i.uv_texcoord * _DistortTiling;
			float3 tex2DNode8 = UnpackScaleNormal( tex2D( _DistortNormal, uv_TexCoord11 ), _DistortIntensity );
			o.Albedo = ( tex2DNode1 * ( ( tex2DNode8.r * tex2DNode8.g ) * _DistortStrength ) ).rgb;
			o.Metallic = _Metalness.r;
			o.Smoothness = ( ( 1.0 - tex2DNode1.a ) * _Roughness );
			o.Occlusion = tex2D( _StoneTile_ambientOcclusion, uv_TexCoord6 ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
232;73;1297;656;2380.574;1129.001;2.41187;True;True
Node;AmplifyShaderEditor.Vector2Node;12;-2953.625,13.76023;Float;False;Property;_DistortTiling;DistortTiling;6;0;Create;True;0;0;False;0;1,1;0.1,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-2674.539,-151.2479;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-2771.284,273.399;Float;False;Property;_DistortIntensity;DistortIntensity;9;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;18;-2217.344,-347.701;Float;False;Property;_Tiling;Tiling;7;0;Create;True;0;0;False;0;1,1;10,10;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;8;-2282.404,-28.94837;Float;True;Property;_DistortNormal;DistortNormal;3;0;Create;True;0;0;False;0;f01e788803a708440b0bb200c1660f30;f01e788803a708440b0bb200c1660f30;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1852.39,-301.123;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-2022.273,316.5981;Float;False;Property;_DistortStrength;DistortStrength;5;0;Create;True;0;0;False;0;0;3.1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1196.714,-469.853;Float;True;Property;_StoneTile_basecolor;StoneTile_basecolor;0;0;Create;True;0;0;False;0;8319c25e639bd544da010d49abd8333c;34d9dc032bdbc7f46b9513752a084286;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-1847.551,-12.30491;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;5;-761.0528,-264.198;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-959.7094,23.43486;Float;False;Property;_Roughness;Roughness;8;0;Create;True;0;0;False;0;0;0.277;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1531.958,80.58628;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-993.8844,242.4202;Float;True;Property;_StoneTile_ambientOcclusion;StoneTile_ambientOcclusion;2;0;Create;True;0;0;False;0;ea960984568c6a648829251a9468f50e;ea960984568c6a648829251a9468f50e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-1049.688,-189.2339;Float;True;Property;_StoneTile_normal;StoneTile_normal;1;0;Create;True;0;0;False;0;07e63c4dafc86cc48922c5884a0d5ef3;d8b3462914bc17247b63309eb33c30f9;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-577.6369,-157.1048;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-715.4017,-680.7748;Float;False;Property;_Metalness;Metalness;4;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-1548.899,-572.0907;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-832.1543,-381.3209;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-1944.622,128.295;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-287,-256;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SiebShader/PaintStrokeMatShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;12;0
WireConnection;8;1;11;0
WireConnection;8;5;14;0
WireConnection;6;0;18;0
WireConnection;1;1;6;0
WireConnection;20;0;8;1
WireConnection;20;1;8;2
WireConnection;5;0;1;4
WireConnection;9;0;20;0
WireConnection;9;1;10;0
WireConnection;3;1;6;0
WireConnection;2;1;6;0
WireConnection;16;0;5;0
WireConnection;16;1;15;0
WireConnection;7;0;6;0
WireConnection;19;0;1;0
WireConnection;19;1;9;0
WireConnection;13;0;8;1
WireConnection;13;1;8;2
WireConnection;0;0;19;0
WireConnection;0;1;2;0
WireConnection;0;3;4;0
WireConnection;0;4;16;0
WireConnection;0;5;3;0
ASEEND*/
//CHKSM=E2762D4464DD2183009F8975514EF01A13968D96