// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PaintStrokesPPSFX"
{
	Properties
	{
		_DistortStrength("DistortStrength", Range( -5 , 5)) = 0.6209025
		_Float1("Float 1", Range( 0 , 5)) = 0.6209025
		_Vector0("Vector 0", Vector) = (1,1,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		GrabPass{ }

		Pass
		{
			Name "Unlit"
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			#include "UnityStandardUtils.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
			};

			uniform sampler2D _GrabTexture;
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _Float1;
			uniform float _DistortStrength;
			uniform sampler2D _TextureSample0;
			uniform float2 _Vector0;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord = screenPos;
				
				o.ase_texcoord1.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord1.zw = 0;
				float3 vertexValue =  float3(0,0,0) ;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 finalColor;
				float4 screenPos = i.ase_texcoord;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 appendResult131 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float clampDepth111 = UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( ase_screenPosNorm )));
				float temp_output_129_0 = abs( clampDepth111 );
				float clampResult177 = clamp( (0.0 + (temp_output_129_0 - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
				float clampResult162 = clamp( (0.0 + (( temp_output_129_0 * _DistortStrength ) - 0.0) * (100.0 - 0.0) / (1.0 - 0.0)) , 0.0 , 1.0 );
				float blendOpSrc179 = ( 1.0 - ( clampResult177 / _Float1 ) );
				float blendOpDest179 = clampResult162;
				float temp_output_179_0 = ( saturate( ( blendOpSrc179 * blendOpDest179 ) ));
				float2 uv0171 = i.ase_texcoord1.xy * _Vector0 + ase_screenPosNorm.xy;
				float3 tex2DNode168 = UnpackScaleNormal( tex2D( _TextureSample0, uv0171 ), temp_output_179_0 );
				float2 appendResult180 = (float2(tex2DNode168.r , tex2DNode168.g));
				float4 screenColor22 = tex2D( _GrabTexture, ( ( appendResult131 / ase_screenPosNorm.w ) + appendResult180 ) );
				
				
				finalColor = screenColor22;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16700
1974;43;1906;995;3448.066;426.9238;1.410484;True;True
Node;AmplifyShaderEditor.ScreenPosInputsNode;130;-3048.277,-576.2443;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;111;-2914.356,614.5015;Float;False;1;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;129;-2633.951,608.8249;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;176;-2436.543,822.7694;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2920.908,773.727;Float;False;Property;_DistortStrength;DistortStrength;0;0;Create;True;0;0;False;0;0.6209025;0.14;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;174;-2215.567,1188.216;Float;False;Property;_Float1;Float 1;1;0;Create;True;0;0;False;0;0.6209025;0.25;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;177;-2172.043,933.5902;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;143;-2364.63,617.1064;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;175;-1917.777,864.0073;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;157;-2122.867,731.2745;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;163;-1760.312,963.9103;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;162;-1892.367,607.0953;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;170;-2962.939,-112.2144;Float;False;Property;_Vector0;Vector 0;2;0;Create;True;0;0;False;0;1,1;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.BlendOpsNode;179;-1517.058,569.5185;Float;True;Multiply;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;171;-2635.834,6.368496;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;168;-2266.024,-64.92206;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;None;f01e788803a708440b0bb200c1660f30;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;131;-2576.939,-653.4266;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;180;-1838.103,-94.32733;Float;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;132;-2298.255,-445.4031;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;27;-1431.025,-117.8914;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;159;-2113.35,323.4959;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;173;-2616.327,163.3653;Float;False;Property;_Intensity;Intensity;4;0;Create;True;0;0;False;0;0;0.019;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;22;-1074.255,-6.251072;Float;False;Global;_GrabScreen0;Grab Screen 0;4;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;160;-2850.146,173.5005;Float;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;161;-2798.39,389.7066;Float;False;Constant;_Color1;Color 1;3;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;172;-1759.632,71.08357;Float;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;144;178,83;Float;False;True;2;Float;ASEMaterialInspector;0;1;PaintStrokesPPSFX;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;0;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;111;0;130;0
WireConnection;129;0;111;0
WireConnection;176;0;129;0
WireConnection;177;0;176;0
WireConnection;143;0;129;0
WireConnection;143;1;20;0
WireConnection;175;0;177;0
WireConnection;175;1;174;0
WireConnection;157;0;143;0
WireConnection;163;0;175;0
WireConnection;162;0;157;0
WireConnection;179;0;163;0
WireConnection;179;1;162;0
WireConnection;171;0;170;0
WireConnection;171;1;130;0
WireConnection;168;1;171;0
WireConnection;168;5;179;0
WireConnection;131;0;130;1
WireConnection;131;1;130;2
WireConnection;180;0;168;1
WireConnection;180;1;168;2
WireConnection;132;0;131;0
WireConnection;132;1;130;4
WireConnection;27;0;132;0
WireConnection;27;1;180;0
WireConnection;159;0;160;0
WireConnection;159;1;161;0
WireConnection;159;2;179;0
WireConnection;22;0;27;0
WireConnection;172;0;168;0
WireConnection;172;1;159;0
WireConnection;144;0;22;0
ASEEND*/
//CHKSM=A5CFBAB3818444D0BC6142E8B8603E372335CD68