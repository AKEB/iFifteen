/*
 * Copyright 2010 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "FriendsRequestResult.h"
#import "Util.h"



@implementation FriendsRequestResult

- (id) initializeWithDelegate:(id<FriendsRequestDelegate>)delegate {
  self = [super init];
  _friendsRequestDelegate = [delegate retain];
  return self;   
}

/**
 * FBRequestDelegate
 */
- (void)request:(FBRequest*)request didLoad:(id)result{
	
    NSMutableArray *friendsInfo = [[[NSMutableArray alloc] init] autorelease];
	NSMutableDictionary *FriendsRating  = [[NSMutableDictionary alloc] init];
	
	
	NSLog(@"Load Friends Rating");
	NSString *friends = @"";
	for (NSDictionary *item in result) {
		NSString *friend_id = [NSString stringWithString:[[item objectForKey:@"uid"] stringValue]];
		friends = [friends stringByAppendingFormat:@"%@,",friend_id];
	}
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.akeb.ru/pub/iPhoneApi.php?action=get_record&version=400&app_id=1&friends=%@",friends]];
	NSLog(@"url=[%@]",url);
	NSString *PageData = [NSString stringWithContentsOfURL:url];
	NSLog(@"Parsing Friends Rating");
	NSArray *listItems = [PageData componentsSeparatedByString:@":"];
	if ([listItems count] > 1) {
		for (NSString *v in listItems) {
			NSArray *listItemsPers = [v componentsSeparatedByString:@","];
			if ([listItemsPers count] > 1) {
				[FriendsRating setValue:[listItemsPers objectAtIndex:1] forKey:[NSString stringWithFormat:@"point1%@",[listItemsPers objectAtIndex:0]]];
				[FriendsRating setValue:[listItemsPers objectAtIndex:2] forKey:[NSString stringWithFormat:@"min1%@",[listItemsPers objectAtIndex:0]]];
				[FriendsRating setValue:[listItemsPers objectAtIndex:3] forKey:[NSString stringWithFormat:@"sec1%@",[listItemsPers objectAtIndex:0]]];
				
				[FriendsRating setValue:[listItemsPers objectAtIndex:4] forKey:[NSString stringWithFormat:@"point2%@",[listItemsPers objectAtIndex:0]]];
				[FriendsRating setValue:[listItemsPers objectAtIndex:5] forKey:[NSString stringWithFormat:@"min2%@",[listItemsPers objectAtIndex:0]]];
				[FriendsRating setValue:[listItemsPers objectAtIndex:6] forKey:[NSString stringWithFormat:@"sec2%@",[listItemsPers objectAtIndex:0]]];
				
			}
		}
		
	}
	NSLog(@"Load Friends Rating END");
	
    for (NSDictionary *info in result) {
		NSString *friend_id = [NSString stringWithString:[[info objectForKey:@"uid"] stringValue]];
		
		//NSMutableDictionary *fInfo = [FriendsRating objectForKey:[NSString stringWithFormat:@"%@",friend_id]];
		
		NSString *friend_point1 = [FriendsRating objectForKey:[NSString stringWithFormat:@"point1%@",friend_id]];
		NSString *friend_min1 = [FriendsRating objectForKey:[NSString stringWithFormat:@"min1%@",friend_id]];
		NSString *friend_sec1 = [FriendsRating objectForKey:[NSString stringWithFormat:@"sec1%@",friend_id]];
		
		NSString *friend_point2 = [FriendsRating objectForKey:[NSString stringWithFormat:@"point2%@",friend_id]];
		NSString *friend_min2 = [FriendsRating objectForKey:[NSString stringWithFormat:@"min2%@",friend_id]];
		NSString *friend_sec2 = [FriendsRating objectForKey:[NSString stringWithFormat:@"sec2%@",friend_id]];
		
		if ([friend_point1 intValue] == 0 && [friend_point2 intValue] == 0) continue;
		
		//NSLog(@"friend_point=%@ friend_min=%@ friend_sec=%@",friend_point,friend_min,friend_sec);
		
		 
		NSString *friend_name = nil;
		if ([info objectForKey:@"name"] != [NSNull null]) {
			friend_name = [NSString stringWithString:[info objectForKey:@"name"]];
		}
		NSString *friend_pic = [info objectForKey:@"pic_square"];
		NSString *friend_status = [info objectForKey:@"status"];
		NSMutableDictionary *friend_info = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                          friend_id,@"uid",
                                          friend_name, @"name",
                                          friend_pic, @"pic",
                                          friend_status, @"status",
										  friend_point1, @"point1",
										  friend_min1, @"min1",
										  friend_sec1, @"sec1",
										  friend_point2, @"point2",
										  friend_min2, @"min2",
										  friend_sec2, @"sec2",
                                          nil];
		//NSLog(@"FRIEND ID %@",friend_id);
		[friendsInfo addObject:friend_info];
		
    }

    [_friendsRequestDelegate FriendsRequestCompleteWithFriendsInfo:friendsInfo];
    
}


@end
