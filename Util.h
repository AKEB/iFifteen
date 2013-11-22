//
//  Util.h
//  iFifteen
//
//  Created by AKEB on 9/4/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import "Settings.h"

@interface Util : NSObject {
	NSString *systemVersion;
	NSString *uniqId;
}


+ (NSString *)MD5:(NSString *)source;
+(NSString *)decline:(int)point string1:(NSString *)s1 string234:(NSString *)s234 stringMany:(NSString *)sMany;

-(id) init;
- (void)SendCommand:(NSString *)query;
- (void)SendAddUser;
- (void) SendFinishGame:(int)point min:(int)min sec:(int)sec kind:(int)kind;


@end
