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

- (BOOL)containsString:(NSString*)needle {
	NSRange result = [[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:needle options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
	
	if (result.length >= 1)
		return YES;
    
	return NO;
}

- (BOOL)containsStringAtEnd:(NSString*)needle {
	NSRange result = [[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:needle options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
	
	if (result.location+result.length == [self length])
		return YES;
	
	return NO;
}

- (BOOL)containsStringAtStart:(NSString*)needle {
	NSRange result = [[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] rangeOfString:needle options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
	
	if (result.location == 0 && result.length >= 1)
		return YES;
	
	return NO;
}

- (NSString*)fileExtension {
	NSArray* components = [self componentsSeparatedByString:@"."];
	
	return [(NSString*)[components lastObject] lowercaseString];
}

- (NSString*)trimStart:(NSString*)needle {
	NSString* newString = [self copy];
	
	NSRange r = [newString rangeOfString:needle];
	
	if (r.location == 0 && r.length > 0) {
		newString = [newString substringFromIndex:r.length];
	}
	
	return newString;
}

- (NSString*)alphanumericOnly {
	NSCharacterSet* charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    
	// get a scanner, initialised with our input string
	NSScanner *sourceScanner = [NSScanner scannerWithString:self];
	// create a mutable output string (empty for now)
	NSMutableString *cleanedString = [[NSMutableString alloc] init];
	
	// request that the scanner ignores these characters
	[sourceScanner setCharactersToBeSkipped:charactersToRemove];
	
	// run through the string to remove control characters
	while ([sourceScanner isAtEnd] == NO) {
		NSString *outString;
		// scan up to the next instance of one of the control characters
		if ([sourceScanner scanUpToCharactersFromSet:charactersToRemove intoString:&outString]) {
			// add the string chunk to our output string
			[cleanedString appendString:outString];
		}
	}
	
	return cleanedString;
}

@end
