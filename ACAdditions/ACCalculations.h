//
//  ACCalculations.h
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACCalculations : NSObject
CGSize calculateProportionalResize(CGSize originalSize, CGSize frameSize);
NSString* rectDescription(CGRect rect);
@end
