//
//  FlipsideView.m
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import "RatingTableViewController.h"
#import "RatingView.h"


@implementation RatingView


-(id) initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}

-(void) drawRect:(CGRect)rect {
	// Drawing code
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320, 436.0)];
	
	RatingTableViewController *ratings = [[RatingTableViewController alloc] initWithStyle:UITableViewStylePlain];
	[view addSubview:ratings.view ];
	
	[self addSubview:view];
	
	
}

-(void) dealloc {
	[super dealloc];
}

@end
