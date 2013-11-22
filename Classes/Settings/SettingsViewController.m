//
//  FlipsideViewController.m
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsTableViewController.h"

@implementation SettingsViewController

@synthesize delegate;

-(void) viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];
}

-(IBAction) done {
	[self.delegate SettingsViewControllerDidFinish:self];	
}

-(void) didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(void) viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void) dealloc {
	[super dealloc];
}

@end
