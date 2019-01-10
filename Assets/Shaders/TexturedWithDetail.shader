Shader "Custom/Textured With Detail"
{
	Properties
	{
		_Tint("Tint", Color) = (1, 1, 0, 1)
		_MainTex("Texture", 2D) = "white" {}
		_DetailTex("Detail Texture", 2D) = "gray" {}
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
			sampler2D _MainTex, _DetailTex;
			float4 _MainTex_ST, _DetailTex_ST;
			
			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float2 uv_detail : TEXCOORD1;
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
				interpolator.uv_detail = TRANSFORM_TEX(vertexData.uv, _DetailTex);
				interpolator.position = UnityObjectToClipPos(vertexData.position);
				return interpolator;
			}

			float4 MyFragmentProgram(
				Interpolators interpolator
			) : SV_TARGET
			{
				//return float4(interpolator.uv, 1, 1);
				float4 color = tex2D(_MainTex, interpolator.uv) *_Tint;
				//color *= tex2D(_MainTex, interpolator.uv * 10);
				//color *= tex2D(_MainTex, interpolator.uv * 10) * 2;
				color *= tex2D(_DetailTex, interpolator.uv_detail) * 2;
				return color;
			}

			ENDCG
		}
	}
}
