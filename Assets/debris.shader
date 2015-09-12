Shader "Custom/debris" {
	SubShader {
   		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
		ZWrite Off
		Blend SrcAlpha One 
		
        Pass {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
 			#pragma target 3.0
 
 			
 			#include "UnityCG.cginc"

 			struct appdata_custom {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
				float4 texcoord : TEXCOORD0;
			};

 			struct v2f
 			{
 				float4 pos:SV_POSITION;
 				fixed4 color:COLOR;
 			};
 			
 			float4x4 _PrevInvMatrix;
			float    _Range;
			float    _RangeR;
   
            v2f vert(appdata_custom v)
            {
				float3 target = _WorldSpaceCameraPos;
				float3 trip;
				trip = floor( ((target - v.vertex.xyz)*_RangeR + 1) * 0.5 );
				trip *= (_Range * 2);
				v.vertex.xyz += trip;

            	float4 tv0 = v.vertex * v.texcoord.x;
            	tv0 = mul (UNITY_MATRIX_MVP, tv0);
            	
            	float4 tv1 = v.vertex * v.texcoord.y;
            	tv1 = mul (UNITY_MATRIX_MV, tv1);
            	tv1 = mul (_PrevInvMatrix, tv1);
            	tv1 = mul (UNITY_MATRIX_P, tv1);
            	
            	v2f o;
            	o.pos = tv0 + tv1;
            	float depth = o.pos.z * 0.02;
            	float normalized_depth = (1 - depth);
            	o.color = v.color;
            	o.color.a *= (normalized_depth);
            	return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return i.color;
            }

            ENDCG
        }
    }
}
