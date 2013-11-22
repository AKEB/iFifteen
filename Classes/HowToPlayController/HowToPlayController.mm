//
//  HowToPlayController.mm
//  iFifteen
//
//  Created by AKEB on 9/2/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "HowToPlayController.h"


@implementation HowToPlayController

@synthesize rootController;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

-(IBAction) back:(id) sender {
	[rootController popViewControllerAnimated:true];
	[self release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}


@end
