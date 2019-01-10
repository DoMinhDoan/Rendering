Shader "Custom/Textured Platting"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" {}
		[NoScaleOffset] _Texture1("Texture 1", 2D) = "white" {}
		[NoScaleOffset] _Texture2("Texture 2", 2D) = "white" {}
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"
			sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _Texture1, _Texture2;
			
			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uvSplat : TEXCOORD1;
			};

			struct VertexData
			{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			Interpolators MyVertexProgram(
				VertexData vertexData
			)
			{
				Interpolators interpolator;

				interpolator.uv = TRANSFORM_TEX(vertexData.uv, _MainTex);				
				interpolator.position = UnityObjectToClipPos(vertexData.position);
				interpolator.uvSplat = vertexData.uv;

				return interpolator;
			}

			float4 MyFragmentProgram(
				Interpolators interpolator
			) : SV_TARGET
			{
				float4 splat = tex2D(_MainTex, interpolator.uvSplat);
				float4 color = tex2D(_Texture1, interpolator.uv) * splat.r + tex2D(_Texture2, interpolator.uv) * (1 - splat.r);
				return color;
			}

			ENDCG
		}
	}
}
