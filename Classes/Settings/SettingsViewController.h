//
//  FlipsideViewController.h
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

@protocol SettingsViewControllerDelegate;


@interface SettingsViewController : UIViewController {
	id <SettingsViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <SettingsViewControllerDelegate> delegate;

-(IBAction) done;

@end

@protocol SettingsViewControllerDelegate

-(void) SettingsViewControllerDidFinish:(SettingsViewController *)controller;

@end

