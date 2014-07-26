//
//  ViewController.h
//  OpenGL_Template_CPLUSPLUS
//
//  Created by Harold Serrano on 7/25/14.
//  Copyright (c) 2014 Roldie.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

#import "OpenGLClass.h"

@interface ViewController : GLKViewController{
    
    OpenGLClass *openGLClass;
}

@property (strong, nonatomic) EAGLContext *context;

@end
