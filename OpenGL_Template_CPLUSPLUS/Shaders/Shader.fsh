//
//  Shader.fsh
//  OpenGL_Template_CPLUSPLUS
//
//  Created by Harold Serrano on 7/25/14.
//  Copyright (c) 2014 Roldie.com. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
    
}
