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

#define OPENGL_ES

using namespace std;

class OpenGLClass{
    
private:
    
    GLuint textureID[16];   //Array for textures
    GLuint programObject;   //program object used to link shaders
    GLuint vertexArrayObject; //Vertex Array Object
    GLuint vertexBufferObject; //Vertex Buffer Object
    
    float aspect; //widthDisplay/heightDisplay ratio
    GLint modelViewProjectionUniformLocation;  //OpenGL location for our MVP uniform
    GLint normalMatrixUniformLocation;  //OpenGL location for the normal matrix
    
    //Matrices for several transformation
    GLKMatrix4 projectionMatrix;
    GLKMatrix4 cameraViewMatrix;
    GLKMatrix4 modelWorldMatrix;
    GLKMatrix4 modelViewMatrix;
    GLKMatrix4 modelViewProjectionMatrix;
    GLKMatrix3 normalMatrix;
    
    float screenWidth;  //Width of current device display
    float screenHeight; //Height of current device display
    
    
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
    
    //This array is used to tell OpenGL how to draw the cube
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
    
    //Constructor
    OpenGLClass(float screenWidth,float screenHeight);
    ~OpenGLClass();
    
    void setupOpenGL(); //Initialize the OpenGL
    void teadDownOpenGL(); //Destroys the OpenGL
    
    //loads the shaders
    void loadShaders(const char* uVertexShaderProgram, const char* uFragmentShaderProgram);
    
    //Set the transformation for the object
    void setTransformation();
    
    //updates the mesh
    void update();
    
    //draws the mesh
    void draw();
    
    //files used to loading the shader
    bool loadShaderFile(const char *szFile, GLuint shader);
    void loadShaderSrc(const char *szShaderSrc, GLuint shader);
};

#endif /* defined(__OpenGL_Template_CPLUSPLUS__OpenGLClass__) */
