//
//  UIImage+ACAdditions.h
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ACAdditions)
- (UIImage *)resizeToFrame:(CGSize)newSize;
- (UIImage *)resizeToSize:(CGSize)newSize;
@end
