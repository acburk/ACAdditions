//
//  UIView+ACAdditions.m
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "UIView+ACAdditions.h"

@implementation UIView (ACAdditions)

- (void)relativeFrameChange:(CGRect)rect {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x+rect.origin.x, frame.origin.y+rect.origin.y, frame.size.width+rect.size.width, frame.size.height+rect.size.height);
}
- (void)moveHorizontal:(CGFloat)amount {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x+amount, frame.origin.y, frame.size.width, frame.size.height);
}
- (void)moveVertical:(CGFloat)amount {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y+amount, frame.size.width, frame.size.height);
}
- (void)resizeHorizontal:(CGFloat)amount {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width+amount, frame.size.height);
}
- (void)resizeVertical:(CGFloat)amount {
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height+amount);
}

@end
