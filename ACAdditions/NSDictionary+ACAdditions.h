//
//  NSDictionary+ACAdditions.h
//  ACAdditions
//
//  Created by Adam Burkepile on 8/30/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ACAdditions)
+ (NSDictionary*)dictionaryFromQueryString:(NSString*)inQueryString;
- (id)objectForKeyIfNotNull:(NSString*)key;
@end
