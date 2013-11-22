//
//  SettingsController.mm
//  iFifteen
//
//  Created by AKEB on 9/2/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "SettingsController.h"
#import "MainMenuViewController.h"

@implementation SettingsController

@synthesize rootController;
@synthesize SoundVolume;
@synthesize SoundOn;
@synthesize BoxKind;
@synthesize indicator;
@synthesize mainMenu;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
		//NSLog(@"[SettingsController initWithNibName]");
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

-(IBAction) back:(id) sender {
		//NSLog(@"[SettingsController back]");
	[mainMenu checkContinueButton];
	[rootController popViewControllerAnimated:true];
	[self release];
}

-(IBAction) saveSettings:(id) sender {
		//NSLog(@"[SettingsController saveSettings]");
	[indicator startAnimating];
	[indicator setHidden:false];
	
	[set setFloat:[SoundVolume value] forKey:@"soundVolume"];
	[set setBool:[SoundOn isOn] forKey:@"soundOn"];
	[set setObject:[NSString stringWithFormat:@"%d",[BoxKind selectedSegmentIndex]] forKey:@"BlockKind"];
	[set synchronize];
	
	[indicator stopAnimating];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
		//NSLog(@"[SettingsController viewDidLoad]");
    [super viewDidLoad];
	
	set = [[NSUserDefaults alloc] init];
	NSDictionary *settings = [set dictionaryRepresentation];
	NSString *SoundVolumeSettings = [settings valueForKey:@"soundVolume"];
	NSString *SoundOnSettings = [settings valueForKey:@"soundOn"];
	NSString *BlockKindSettings = [settings valueForKey:@"BlockKind"];
	
	[SoundOn setOn:[SoundOnSettings boolValue]];
	[SoundVolume setValue:[SoundVolumeSettings floatValue]];
	[BoxKind setSelectedSegmentIndex:[BlockKindSettings intValue]];
	
	[indicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
		//NSLog(@"[SettingsController didReceiveMemoryWarning]");
	[super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
		//NSLog(@"[SettingsController viewDidUnload]");
    [super viewDidUnload];
}


- (void)dealloc {
		//NSLog(@"[SettingsController dealloc]");
	[SoundVolume release];
	[SoundOn release];
	[BoxKind release];
	[indicator release];
	[set release];
	
	[super dealloc];
}


@end
