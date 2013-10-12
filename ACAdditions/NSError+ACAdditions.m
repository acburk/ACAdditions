//
//  NSError+ACAdditions.m
//  ACAdditions
//
//  Created by Adam Burkepile on 7/25/13.
//  Copyright (c) 2013 Adam Burkepile. All rights reserved.
//

#import "NSError+ACAdditions.h"

@implementation NSError (ACAdditions)

- (void)displayFullscreenShadeAlert {
    [ACAlerts displayShadeMessage:[NSString stringWithFormat:@"Error: %@(%d) - %@\n%@",
                                   self.domain,
                                   self.code,
                                   self.localizedDescription,
                                   self.localizedFailureReason]];
}

- (void)displayAlert {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error %d: %@",self.code,self.domain]
                                                        message:[NSString stringWithFormat:@"%@ - %@",self.localizedDescription,self.localizedFailureReason]
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
    [alertView show];
    
    return;
}

@end
