//
//  ACCalculations.m
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "ACCalculations.h"

@implementation ACCalculations
CGSize calculateProportionalResize(CGSize originalSize, CGSize frameSize) {
    float x1 = originalSize.width;
    float y1 = originalSize.height;
    float x2 = frameSize.width;
    float y2 = frameSize.height;
    
    float deltaX = x2 / x1;
    float deltaY = y2 / y1;
    
    float delta = deltaX < deltaY ? deltaX : deltaY;
    
    return CGSizeMake(floorf(delta*x1), floorf(delta*y1));
}
NSString* rectDescription(CGRect rect) {
    return [NSString stringWithFormat:@"(%f,%f) (%f,%f)",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height];
}
@end
