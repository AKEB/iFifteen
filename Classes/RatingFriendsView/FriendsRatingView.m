//
//  FlipsideView.m
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import "FriendsRatingTableViewController.h"
#import "FriendsRatingView.h"
#import "UserInfo.h"



@implementation FriendsRatingView

@synthesize parent;

-(id) initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}

-(void) drawRect:(CGRect)rect {
	// Drawing code
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320, 436.0)];
	
	FriendsRatingTableViewController *friendsRatings = [[FriendsRatingTableViewController alloc] initWithStyle:UITableViewStylePlain];
	[friendsRatings setUserInfo:[parent userInfo]];
	[view addSubview:friendsRatings.view ];
	
	[self addSubview:view];
	
	
}

-(void) dealloc {
	[super dealloc];
}

@end
