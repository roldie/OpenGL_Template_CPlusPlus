//
//  OpenGLClass.cpp
//  OpenGL_Template_CPLUSPLUS
//
//  Created by Harold Serrano on 7/25/14.
//  Copyright (c) 2014 Roldie.com. All rights reserved.
//

#include "OpenGLClass.h"
#include "lodepng.h"
#include <vector>

static GLubyte shaderText[MAX_SHADER_LENGTH];

OpenGLClass::OpenGLClass(float uScreenWidth,float uScreenHeight){
    
    screenWidth=uScreenWidth;
    screenHeight=uScreenHeight;
}

void OpenGLClass::setupOpenGL(){
    
    //load the shaders, compile them and link them
    
    loadShaders("Shader.vsh", "Shader.fsh");
    
    glEnable(GL_DEPTH_TEST);
    
    //1. Generate a Vertex Array Object
    
    glGenVertexArraysOES(1,&vertexArrayObject);
    
    //2. Bind the Vertex Array Object
    
    glBindVertexArrayOES(vertexArrayObject);
    
    //3. Generate a Vertex Buffer Object
    
    glGenBuffers(1, &vertexBufferObject);
    
    //4. Bind the Vertex Buffer Object
    
    glBindBuffer(GL_ARRAY_BUFFER, vertexBufferObject);
    
    //5. Dump the date into the Buffer
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(cubeVertexData), cubeVertexData, GL_STATIC_DRAW);
    
    //6. Get the location of the shader attribute called "position"
    
    GLuint positionLocation=glGetAttribLocation(programObject, "position");
    
    //7. Get the location of the shader attribute called "normal"
    
    GLuint normalLocation=glGetAttribLocation(programObject, "normal");

    //7a. Get the location of the shader attribute called "texCoord"
    
    GLuint textureLocation=glGetAttribLocation(programObject, "texCoord");
    
    //8. Enable both locations
    
    glEnableVertexAttribArray(positionLocation);
    
    glEnableVertexAttribArray(normalLocation);
    
    //8.a Enable the texture location attribute
    glEnableVertexAttribArray(textureLocation);

    //9. Link the buffer data to the shader attribute locations
    
    glVertexAttribPointer(positionLocation, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(20));
    glVertexAttribPointer(normalLocation, 3, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(8));

    //9a. Link the the buffer data to the texture attribute location
    glVertexAttribPointer(textureLocation, 2, GL_FLOAT, GL_FALSE, 32, BUFFER_OFFSET(0));
    
    
    //10. Get Location of uniforms
    modelViewProjectionUniformLocation = glGetUniformLocation(programObject,"modelViewProjectionMatrix");
    normalMatrixUniformLocation = glGetUniformLocation(programObject,"normalMatrix");
    
    //10.a Get location of texture uniform
    textureUniformLocation=glGetUniformLocation(programObject, "Texture");
    
    
    //11. Activate GL_TEXTURE0
    glActiveTexture(GL_TEXTURE0);
    
    //11.a Generate a texture buffer
    glGenTextures(1, &textureID[0]);
    
    //11.b Bind texture0
    glBindTexture(GL_TEXTURE_2D, textureID[0]);
    
    //12. Load the image and set its parameter
    loadPNGTexture("ConcreteDirty.png",GL_LINEAR, GL_LINEAR, GL_CLAMP_TO_EDGE);
    
    //13. Unbind the Vertex Array Object
    glBindVertexArrayOES(0);
    
    //14. Sets the transformation
    setTransformation();
    
    
}


void OpenGLClass::loadPNGTexture(const char *uTexture, GLenum minFilter, GLenum magFilter, GLenum wrapMode){
    
    // Load file and decode image.
    vector<unsigned char> image;
    unsigned int width, height;
    
    unsigned error = lodepng::decode(image, width, height,uTexture);
    
    
    //if there's an error, display it
    if(error){
        cout << "decoder error " << error << ": " << lodepng_error_text(error) << std::endl;
    }else{
        
        //Flip and invert the image
        unsigned char* imagePtr=&image[0];
        
        int halfTheHeightInPixels=height/2;
        int heightInPixels=height;
        
        
        //Assume RGBA for 4 components per pixel
        int numColorComponents=4;
        
        //Assuming each color component is an unsigned char
        int widthInChars=width*numColorComponents;
        
        unsigned char *top=NULL;
        unsigned char *bottom=NULL;
        unsigned char temp=0;
        
        for( int h = 0; h < halfTheHeightInPixels; ++h )
        {
            top = imagePtr + h * widthInChars;
            bottom = imagePtr + (heightInPixels - h - 1) * widthInChars;
            
            for( int w = 0; w < widthInChars; ++w )
            {
                // Swap the chars around.
                temp = *top;
                *top = *bottom;
                *bottom = temp;
                
                ++top;
                ++bottom;
            }
        }
        
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, wrapMode);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, wrapMode);
        
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, minFilter);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, magFilter);
        
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0,
                     GL_RGBA, GL_UNSIGNED_BYTE, &image[0]);
        
    }
    
}

void OpenGLClass::loadShaders(const char* uVertexShaderProgram, const char* uFragmentShaderProgram){
    
    // Temporary Shader objects
    GLuint VertexShader;
    GLuint FragmentShader;
    
    //1. Create shader objects
    VertexShader = glCreateShader(GL_VERTEX_SHADER);
    FragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
	
    //load the shaders files. Usually you want to check the return value of this function, if
    //it returns true, then the shaders were found, else there was an error, but for simplicity,
    //I wont check for those errors here
    
    //2. Load the shaders file
    loadShaderFile(uVertexShaderProgram, VertexShader);
    loadShaderFile(uFragmentShaderProgram, FragmentShader);
    
    //3. Compile them
    glCompileShader(VertexShader);
    glCompileShader(FragmentShader);
    
    //4. Create the program object
    programObject = glCreateProgram();
    
    //5. Attach the shaders to the program
    glAttachShader(programObject, VertexShader);
    glAttachShader(programObject, FragmentShader);
    
    //6. Link them to the program object
    glLinkProgram(programObject);
	
    // These are no longer needed
    glDeleteShader(VertexShader);
    glDeleteShader(FragmentShader);
    
    //7. Use the program
    glUseProgram(programObject);
}

void OpenGLClass::setTransformation(){
    
    //1. set the aspect viewing ratio of your device
    aspect = fabsf(screenWidth/screenHeight);
    
    //2. set the projection matrix
    projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    
    //3. set the camera matrix
    cameraViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    
    //4. move the Model-World matrix 1.5 into the z-axis
    modelWorldMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 1.5f);
    
    //5. rotate the Model-World matrix
    modelWorldMatrix = GLKMatrix4Rotate(modelWorldMatrix, 30.0, 1.0f, 1.0f, 1.0f);
    
    //6. transform the Model-World matrix into the Model-View matrix
    modelViewMatrix = GLKMatrix4Multiply(cameraViewMatrix, modelWorldMatrix);
    
    //7. extract the 3x3 normal matrix from the Model-View matrix for shading(light) purposes
    normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    //8. set the MVP matrix
    modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    //get the uniform locations of both the MVP and normal matrix
    glUniformMatrix4fv(modelViewProjectionUniformLocation, 1, 0, modelViewProjectionMatrix.m);
    glUniformMatrix3fv(normalMatrixUniformLocation, 1, 0, normalMatrix.m);
    
}

void OpenGLClass::update(){
    
}

void OpenGLClass::draw(){
    
    glUseProgram(programObject);
    
    glBindVertexArrayOES(vertexArrayObject);
    
    //1. Activate the textures
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, textureID[0]);
    glUniform1i(textureUniformLocation, 0);

    //2. Draw the elements
    glDrawElements(GL_TRIANGLES,36,GL_UNSIGNED_INT,Box_index);
    
    glBindVertexArrayOES(0);
    
}


void OpenGLClass::teadDownOpenGL(){
    
    glDeleteBuffers(1, &vertexBufferObject);
    glDeleteVertexArraysOES(1, &vertexArrayObject);
    
    
    if (programObject) {
        glDeleteProgram(programObject);
        programObject = 0;
        
    }
    
}


bool OpenGLClass::loadShaderFile(const char *szFile, GLuint shader)
{
    GLint shaderLength = 0;
    FILE *fp;
	
    // Open the shader file
    fp = fopen(szFile, "r");
    if(fp != NULL)
    {
        // See how long the file is
        while (fgetc(fp) != EOF)
            shaderLength++;
		
        // Allocate a block of memory to send in the shader
        //assert(shaderLength < MAX_SHADER_LENGTH);   // make me bigger!
        if(shaderLength > MAX_SHADER_LENGTH)
        {
            fclose(fp);
            return false;
        }
		
        // Go back to beginning of file
        rewind(fp);
		
        // Read the whole file in
        if (shaderText != NULL)
            fread(shaderText, 1, shaderLength, fp);
		
        // Make sure it is null terminated and close the file
        shaderText[shaderLength] = '\0';
        fclose(fp);
    }
    else
        return false;
	
    // Load the string
    loadShaderSrc((const char *)shaderText, shader);
    
    return true;
}

// Load the shader from the source text
void OpenGLClass::loadShaderSrc(const char *szShaderSrc, GLuint shader)
{
    GLchar *fsStringPtr[1];
    
    fsStringPtr[0] = (GLchar *)szShaderSrc;
    glShaderSource(shader, 1, (const GLchar **)fsStringPtr, NULL);
}