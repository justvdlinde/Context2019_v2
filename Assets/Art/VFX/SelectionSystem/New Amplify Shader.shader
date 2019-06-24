// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "MenuSelectionCilinder"
{
	Properties
	{
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "bump" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_tiling("tiling", Vector) = (1,1,0,0)
		_Vector6("Vector 6", Vector) = (1,1,0,0)
		_Vector5("Vector 5", Vector) = (1,1,0,0)
		_Vector0("Vector 0", Vector) = (1,1,0,0)
		_Vector3("Vector 3", Vector) = (1,1,0,0)
		_speed("speed", Vector) = (1,0,0,0)
		_Vector4("Vector 4", Vector) = (1,0,0,0)
		_Speed2("Speed2", Vector) = (1,0,0,0)
		_Vector1("Vector 1", Vector) = (0.5,0.2,0,0)
		_Vector2("Vector 2", Vector) = (0.5,0.2,0,0)
		_Float0("Float 0", Range( 0 , 1)) = 0
		_Float1("Float 1", Range( 0 , 50)) = 0
		_Color0("Color 0", Color) = (0.3632557,0.9150943,0.3151032,0)
		_SpeedMask2("SpeedMask2", Vector) = (0,-0.4,0,0)
		_SpeedMask("Speed Mask", Vector) = (0,-0.34,0,0)
		_Float2("Float 2", Range( 0 , 5)) = 1.553827
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_Vector7("Vector 7", Vector) = (1,1,0,0)
		_Vector9("Vector 9", Vector) = (1,1,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend One One
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
			float3 worldPos;
			float3 worldNormal;
		};

		uniform float4 _Color0;
		uniform sampler2D _TextureSample3;
		uniform float2 _Vector9;
		uniform float2 _SpeedMask2;
		uniform float2 _Vector7;
		uniform float2 _SpeedMask;
		uniform float _Float2;
		uniform sampler2D _MainTex;
		uniform float2 _tiling;
		uniform float2 _speed;
		uniform float2 _Vector6;
		uniform float2 _Vector4;
		uniform sampler2D _TextureSample2;
		uniform float2 _Vector5;
		uniform float2 _Speed2;
		uniform sampler2D _TextureSample0;
		uniform float2 _Vector0;
		uniform float2 _Vector1;
		uniform sampler2D _TextureSample1;
		uniform float2 _Vector3;
		uniform float2 _Vector2;
		uniform float _Float1;
		uniform float _Float0;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 panner112 = ( _Time.y * _SpeedMask2 + float2( 0,0 ));
			float2 uv_TexCoord113 = i.uv_texcoord * _Vector9 + panner112;
			float2 panner90 = ( _Time.y * _SpeedMask + float2( 0,0 ));
			float2 uv_TexCoord79 = i.uv_texcoord * _Vector7 + panner90;
			float temp_output_116_0 = ( tex2D( _TextureSample3, uv_TexCoord113 ).r * tex2D( _TextureSample3, uv_TexCoord79 ).r );
			float clampResult89 = clamp( ( 1.0 - ( temp_output_116_0 * _Float2 ) ) , 0.0 , 1.0 );
			float2 panner5 = ( _Time.y * _speed + float2( 0,0 ));
			float2 uv_TexCoord3 = i.uv_texcoord * _tiling + panner5;
			float2 panner103 = ( _Time.y * _Vector4 + float2( 0,0 ));
			float2 uv_TexCoord105 = i.uv_texcoord * _Vector6 + panner103;
			float2 panner48 = ( _Time.y * _Speed2 + float2( 0,0 ));
			float2 uv_TexCoord49 = i.uv_texcoord * _Vector5 + panner48;
			float3 temp_cast_0 = (( ( UnpackNormal( tex2D( _MainTex, uv_TexCoord3 ) ).g * UnpackNormal( tex2D( _MainTex, uv_TexCoord105 ) ).r ) * tex2D( _TextureSample2, uv_TexCoord49 ).r )).xxx;
			float2 panner14 = ( _Time.y * _Vector1 + float2( 0,0 ));
			float2 uv_TexCoord15 = i.uv_texcoord * _Vector0 + panner14;
			float2 panner35 = ( _Time.y * _Vector2 + float2( 0,0 ));
			float2 uv_TexCoord37 = i.uv_texcoord * _Vector3 + panner35;
			float4 blendOpSrc32 = tex2D( _TextureSample0, uv_TexCoord15 );
			float4 blendOpDest32 = tex2D( _TextureSample1, uv_TexCoord37 );
			float3 desaturateInitialColor67 = ( saturate( ( 1.0 - ( ( 1.0 - blendOpDest32) / blendOpSrc32) ) )).rgb;
			float desaturateDot67 = dot( desaturateInitialColor67, float3( 0.299, 0.587, 0.114 ));
			float3 desaturateVar67 = lerp( desaturateInitialColor67, desaturateDot67.xxx, 1.0 );
			float3 blendOpSrc43 = temp_cast_0;
			float3 blendOpDest43 = desaturateVar67;
			float4 temp_output_63_0 = ( float4( ( clampResult89 * ( ( saturate(  (( blendOpSrc43 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpSrc43 - 0.5 ) ) * ( 1.0 - blendOpDest43 ) ) : ( 2.0 * blendOpSrc43 * blendOpDest43 ) ) )) * _Float1 ) ) , 0.0 ) * i.vertexColor );
			float4 temp_output_69_0 = ( _Float0 * i.vertexColor );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV95 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode95 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV95, 5.0 ) );
			o.Emission = ( _Color0 * ( ( temp_output_63_0 + ( ( 1.0 - temp_output_116_0 ) * temp_output_69_0 ) ) + ( i.vertexColor * fresnelNode95 ) ) ).rgb;
			o.Alpha = ( temp_output_63_0 + temp_output_69_0 ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16700
6.339622;84.22642;1590;943;2104.7;2244.447;1;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;17;-1693.163,541.9349;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;94;-1376,-1440;Float;False;Property;_SpeedMask;Speed Mask;17;0;Create;True;0;0;False;0;0,-0.34;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;6;-2329.226,-809.0862;Float;False;Property;_speed;speed;8;0;Create;True;0;0;False;0;1,0;0,-0.17;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;115;-1883.934,-1763.405;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;33;-1777.603,730.6255;Float;False;Property;_Vector2;Vector 2;12;0;Create;True;0;0;False;0;0.5,0.2;0,-0.14;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;34;-1813.648,950.277;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;106;-2432.371,-172.1844;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;102;-2396.326,-391.8359;Float;False;Property;_Vector4;Vector 4;9;0;Create;True;0;0;False;0;1,0;0,-0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;16;-1657.118,322.2834;Float;False;Property;_Vector1;Vector 1;11;0;Create;True;0;0;False;0;0.5,0.2;0,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;92;-1824,-1280;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;110;-1435.934,-1923.405;Float;False;Property;_SpeedMask2;SpeedMask2;16;0;Create;True;0;0;False;0;0,-0.4;0,-0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;7;-2365.271,-589.4346;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;46;-1779.593,-173.214;Float;False;Property;_Speed2;Speed2;10;0;Create;True;0;0;False;0;1,0;0,-0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;35;-1510.603,743.6255;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;5;-2062.226,-796.0862;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;13;-1512.13,158.4087;Float;False;Property;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;1,1;10,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;103;-2129.325,-378.8359;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;36;-1632.615,566.7509;Float;False;Property;_Vector3;Vector 3;7;0;Create;True;0;0;False;0;1,1;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;90;-1200,-1136;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.08;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;14;-1390.118,335.2834;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;109;-1072,-1280;Float;False;Property;_Vector7;Vector 7;20;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;104;-2203.325,-531.8359;Float;False;Property;_Vector6;Vector 6;4;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;45;-1815.638,46.43744;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;4;-2136.226,-1028.086;Float;False;Property;_tiling;tiling;3;0;Create;True;0;0;False;0;1,1;5.88,0.69;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.PannerNode;112;-1259.934,-1619.405;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,-0.08;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;111;-1131.934,-1763.405;Float;False;Property;_Vector9;Vector 9;21;0;Create;True;0;0;False;0;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1173.118,177.2834;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;79;-864,-1120;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;48;-1512.593,-160.214;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;105;-1912.324,-536.8361;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;47;-1586.593,-392.214;Float;False;Property;_Vector5;Vector 5;5;0;Create;True;0;0;False;0;1,1;5,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1845.226,-954.0863;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;113;-923.9341,-1603.405;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;37;-1293.603,585.6255;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-916.022,-21.92239;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;021836c3bea68a84eb2cd0523b87427e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-1295.593,-318.214;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1287.43,-806.6956;Float;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;f01e788803a708440b0bb200c1660f30;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;108;-1584.119,-655.3489;Float;True;Property;_TextureSample4;Texture Sample 4;1;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;a268ab862991c4743a9281c69bb2c36a;True;0;False;bump;Auto;True;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;114;-699.9341,-1539.405;Float;True;Property;_TextureSample5;Texture Sample 5;19;0;Create;True;0;0;False;0;None;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Instance;82;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;31;-1033.907,351.0277;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;021836c3bea68a84eb2cd0523b87427e;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;82;-640,-1056;Float;True;Property;_TextureSample3;Texture Sample 3;19;0;Create;True;0;0;False;0;None;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-1124.69,-569.781;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;32;-654.2283,249.5609;Float;True;ColorBurn;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-255.8357,-1316.662;Float;False;Property;_Float2;Float 2;18;0;Create;True;0;0;False;0;1.553827;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;-292.6598,-1051.379;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;44;-930.372,-337.3903;Float;True;Property;_TextureSample2;Texture Sample 2;0;0;Create;True;0;0;False;0;e24b2c680edaa90458d31f11544d79ca;f33b9dfd244964d4dbe5d1d7e198c2bf;True;0;False;white;Auto;False;Instance;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-395.1268,-435.1776;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;67;-367.3448,102.0529;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-84.41843,-1089.482;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;43;-127.6517,-101.3986;Float;True;HardLight;True;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;87;169.8506,-937.2902;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-375.0064,-544.8644;Float;False;Property;_Float1;Float 1;14;0;Create;True;0;0;False;0;0;50;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;23;-167.7084,336.1599;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;-151.6514,567.0622;Float;False;Property;_Float0;Float 0;13;0;Create;True;0;0;False;0;0;0.395;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-22.03714,-354.6261;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;89;263.4681,-682.9471;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;332.694,-447.6859;Float;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;166.4037,326.2885;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;100;-24.93555,-570.2054;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;95;260.067,664.9681;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;387.3538,-61.86821;Float;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;345.41,282.4224;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;420.657,496.2684;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;71;563.4473,89.84059;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;74;626.8413,-190.7953;Float;False;Property;_Color0;Color 0;15;0;Create;True;0;0;False;0;0.3632557,0.9150943,0.3151032,0;1,0.9005518,0.259434,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;98;710.5837,242.3074;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;928.7959,188.3192;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;70;803.9678,584.8101;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;65;1191.206,219.1434;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;MenuSelectionCilinder;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;4;1;False;-1;1;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;35;2;33;0
WireConnection;35;1;34;0
WireConnection;5;2;6;0
WireConnection;5;1;7;0
WireConnection;103;2;102;0
WireConnection;103;1;106;0
WireConnection;90;2;94;0
WireConnection;90;1;92;0
WireConnection;14;2;16;0
WireConnection;14;1;17;0
WireConnection;112;2;110;0
WireConnection;112;1;115;0
WireConnection;15;0;13;0
WireConnection;15;1;14;0
WireConnection;79;0;109;0
WireConnection;79;1;90;0
WireConnection;48;2;46;0
WireConnection;48;1;45;0
WireConnection;105;0;104;0
WireConnection;105;1;103;0
WireConnection;3;0;4;0
WireConnection;3;1;5;0
WireConnection;113;0;111;0
WireConnection;113;1;112;0
WireConnection;37;0;36;0
WireConnection;37;1;35;0
WireConnection;8;1;15;0
WireConnection;49;0;47;0
WireConnection;49;1;48;0
WireConnection;1;1;3;0
WireConnection;108;1;105;0
WireConnection;114;1;113;0
WireConnection;31;1;37;0
WireConnection;82;1;79;0
WireConnection;101;0;1;2
WireConnection;101;1;108;1
WireConnection;32;0;8;0
WireConnection;32;1;31;0
WireConnection;116;0;114;1
WireConnection;116;1;82;1
WireConnection;44;1;49;0
WireConnection;50;0;101;0
WireConnection;50;1;44;1
WireConnection;67;0;32;0
WireConnection;84;0;116;0
WireConnection;84;1;85;0
WireConnection;43;0;50;0
WireConnection;43;1;67;0
WireConnection;87;0;84;0
WireConnection;78;0;43;0
WireConnection;78;1;77;0
WireConnection;89;0;87;0
WireConnection;88;0;89;0
WireConnection;88;1;78;0
WireConnection;69;0;41;0
WireConnection;69;1;23;0
WireConnection;100;0;116;0
WireConnection;63;0;88;0
WireConnection;63;1;23;0
WireConnection;99;0;100;0
WireConnection;99;1;69;0
WireConnection;97;0;23;0
WireConnection;97;1;95;0
WireConnection;71;0;63;0
WireConnection;71;1;99;0
WireConnection;98;0;71;0
WireConnection;98;1;97;0
WireConnection;72;0;74;0
WireConnection;72;1;98;0
WireConnection;70;0;63;0
WireConnection;70;1;69;0
WireConnection;65;2;72;0
WireConnection;65;9;70;0
ASEEND*/
//CHKSM=1380FFE4A89F6B9FE9B55FCF96F1EB90DF207751