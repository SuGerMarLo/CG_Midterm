Shader "Custom/Decal"
{
    Properties
    {
        //Main change I did here was remove the main decal texture and replaced it with a color, since a basic texture would be practical in this situation
        _Color("Color", Color) = (1,1,1,1)
        _DecalTex("Decal", 2D) = "white" {}
        [Toggle] _ShowDecal("ShowDecal?", Float) = 0
    }
        SubShader
        {
            Tags { "Queue" = "Geometry" }

            CGPROGRAM
            #pragma surface surf Lambert

            //Defined the _Color variable
            float4 _Color;
            sampler2D _DecalTex;
            float _ShowDecal;

            struct Input
            {
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                fixed4 b = tex2D(_DecalTex, IN.uv_MainTex) * _ShowDecal;

                //Albedo is now just _Color, so whatever I choose it to be
                o.Albedo = _Color.rgb;
            }
            ENDCG
        }
            FallBack "Diffuse"
}
