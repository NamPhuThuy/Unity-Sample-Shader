Shader "Unlit/FirstUnlitShader"
{
    Properties
    {
        // Create a white color
        _Color("Test Color", color) = (0, 1, 1, 1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert //vertex-shader runs on every vertices
            #pragma fragment frag //fragment-shader runs on every single on the screen

            //we often use the vertex-shader to pass data into the fragment-shader, because the fragment-shader is what being drawn onto the screen

            #include "UnityCG.cginc" 

            struct appdata //object data or mesh data
            {
                float4 vertex : POSITION; 
            };

            //vertex to fragment
            // this object is a way to pass data from the vertex shader to the fragment shader
            struct v2f 
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex); //MVP matrix - Model View Projection matrix
                return o;
            }

            fixed4 _Color;
            
            fixed4 frag (v2f i) : SV_Target
            {
                half2 someVal = half2(0.5, 0.5);

                // red, green, blue, alpha; change this to change the color of the mesh
                // fixed4 col = fixed4(0, 1, 1, 1);
                fixed4 col = _Color;

                
                return col;
            }
            ENDCG
        }
    }
}
