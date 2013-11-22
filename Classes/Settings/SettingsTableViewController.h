//
//  SettingsTableViewController.h
//  iFifteen
//
//  Created by AKEB on 3/23/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController {
	UISlider *SoundVolume;
	UISwitch *SoundOn;
	UISegmentedControl *BlocksKind;
	UITextField *Version;
	NSUserDefaults *set;
	NSDictionary *settings;
	NSString *SoundOnSettings;
	NSString *SoundVolumeSettings;
	NSString *DEBUGSettingSettings;
	NSString *BlockKindSettings;
	NSString *VersionSettings;
}

-(id) init;
-(void) dealloc;
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView;
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
