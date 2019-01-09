// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader"
{
	Properties
	{
		_Tint("Tint", Color) = (1, 1, 0, 1)
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex MyVertexProgram
			#pragma fragment MyFragmentProgram

			#include "UnityCG.cginc"
			float4 _Tint;
			
			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
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
				//interpolator.localPosition = position.xyz;
				interpolator.uv = vertexData.uv;
				interpolator.position = UnityObjectToClipPos(vertexData.position);
				return interpolator;
			}

			float4 MyFragmentProgram(
				Interpolators interpolator
			) : SV_TARGET
			{
				return float4(interpolator.uv, 1, 1);
			}

			ENDCG
		}
	}
}
