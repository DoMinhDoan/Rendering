Shader "Custom/Bloom"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Cull Off
		ZTest Always
		ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex VertexProgram
            #pragma fragment FragmentProgram
            
            #include "UnityCG.cginc"

            struct VertexData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolators
            {                
                float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;

			Interpolators VertexProgram(VertexData v)
            {
				Interpolators i;
                i.pos = UnityObjectToClipPos(v.vertex);
                i.uv = v.uv;
                return i;
            }

            half4 FragmentProgram(Interpolators i) : SV_Target
            {
                // sample the texture
				half4 col = tex2D(_MainTex, i.uv) * half4(1, 0, 0, 0);
                return col;
            }
            ENDCG
        }
    }
}
