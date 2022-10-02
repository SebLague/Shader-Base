Shader "Custom/UnlitShadow"
{
	Properties
	{
	}
	SubShader
	{
		Pass
		{
			Tags { "LightMode" = "ForwardBase" "Queue" = "Geometry"}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase

			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"
			#include "AutoLight.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 pos : SV_POSITION;
				float3 worldNormal : NORMAL;
				float3 worldPos : TEXCOORD1;
				float4 screenPos : TEXCOORD2;
				LIGHTING_COORDS(4,5)
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				o.worldPos =  mul(unity_ObjectToWorld, float4(v.vertex.xyz, 1));
				o.screenPos = ComputeScreenPos(o.pos);
				TRANSFER_VERTEX_TO_FRAGMENT(o);
				return o;
			}

			float4 frag (v2f i) : SV_Target
			{
				return 1;
			}
			ENDCG
		}

	}
	
	// Shadows
	Fallback "VertexLit"
}
