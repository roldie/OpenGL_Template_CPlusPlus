//
//  OpenGLClass.h
//  OpenGL_Template_CPLUSPLUS
//
//  Created by Harold Serrano on 7/25/14.
//  Copyright (c) 2014 Roldie.com. All rights reserved.
//

#ifndef __OpenGL_Template_CPLUSPLUS__OpenGLClass__
#define __OpenGL_Template_CPLUSPLUS__OpenGLClass__

#include <iostream>
#import <GLKit/GLKit.h>

#define MAX_SHADER_LENGTH   8192

#define BUFFER_OFFSET(i) ((char *)NULL + (i))

using namespace std;

class OpenGLClass{
    
private:
    
    GLuint textureID[16];
    GLuint programObject;
    GLuint vertexArrayObject;
    GLuint vertexBufferObject;
    
    GLint modelViewProjectionUniformLocation;
    GLint normalMatrixUniformLocation;
    GLint textureUniformLocation;
    
    float aspect;
    GLKMatrix4 projectionMatrix;
    
    GLKMatrix4 cameraViewMatrix;
    GLKMatrix4 modelWorldMatrix;
    GLKMatrix4 modelViewMatrix;
    GLKMatrix4 modelViewProjectionMatrix;
    GLKMatrix3 normalMatrix;
    
    float screenWidth;
    float screenHeight;
    
    
    //This is the vertices, uv coordinates and normal data of the cube we will be rendering
    GLfloat cubeVertexData[192] =
    {
        // Data layout for each line below is:
        // UV1,UV2, Normal1, Normal2, Normal3, positionX, positionY, positionZ
        0.00000, 1.00000, 0.00000, 0.00000, 1.00000, -0.50000, -0.50000, 0.50000,
        0.00000, 0.00000, 0.00000, 0.00000, 1.00000, -0.50000, 0.50000, 0.50000,
        1.00000, 0.00000, 0.00000, 0.00000, 1.00000, 0.50000, 0.50000, 0.50000,
        1.00000, 1.00000, 0.00000, 0.00000, 1.00000, 0.50000, -0.50000, 0.50000,
        0.00000, 1.00000, 0.00000, 0.00000, -1.00000, 0.50000, -0.50000, -0.50000,
        0.00000, 0.00000, 0.00000, 0.00000, -1.00000, 0.50000, 0.50000, -0.50000,
        1.00000, 0.00000, 0.00000, 0.00000, -1.00000, -0.50000, 0.50000, -0.50000,
        1.00000, 1.00000, 0.00000, 0.00000, -1.00000, -0.50000, -0.50000, -0.50000,
        0.00000, 1.00000, -1.00000, 0.00000, 0.00000, -0.50000, -0.50000, -0.50000,
        0.00000, 0.00000, -1.00000, 0.00000, 0.00000, -0.50000, 0.50000, -0.50000,
        1.00000, 0.00000, -1.00000, 0.00000, 0.00000, -0.50000, 0.50000, 0.50000,
        1.00000, 1.00000, -1.00000, 0.00000, 0.00000, -0.50000, -0.50000, 0.50000,
        0.00000, 1.00000, 1.00000, 0.00000, 0.00000, 0.50000, -0.50000, 0.50000,
        0.00000, 0.00000, 1.00000, 0.00000, 0.00000, 0.50000, 0.50000, 0.50000,
        1.00000, 0.00000, 1.00000, 0.00000, 0.00000, 0.50000, 0.50000, -0.50000,
        1.00000, 1.00000, 1.00000, 0.00000, 0.00000, 0.50000, -0.50000, -0.50000,
        0.00000, 1.00000, 0.00000, 1.00000, 0.00000, -0.50000, 0.50000, 0.50000,
        0.00000, 0.00000, 0.00000, 1.00000, 0.00000, -0.50000, 0.50000, -0.50000,
        1.00000, 0.00000, 0.00000, 1.00000, 0.00000, 0.50000, 0.50000, -0.50000,
        1.00000, 1.00000, 0.00000, 1.00000, 0.00000, 0.50000, 0.50000, 0.50000,
        0.00000, 1.00000, 0.00000, -1.00000, 0.00000, -0.50000, -0.50000, -0.50000,
        0.00000, 0.00000, 0.00000, -1.00000, 0.00000, -0.50000, -0.50000, 0.50000,
        1.00000, 0.00000, 0.00000, -1.00000, 0.00000, 0.50000, -0.50000, 0.50000,
        1.00000, 1.00000, 0.00000, -1.00000, 0.00000, 0.50000, -0.50000, -0.50000
    };
    
    int Box_index[36]={
        0, 1, 2,
        2, 3, 0,
        4, 5, 6,
        6, 7, 4,
        8, 9, 10,
        10, 11, 8,
        12, 13, 14,
        14, 15, 12,
        16, 17, 18,
        18, 19, 16,
        20, 21, 22,
        22, 23, 20
    };
    
    
public:
    
    OpenGLClass(float screenWidth,float screenHeight);
    ~OpenGLClass();
    
    void setupOpenGL();
    void teadDownOpenGL();
    void loadShaders(const char* uVertexShaderProgram, const char* uFragmentShaderProgram);
    void setTransformation();
    void update();
    void draw();
    
    bool loadShaderFile(const char *szFile, GLuint shader);
    void loadShaderSrc(const char *szShaderSrc, GLuint shader);
};

#endif /* defined(__OpenGL_Template_CPLUSPLUS__OpenGLClass__) */
