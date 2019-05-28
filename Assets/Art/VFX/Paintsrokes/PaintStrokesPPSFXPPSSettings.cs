// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( PaintStrokesPPSFXPPSRenderer ), PostProcessEvent.BeforeTransparent, "PaintStrokesPPSFX", true )]
public sealed class PaintStrokesPPSFXPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Screen" )]
	public TextureParameter _MainTex = new TextureParameter {  };
	[Tooltip( "Normal1" )]
	public TextureParameter _Normal1 = new TextureParameter {  };
	[Tooltip( "DistortStrength" )]
	public FloatParameter _DistortStrength = new FloatParameter { value = 0.6209025f };
	[Tooltip( "Tiling1" )]
	public Vector4Parameter _Tiling1 = new Vector4Parameter { value = new Vector4(1f,1f,0f,0f) };
	[Tooltip( "NormalScale" )]
	public FloatParameter _NormalScale = new FloatParameter { value = 0f };
	[Tooltip( "ScreenColorOverlay" )]
	public ColorParameter _ScreenColorOverlay = new ColorParameter { value = new Color(1f,1f,1f,0f) };
}

public sealed class PaintStrokesPPSFXPPSRenderer : PostProcessEffectRenderer<PaintStrokesPPSFXPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "PaintStrokesPPSFX" ) );
		if(settings._MainTex.value != null) sheet.properties.SetTexture( "_MainTex", settings._MainTex );
		if(settings._Normal1.value != null) sheet.properties.SetTexture( "_Normal1", settings._Normal1 );
		sheet.properties.SetFloat( "_DistortStrength", settings._DistortStrength );
		sheet.properties.SetVector( "_Tiling1", settings._Tiling1 );
		sheet.properties.SetFloat( "_NormalScale", settings._NormalScale );
		sheet.properties.SetColor( "_ScreenColorOverlay", settings._ScreenColorOverlay );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
