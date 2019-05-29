// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( TFHCPostProcessPainterlyEffectPPSRenderer ), PostProcessEvent.AfterStack, "TFHCPostProcessPainterlyEffect", true )]
public sealed class TFHCPostProcessPainterlyEffectPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Top Texture 0" )]
	public TextureParameter _TopTexture0 = new TextureParameter {  };
	[Tooltip( "DistortStrength" )]
	public FloatParameter _DistortStrength = new FloatParameter { value = 0.6209025f };
}

public sealed class TFHCPostProcessPainterlyEffectPPSRenderer : PostProcessEffectRenderer<TFHCPostProcessPainterlyEffectPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "TFHC/PostProcess/PainterlyEffect" ) );
		if(settings._TopTexture0.value != null) sheet.properties.SetTexture( "_TopTexture0", settings._TopTexture0 );
		sheet.properties.SetFloat( "_DistortStrength", settings._DistortStrength );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
