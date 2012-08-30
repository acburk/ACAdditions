//
//  NSDictionary+ACAdditions.m
//  ACAdditions
//
//  Created by Adam Burkepile on 8/30/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "NSDictionary+ACAdditions.h"

@implementation NSDictionary (ACAdditions)
+ (NSDictionary*)dictionaryFromQueryString:(NSString*)inQueryString {
    NSArray* params = [inQueryString componentsSeparatedByString:@"&"];
    __block NSMutableDictionary* paramDictionary = [NSMutableDictionary new];
    
    [params enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSArray* keyAndValue = [obj componentsSeparatedByString:@"="];
        
        [paramDictionary setObject:([keyAndValue count] >= 2 ? [keyAndValue objectAtIndex:1] : @"")
                            forKey:[keyAndValue objectAtIndex:0]];
    }];
    
    return [paramDictionary copy];
}
@end
