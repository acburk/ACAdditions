//
//  UIImage+ACAdditions.m
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "UIImage+ACAdditions.h"

@implementation UIImage (ACAdditions)
- (UIImage *)resizeToFrame:(CGSize)newSize {
    return [self resizeToSize:calculateProportionalResize([self size],newSize)];
}
- (UIImage *)resizeToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}
@end
