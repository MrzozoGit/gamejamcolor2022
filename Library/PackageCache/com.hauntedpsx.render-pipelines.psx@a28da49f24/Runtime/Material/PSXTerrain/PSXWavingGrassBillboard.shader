// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)
Shader "Hidden/TerrainEngine/Details/PSX/BillboardWavingDoublePass"
{
    Properties
    {
        _WavingTint ("Fade Color", Color) = (.7,.6,.5, 0)
        _MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
        _WaveAndDistance ("Wave and distance", Vector) = (12, 3.6, 1, 1)
        _Cutoff ("Cutoff", float) = 0.5
    }
    SubShader
    {
        // Tags {"Queue" = "Geometry+200" "RenderType" = "GrassBillBoard" "IgnoreProjector" = "True" }//"DisableBatching"="True"
        Tags { "RenderType" = "PSXLit" }
        Cull Off
        LOD 200
        AlphaTest Greater [_Cutoff]
        ColorMask RGB

        LOD 100

        Pass
        {
            Tags { "LightMode" = "PSXLit" }
            HLSLPROGRAM
            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0

            // -------------------------------------
            // Global Keywords (set by render pipeline)
            #pragma multi_compile _OUTPUT_LDR _OUTPUT_HDR

            // -------------------------------------
            // Force Enabled Material Keywords
            // Grass shader has no method of assigning a material for toggling the keywords that would normally be user
            // exposed such as in the PSXLit material.
            // For now, simply enable all features we believe are relevant (at a performance cost).
            // #pragma shader_feature _ _VERTEX_COLOR_MODE_COLOR _VERTEX_COLOR_MODE_LIGHTING
            #define _LIGHTING_BAKED_ON
            #define _LIGHTING_DYNAMIC_ON
            // #define _SHADING_EVALUATION_MODE_PER_VERTEX
            #define _SHADING_EVALUATION_MODE_PER_PIXEL
            // #pragma shader_feature _EMISSION
            // #pragma shader_feature _ALPHATEST_ON
            // #pragma shader_feature _ _ALPHAPREMULTIPLY_ON _ALPHAMODULATE_ON
            // #pragma shader_feature _REFLECTION_ON
            #define _FOG_ON
            #define _BRDF_MODE_LAMBERT

            // -------------------------------------
            // Unity defined keywords
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ LIGHTMAP_ON

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #pragma vertex WavingGrassBillboardVert
            #pragma fragment LitPassFragmentGrass
            #define _ALPHATEST_ON

            #include "Packages/com.hauntedpsx.render-pipelines.psx/Runtime/Material/PSXTerrain/PSXWavingGrassInput.hlsl"
            #include "Packages/com.hauntedpsx.render-pipelines.psx/Runtime/Material/PSXTerrain/PSXWavingGrassPasses.hlsl"
            ENDHLSL
        }

        Pass
        {
            Tags{"LightMode" = "DepthOnly"}

            ZWrite On
            ColorMask 0
            Cull Off

            HLSLPROGRAM
            // Required to compile gles 2.0 with standard srp library
            #pragma prefer_hlslcc gles
            #pragma exclude_renderers d3d11_9x
            #pragma target 2.0

            // -------------------------------------
            // Global Keywords (set by render pipeline)
            #pragma multi_compile _OUTPUT_LDR _OUTPUT_HDR

            // -------------------------------------
            // Force Enabled Material Keywords
            // Grass shader has no method of assigning a material for toggling the keywords that would normally be user
            // exposed such as in the PSXLit material.
            // For now, simply enable all features we believe are relevant (at a performance cost).
            // #pragma shader_feature _ _VERTEX_COLOR_MODE_COLOR _VERTEX_COLOR_MODE_LIGHTING
            // #define _LIGHTING_BAKED_ON
            // #define _LIGHTING_DYNAMIC_ON
            // #define _SHADING_EVALUATION_MODE_PER_VERTEX
            // #define _SHADING_EVALUATION_MODE_PER_PIXEL
            // #pragma shader_feature _EMISSION
            // #pragma shader_feature _ALPHATEST_ON
            // #pragma shader_feature _ _ALPHAPREMULTIPLY_ON _ALPHAMODULATE_ON
            // #pragma shader_feature _REFLECTION_ON
            // #define _FOG_ON
            #define _BRDF_MODE_LAMBERT

            #pragma vertex DepthOnlyVertex
            #pragma fragment DepthOnlyFragment

            // -------------------------------------
            // Material Keywords
            #define _ALPHATEST_ON
            // #pragma shader_feature _GLOSSINESS_FROM_BASE_ALPHA

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing

            #include "Packages/com.hauntedpsx.render-pipelines.psx/Runtime/Material/PSXTerrain/PSXWavingGrassInput.hlsl"
            #include "Packages/com.hauntedpsx.render-pipelines.psx/Runtime/Material/PSXTerrain/PSXWavingGrassPasses.hlsl"
            ENDHLSL
        }
    }
}
