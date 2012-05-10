//
//  UIView+ACAdditions.h
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ACAdditions)
- (void)relativeFrameChange:(CGRect)rect;
- (void)moveHorizontal:(CGFloat)amount;
- (void)moveVertical:(CGFloat)amount;
- (void)resizeHorizontal:(CGFloat)amount;
- (void)resizeVertical:(CGFloat)amount;
@end
