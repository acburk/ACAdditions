//
//  NSString+ACAdditions.m
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "NSString+ACAdditions.h"

@implementation NSString (ACAdditions)

- (BOOL)isEqualToStringSafe:(NSString*)inString {
    if ([self isKindOfClass:[NSString class]] && 
        [inString isKindOfClass:[NSString class]] && 
        [(NSString*)self isEqualToString:inString]) {
        return YES;
    }
    return NO;
}

@end
