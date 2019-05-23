// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "smoke"
{
	Properties
	{
		_smokeflipbook("smoke flipbook", 2D) = "white" {}
		_gradient("gradient", 2D) = "white" {}
		_Opacity("Opacity", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		uniform sampler2D _gradient;
		uniform sampler2D _smokeflipbook;
		uniform float4 _smokeflipbook_ST;
		uniform float2 _Opacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 temp_output_25_0 = i.vertexColor;
			o.Emission = temp_output_25_0.rgb;
			float2 uv_smokeflipbook = i.uv_texcoord * _smokeflipbook_ST.xy + _smokeflipbook_ST.zw;
			float4 tex2DNode7 = tex2D( _smokeflipbook, uv_smokeflipbook );
			float clampResult21 = clamp( ( tex2DNode7.a * (_Opacity.x + (i.vertexColor.a - 0.0) * (_Opacity.y - _Opacity.x) / (1.0 - 0.0)) ) , 0.0 , 1.0 );
			float2 temp_cast_1 = (clampResult21).xx;
			o.Alpha = tex2D( _gradient, temp_cast_1 ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15401
17;-831;1422;767;1557.472;655.9872;1.790725;True;True
Node;AmplifyShaderEditor.VertexColorNode;9;-1995.96,-93.08254;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;4;-1504.19,-2.346778;Float;True;Property;_smokeflipbook;smoke flipbook;0;0;Create;True;0;0;False;0;58431594e0508664f82f4c6ce9538fb3;58431594e0508664f82f4c6ce9538fb3;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.Vector2Node;11;-1904.416,324.8842;Float;False;Property;_Opacity;Opacity;2;0;Create;True;0;0;False;0;0,0;0,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TFHCRemapNode;10;-1696.907,223.6907;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1170.798,2.167901;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-866.3167,201.3935;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;5;-757.1502,-155.4099;Float;True;Property;_gradient;gradient;1;0;Create;True;0;0;False;0;f31338f8de860e1439760d15f170bdc3;f31338f8de860e1439760d15f170bdc3;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ClampOpNode;21;-649.1039,127.8447;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;16;-1973.716,-373.3727;Float;False;Property;_Colourintensity;Colour intensity;4;0;Create;True;0;0;False;0;0,0;-0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-851.7383,-468.4356;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;20;-620.1841,-466.2151;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;27;64.69875,-333.6494;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;25;-172.8627,-257.4227;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-416.627,-494.1157;Float;True;Property;_TextureSample2;Texture Sample 2;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-70.18256,-548.0839;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;3;-332.0339,-682.4854;Float;False;Property;_Color0;Color 0;3;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;118.315,-456.3785;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;6;-418.1327,-28.89636;Float;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;15;-1704.672,-471.6414;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;24;439.9926,-319.6356;Float;False;True;2;Float;ASEMaterialInspector;0;0;Unlit;smoke;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;9;4
WireConnection;10;3;11;1
WireConnection;10;4;11;2
WireConnection;7;0;4;0
WireConnection;12;0;7;4
WireConnection;12;1;10;0
WireConnection;21;0;12;0
WireConnection;14;0;15;0
WireConnection;14;1;7;4
WireConnection;20;0;14;0
WireConnection;27;0;13;0
WireConnection;27;1;25;0
WireConnection;13;0;5;0
WireConnection;13;1;20;0
WireConnection;17;0;3;0
WireConnection;17;1;13;0
WireConnection;18;0;17;0
WireConnection;18;1;9;4
WireConnection;6;0;5;0
WireConnection;6;1;21;0
WireConnection;15;0;9;4
WireConnection;15;3;16;1
WireConnection;15;4;16;2
WireConnection;24;2;25;0
WireConnection;24;9;6;1
ASEEND*/
//CHKSM=52A45452CAAA7D7693BE0B7819AA51828ABBA105