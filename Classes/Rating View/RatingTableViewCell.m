//
//  RatingTableViewCell.m
//  iFifteen
//
//  Created by AKEB on 4/9/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "RatingTableViewCell.h"

@implementation RatingTableViewCell

@synthesize name, time, point, number;


- (void)willTransitionToState:(UITableViewCellStateMask)state {
	[super willTransitionToState:state];
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
	[super didTransitionToState:state];
}

- (void)dealloc {
	[name release];
	[time release];
	[point release];
	[number release];
    [super dealloc];
}


@end
