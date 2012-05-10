//
//  ACAlerts.h
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACAlerts : NSObject
+ (void)displayAlertMessage:(NSString*)pMessage withTitle:(NSString*)pTitle;
+ (void)displayShadeMessage:(NSString*)pMessage;
+ (void)removeShadeMessage;
+ (void)fadeAndRemoveShadeMessage;
@end
