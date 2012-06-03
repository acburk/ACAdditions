//
//  ACLogging.h
//  ACAdditions
//
//  Created by Adam Burkepile on 5/9/12.
//  Copyright (c) 2012 Adam Burkepile. All rights reserved.
//

#ifndef ACAdditions_ACLogging_h
#define ACAdditions_ACLogging_h

#define LOG_Debug 1
#define LOG_DataLoad 2
#define LOG_HTTP 4

#if DEBUG|RELEASE
#define LOG_FLAGS (LOG_Debug | LOG_DataLoad | LOG_HTTP)
#if DEBUG >= 3
#define TLog(type,...) if (type & LOG_FLAGS) NSLog(@"%@     %s,%d",[NSString stringWithFormat:__VA_ARGS__],__PRETTY_FUNCTION__, __LINE__)
#define VLog(level,...) if (DEBUG >= level) NSLog(@"%@     %s,%d",[NSString stringWithFormat:__VA_ARGS__],__PRETTY_FUNCTION__, __LINE__)
#define DLog(...) NSLog(@"%@     %s,%d",[NSString stringWithFormat:__VA_ARGS__],__PRETTY_FUNCTION__, __LINE__)
#define ALog(...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__]
#define CMLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define MARK	CMLog(@"");
#else
#define TLog(type,...) if (type & LOG_FLAGS) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#define VLog(level,...) if (DEBUG >= level) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#define DLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])
#define ALog(...) [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__]
#define CMLog(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define MARK	CMLog(@"");
#endif
#else
#define TLog(type,...) do { } while (0)
#define VLog(level,...) do { } while (0)
#define DLog(...) do { } while (0)
#define MARK do { } while (0);
#ifndef NS_BLOCK_ASSERTIONS
#define NS_BLOCK_ASSERTIONS
#endif
#define ALog(...) NSLog(@"%@     %s", [NSString stringWithFormat:__VA_ARGS__], __PRETTY_FUNCTION__)
#endif

#define ZAssert(condition, ...) do { if (!(condition)) { ALog(__VA_ARGS__); }} while(0)

#endif
