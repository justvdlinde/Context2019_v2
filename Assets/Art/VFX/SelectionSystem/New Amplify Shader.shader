// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MenuSelectionCilinder"
{
	Properties
	{
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_tiling("tiling", Vector) = (1,1,0,0)
		_Vector5("Vector 5", Vector) = (1,1,0,0)
		_Vector0("Vector 0", Vector) = (1,1,0,0)
		_Vector3("Vector 3", Vector) = (1,1,0,0)
		_speed("speed", Vector) = (1,0,0,0)
		_Vector4("Vector 4", Vector) = (1,0,0,0)
		_Vector1("Vector 1", Vector) = (0.5,0.2,0,0)
		_Vector2("Vector 2", Vector) = (0.5,0.2,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Overlay"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		Blend OneMinusDstColor One
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _MainTex;
		uniform float2 _tiling;
		uniform float2 _speed;
		uniform sampler2D _TextureSample2;
		uniform float2 _Vector5;
		uniform float2 _Vector4;
		uniform sampler2D _TextureSample0;
		uniform float2 _Vector0;
		uniform float2 _Vector1;
		uniform sampler2D _TextureSample1;
		uniform float2 _Vector3;
		uniform float2 _Vector2;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 panner5 = ( _Time.y * _speed + float2( 0,0 ));
			float2 uv_TexCoord3 = i.uv_texcoord * _tiling + panner5;
			float2 panner48 = ( _Time.y * _Vector4 + float2( 0,0 ));
			float2 uv_TexCoord49 = i.uv_texcoord * _Vector5 + panner48;
			float4 temp_cast_0 = (( tex2D( _MainTex, uv_TexCoord3 ).g * tex2D( _TextureSample2, uv_TexCoord49 ).r )).xxxx;
			float2 panner14 = ( _Time.y * _Vector1 + float2( 0,0 ));
			float2 uv_TexCoord15 = i.uv_texcoord * _Vector0 + panner14;
			float2 panner35 = ( _Time.y * _Vector2 + float2( 0,0 ));
			float2 uv_TexCoord37 = i.uv_texcoord * _Vector3 + panner35;
			float4 blendOpSrc32 = tex2D( _TextureSample0, uv_TexCoord15 );
			float4 blendOpDest32 = tex2D( _TextureSample1, uv_TexCoord37 );
			float4 blendOpSrc43 = temp_cast_0;
			float4 blendOpDest43 = ( saturate( ( 1.0 - ( ( 1.0 - blendOpDest32) / blendOpSrc32) ) ));
			o.Emission = ( ( saturate(  (( blendOpSrc43 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpSrc43 - 0.5 ) ) * ( 1.0 - blendOpDest43 ) ) : ( 2.0 * blendOpSrc43 * blendOpDest43 ) ) )) * i.vertexColor ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
202.4;171.2;1321;670;236.6849;10.0457;1;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;17;-1693.163,541.9349;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;16;-1657.118,322.2834;Float;False;Property;_Vector1;Vector 1;9;0;Create;True;0;0;False;0;0.5,0.2;-0.5,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;33;-1777.603,730.6255;Float;False;Property;_Vector2;Vector 2;10;0;Create;True;0;0;False;0;0.5,0.2;-0.2,-0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;46;-1779.593,-173.214;Float;False;Property;_Vector4;Vector 4;8;0;Create;True;0;0;False;0;1,0;-0.02,-0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;34;-1813.648,950.277;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;7;-1880.771,-382.3347;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;6;-1844.726,-601.9861;Float;False;Property;_speed;speed;7;0;Create;True;0;0;False;0;1,0;0,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;45;-1815.638,46.43744;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;5;-1577.726,-588.9861;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;13;-1512.13,158.4087;Float;False;Property;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;1,1;5,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;36;-1632.615,566.7509;Float;False;Property;_Vector3;Vector 3;6;0;Create;True;0;0;False;0;1,1;5,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;14;-1390.118,335.2834;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;48;-1512.593,-160.214;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;35;-1510.603,743.6255;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;4;-1651.726,-820.9862;Float;False;Property;_tiling;tiling;3;0;Create;True;0;0;False;0;1,1;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;47;-1586.593,-392.214;Float;False;Property;_Vector5;Vector 5;4;0;Create;True;0;0;False;0;1,1;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-1293.603,585.6255;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1360.726,-746.9862;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1173.118,177.2834;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-1295.593,-318.214;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;44;-930.372,-337.3903;Float;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;e24b2c680edaa90458d31f11544d79ca;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-795.5474,301.8031;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;61c0b9c0523734e0e91bc6043c72a490;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-765.0083,76.67342;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;61c0b9c0523734e0e91bc6043c72a490;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-844.1044,-586.6954;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;e24b2c680edaa90458d31f11544d79ca;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-384.8519,-404.3528;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;32;-372.4454,113.1592;Float;True;ColorBurn;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;23;-53.15281,391.8895;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;43;-73.79742,-33.77444;Float;True;HardLight;True;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;336.7188,149.6391;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-628.0039,533.3013;Float;False;Property;_Float0;Float 0;11;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;56;677.7819,225.1521;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;MenuSelectionCilinder;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Overlay;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;5;4;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;2;6;0
WireConnection;5;1;7;0
WireConnection;14;2;16;0
WireConnection;14;1;17;0
WireConnection;48;2;46;0
WireConnection;48;1;45;0
WireConnection;35;2;33;0
WireConnection;35;1;34;0
WireConnection;37;0;36;0
WireConnection;37;1;35;0
WireConnection;3;0;4;0
WireConnection;3;1;5;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;49;0;47;0
WireConnection;49;1;48;0
WireConnection;44;1;49;0
WireConnection;31;1;37;0
WireConnection;8;1;15;0
WireConnection;1;1;3;0
WireConnection;50;0;1;2
WireConnection;50;1;44;1
WireConnection;32;0;8;0
WireConnection;32;1;31;0
WireConnection;43;0;50;0
WireConnection;43;1;32;0
WireConnection;63;0;43;0
WireConnection;63;1;23;0
WireConnection;56;2;63;0
ASEEND*/
//CHKSM=6CF59BF144F0B847663EC2F3D88C672456EEE26F