//
//  SettingsController.h
//  iFifteen
//
//  Created by AKEB on 9/2/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainMenuViewController;

@interface SettingsController : UIViewController {
	UINavigationController *rootController;
	
	MainMenuViewController *mainMenu;
	
	UISlider *SoundVolume;
	UISwitch *SoundOn;
	UISegmentedControl *BoxKind;
	NSUserDefaults *set;
	UIActivityIndicatorView *indicator;
	
	
}

@property (nonatomic, retain) IBOutlet UINavigationController *rootController;
@property (nonatomic, retain) IBOutlet MainMenuViewController *mainMenu;

@property (nonatomic, retain) IBOutlet UISlider *SoundVolume;
@property (nonatomic, retain) IBOutlet UISwitch *SoundOn;
@property (nonatomic, retain) IBOutlet UISegmentedControl *BoxKind;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *indicator;



-(IBAction) back:(id) sender;
-(IBAction) saveSettings:(id) sender;

@end
