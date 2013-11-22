//
//  MainView.m
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import "MainView.h"

@implementation MainView

@synthesize Continue;
@synthesize NewGame;

-(id) initWithFrame:(CGRect)frame {
	NSLog(@"MainView initWithFrame");
	if (self = [super initWithFrame:frame]) {
		// Initialization code
		
	}
	return self;
}

-(void) checkContinue {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/Save.xml",NSHomeDirectory()]];
	NSString *SSTATUS = [params valueForKey:@"STATUS"];
	if ([SSTATUS intValue] == 1) {
		NSLog(@"GOOD LOAD");
		Continue.hidden = false;
		NewGame.hidden = true;
	} else {
		NSLog(@"FALSE LOAD");
		Continue.hidden = true;
		NewGame.hidden = false;
	}
}


-(void) drawRect:(CGRect)rect {
	NSLog(@"MainView drawRect");
	// Drawing code
	[self checkContinue];
	
	
}

- (void)dealloc {
	[super dealloc];
}

@end
