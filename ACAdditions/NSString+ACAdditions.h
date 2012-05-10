//
//  NSString+ACAdditions.h
//  ACAdditions
//
//  Created by Adam Burkepile on 5/10/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#import <Foundation/Foundation.h>

#define applicationDelegate [[UIApplication sharedApplication] delegate]

/**
 Use this directory to store user documents and application 
 data files. The contents of this directory can be made 
 available to the user through file sharing, which is 
 described in “Sharing Files with the User’s Desktop Computer.”
 
 The contents of this directory are backed up by iTunes.
 */
#define applicationDocumentsDirectoryString [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/"]
#define applicationDocumentsDirectoryURL [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]

/**
 This directory is the top-level directory for files that 
 are not user data files. You typically put files in one 
 of several standard subdirectories but you can also create 
 custom subdirectories for files you want backed up but not 
 exposed to the user. (For information on how to get references 
 to the standard subdirectories, see “Getting Paths to Standard 
 Application Directories.”) You should not use this directory 
 for user data files.
 
 The contents of this directory (with the exception of the Caches 
 subdirectory) are backed up by iTunes.
 */
#define applicationLibraryDirectoryString [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/"]
#define applicationLibraryDirectoryURL [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject]

/**
 Use this directory to write any application-specific support files 
 that you want to persist between launches of the application or 
 during application updates. Your application is generally responsible 
 for adding and removing these files. It should also be able to 
 re-create these files as needed because iTunes removes them during 
 a full restoration of the device.
 
 In iOS 2.2 and later, the contents of this directory are not backed up by iTunes.  
 */
#define applicationCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"/"]
#define applicationTempDirectory NSTemporaryDirectory()

#define applicationName (__bridge NSString*)CFBundleGetValueForInfoDictionaryKey(CFBundleGetMainBundle(),(CFStringRef)@"CFBundleExecutable")

#define isIpad (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)

@interface NSString (ACAdditions)
- (BOOL)isEqualToStringSafe:(NSString*)inString;
@end
