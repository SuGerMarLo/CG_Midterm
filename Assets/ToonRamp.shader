Shader "Custom/ToonRamp"
{
    Properties
    {
        // Setting property values and ranges to change in the unity editor
        _Color("Color", Color) = (1,1,1,1)
        _RampTex("Ramp Texture", 2D) = "white" {}
        _MainTex("Texture", 2D) = "white" {}
    }
        SubShader
    {

        CGPROGRAM

        // Specify to unity that a surface shader called "surf" is being created with the built-in "Ramp" lighting model
        #pragma surface surf ToonRamp

            // Define the variables that were created in "Properties"
            float4 _Color;
            sampler2D _RampTex;
            sampler2D _MainTex;

            // Define the "LightingRamp" function that calculates the lighting for the object
            float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten)
            {
                // Find the dot product of the surface normal and the light direction
                half diff = dot(s.Normal, lightDir);

                // Calculate the diffuse lighting value
                half h = diff * 0.5 + 0.5;


                float2 rh = h;

                // Sample the ramp texture using the diffuse lighting value
                half3 ramp = tex2D(_RampTex, rh).rgb;

                half4 c;

                // Combine the surface color, light color, ramp texture, and attenuation to get the final color
                c.rgb = s.Albedo * _LightColor0.rgb * (ramp);

                // Set the alpha value to the surface alpha
                c.a = s.Alpha;

                // Return the final color
                return c;
            }

            struct Input
            {
                // Texture coordinate for the albedo texture
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutput o)
            {
                //I tried making it so that the toon shader would accept a texture as well
                o.Albedo = (tex2D(_MainTex, IN.uv_MainTex) * _Color).rgb;
            }
            ENDCG
    }
        FallBack "Diffuse"
}
