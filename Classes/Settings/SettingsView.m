//
//  FlipsideView.m
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import "SettingsView.h"
#import "SettingsTableViewController.h"


@implementation SettingsView

-(id) initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}

-(void) drawRect:(CGRect)rect {
	// Drawing code
	
	//UIView *soundSettings
	
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 44.0, 320, 436.0)];
	
	SettingsTableViewController *settings = [[SettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[view addSubview:settings.view ];
	
	[self addSubview:view];
}

- (void)dealloc {
	[super dealloc];
}

@end
