// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/MyShader"
{
	Properties
	{
		_Tint("Tint", Color) = (1, 1, 0, 1)
		_MainTex("Texture", 2D) = "white" {}
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
			sampler2D _MainTex;
			float4 _MainTex_ST;
			
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
				//interpolator.uv = vertexData.uv * _MainTex_ST.xy + _MainTex_ST.zw;
				interpolator.uv = TRANSFORM_TEX(vertexData.uv, _MainTex);
				interpolator.position = UnityObjectToClipPos(vertexData.position);
				return interpolator;
			}

			float4 MyFragmentProgram(
				Interpolators interpolator
			) : SV_TARGET
			{
				//return float4(interpolator.uv, 1, 1);
				return tex2D(_MainTex, interpolator.uv) * _Tint;
			}

			ENDCG
		}
	}
}
