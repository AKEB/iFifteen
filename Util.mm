//
//  Util.mm
//  iFifteen
//
//  Created by AKEB on 9/4/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "Util.h"
#import "Settings.h"

@implementation Util

-(id) init {
		//NSLog(@"[Util init]");
	if (self = [super init]) {
		systemVersion = [[UIDevice currentDevice] systemVersion];
		uniqId = [[UIDevice currentDevice] uniqueIdentifier];
	}
	return self;
}

// generates a unique id from a string
+ (NSString *)MD5:(NSString *)source {
		//NSLog(@"[Util MD5]");
	const char *src = [source UTF8String];
	unsigned char result[16];
	CC_MD5(src, strlen(src), result);
	
	NSString *ret = [[[NSString alloc] initWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
					  result[0], result[1], result[2], result[3],
					  result[4], result[5], result[6], result[7],
					  result[8], result[9], result[10], result[11],
					  result[12], result[13], result[14], result[15]
					  ] autorelease];
	NSString *Out = [ret lowercaseString];
	return Out;
}

+(NSString *)decline:(int)point string1:(NSString *)s1 string234:(NSString *)s234 stringMany:(NSString *)sMany {
	NSString *s;
	int d;
	s = sMany;
	d = point % 100;
	if ((d < 10) || (d > 20)) {
		int l = point % 10;
		if (l == 1) s = s1;
		if ((l >= 2) && (l <= 4)) s = s234;
	}
	return s;
}


- (void) SendCommand:(NSString *)query {
		//NSLog(@"[Util SendCommand:%@]",query);
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@?%@",AKEB_HOST,AKEB_SCRIPT,query]];
	[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
}

- (void) SendAddUser {
		//NSLog(@"[Util SendAddUser]");
	NSString *StringForHash = [NSString stringWithFormat:@"%@app_id=%@version=%@system=%@uniqid=%@",AKEB_SECRET,AKEB_APP_ID,AKEB_VERSION,systemVersion,uniqId];
	NSString *query = [NSString stringWithFormat:@"action=add_user&version=%@&app_id=%@&system=%@&uniqid=%@&hash=%@",AKEB_VERSION,AKEB_APP_ID,systemVersion,uniqId,[Util MD5:StringForHash]];
	[self SendCommand:query];
}

- (void) SendFinishGame:(int)point min:(int)min sec:(int)sec kind:(int)kind {
		//NSLog(@"[Util SendFinishGame:%d min:%d sec:%d kind:%d]",point, min, sec, kind);
	NSString *StringForHash = [NSString stringWithFormat:@"%@app_id=%@uid=point=%dlevel=0min=%dsec=%dversion=%@uniqid=%@kind=%d",AKEB_SECRET,AKEB_APP_ID,point,min,sec,AKEB_VERSION,uniqId,kind];
	NSString *query = [NSString stringWithFormat:@"action=add_record&version=%@&app_id=%@&uniqid=%@&uid=&point=%d&level=0&min=%d&sec=%d&kind=%d&hash=%@",AKEB_VERSION,AKEB_APP_ID,uniqId,point,min,sec,kind,[Util MD5:StringForHash]];
	[self SendCommand:query];
}


@end
