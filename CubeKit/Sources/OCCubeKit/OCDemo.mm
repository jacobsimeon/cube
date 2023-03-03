//
//  Demo.m
//  
//
//  Created by Jacob Morris on 2/24/23.
//


#import "OCDemo.h"
#import <UIKit/UIKit.h>
#import <cube.h>

@implementation OCDemo {
    void* demo;
};

- (instancetype)init
{
    self = [super init];
    if (self) {
        demo = demoCreate();
    }
    return self;
}

- (void)run {
    demoRun(demo);
}

- (void)main:(CALayer *)layer {
    const char* argv[] = { "cube" };
    int argc = sizeof(argv)/sizeof(char*);

    demoMain(demo, (__bridge void*)layer, argc, argv);
}

- (void)resize {
    demoResize(demo);
}

@end
