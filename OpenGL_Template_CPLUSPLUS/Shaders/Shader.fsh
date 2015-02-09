//
//  Shader.fsh
//  OpenGL_Template_CPLUSPLUS
//
//  Created by Harold Serrano on 7/25/14.
//  Copyright (c) 2014 CGDemy.com. All rights reserved.
//

uniform sampler2D Texture;
varying mediump vec2 vtextureCoord;

void main()
{
    gl_FragColor=texture2D(Texture,vtextureCoord.st);
    
}
