//
//  Util.h
//  iFifteen
//
//  Created by AKEB on 8/23/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//


#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>


@interface Util : NSObject {

}

+ (NSString *)uniqueIDFromString:(NSString *)source;

@end
