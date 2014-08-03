//
//  Shader.vsh
//  OpenGL_Template_CPLUSPLUS
//
//  Created by Harold Serrano on 7/25/14.
//  Copyright (c) 2014 Roldie.com. All rights reserved.
//

attribute vec4 position;
attribute vec3 normal;
attribute vec2 texCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

varying mediump vec2 vtextureCoord;

void main()
{

    vtextureCoord=texCoord;

    gl_Position = modelViewProjectionMatrix * position;
}
