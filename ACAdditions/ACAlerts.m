//
//  ACAlerts.m
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import "ACAlerts.h"

static UIView* loading = nil;
static UILabel* message = nil;

@implementation ACAlerts
+ (void)displayAlertMessage:(NSString*)pMessage withTitle:(NSString*)pTitle {
	UIAlertView* av = [[UIAlertView alloc] initWithTitle:pTitle 
												 message:pMessage 
												delegate:nil 
									   cancelButtonTitle:@"Close" 
									   otherButtonTitles:nil];
	[av show];
}

+ (void)removeShadeMessage {
	if (loading) {
		[loading removeFromSuperview];
		loading = nil;
	}
}

+ (void)fadeAndRemoveShadeMessage {
	[self fadeAndRemoveShadeMessageFor:.33f afterDelay:0];
}

+ (void)fadeAndRemoveShadeMessageFor:(float)inTime afterDelay:(float)inDelay {
	if (loading) {
		[UIView animateWithDuration:inTime delay:inDelay options:UIViewAnimationOptionCurveEaseIn animations:^{ loading.alpha = 0; } completion:^(BOOL finished){ [loading removeFromSuperview]; loading = nil; }];
	}
}

+ (void)displayShadeMessage:(NSString*)pMessage {
	if (loading && message) {
		message.text = pMessage;
		return;
	}
	CGRect frect = [[(UIWindow*)[[UIApplication sharedApplication] delegate] window] frame];
	loading = [[UIView alloc] initWithFrame:frect];
	[(UIWindow*)[[[UIApplication sharedApplication] delegate] window] addSubview:loading];
	
	UIView* shade = [[UIView alloc] initWithFrame:frect];
	shade.backgroundColor = [UIColor blackColor];
	shade.alpha = 0.8;
	[loading addSubview:shade];
	
	message = [[UILabel alloc] initWithFrame:frect];
	message.backgroundColor = [UIColor clearColor];
	message.textAlignment = UITextAlignmentCenter;
	message.textColor = [UIColor whiteColor];
	message.font = [UIFont boldSystemFontOfSize:24];
	message.text = pMessage;
	[loading addSubview:message];
	
	UIActivityIndicatorView* ai = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	ai.center = message.center;
	
	UIViewController* mainView = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
	
	if ([mainView interfaceOrientation] == UIInterfaceOrientationLandscapeRight) {
		ai.frame = CGRectMake(ai.frame.origin.x + 75.0, ai.frame.origin.y, ai.frame.size.width, ai.frame.size.height);
		CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_2);
		message.transform = transform;
	}
	else if ([mainView interfaceOrientation] == UIInterfaceOrientationPortraitUpsideDown) {
		ai.frame = CGRectMake(ai.frame.origin.x, ai.frame.origin.y - 75.0, ai.frame.size.width, ai.frame.size.height);
		CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
		message.transform = transform;
	}
	else if ([mainView interfaceOrientation] == UIInterfaceOrientationLandscapeLeft) {
		ai.frame = CGRectMake(ai.frame.origin.x - 75.0, ai.frame.origin.y, ai.frame.size.width, ai.frame.size.height);
		CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI_2);
		message.transform = transform;
	}
	else {
		ai.frame = CGRectMake(ai.frame.origin.x, ai.frame.origin.y + 75.0, ai.frame.size.width, ai.frame.size.height);
	}
	
	[ai startAnimating];
	[loading addSubview:ai];
}
@end
