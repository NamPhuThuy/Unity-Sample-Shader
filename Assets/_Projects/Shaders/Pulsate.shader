Shader "Unlit/Pulsate"
{
    Properties
    {
        /*
        _MainTex: The internal name of the property, used within the shader code.
        ("Main Texture", 2D): The display name ("Main Texture") and the type (2D texture) of the property, which will be shown in the Unity editor.
        = "white": The default value for the property, which in this case is a white texture.
        {}: An empty set of options for the property.
        */
        _MainTexture("Main Texture", 2D) = "white" {}
        _AnimateXY("Animate X Y", Vector) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100
        Blend SrcAlpha OneMinusSrcAlpha
//        Blend One One
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTexture;
            // float4 _MainTexture;
            float4 _MainTexture_ST;
            float4 _AnimateXY;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTexture);

                /*what is o.uv
                o.uv is the texture coordinate of the vertex
                it is a float2, which is a 2D vector of floats*/

                // o.uv += _AnimateXY.xy * float2(_Time.y, 0);
                
                //when the change-value is too high, use frac() to prevent from pixelated texture
                // o.uv += _AnimateXY.xy * frac(float2(_Time.y, 0)); 
                
                // o.uv += _AnimateXY.xy * frac(_Time.yy);
                
                o.uv += frac(_AnimateXY.xy * _Time.yy);
                
                

                
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uvs = i.uv;
                
                fixed4 textureColor = tex2D(_MainTexture, uvs);
                return textureColor;
            }
            ENDCG
        }
    }
}
