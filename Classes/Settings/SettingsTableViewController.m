//
//  SettingsTableViewController.m
//  iFifteen
//
//  Created by AKEB on 3/23/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "SettingsTableViewController.h"

@implementation SettingsTableViewController

-(id) initWithStyle:(UITableViewStyle)style {
	// Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
	if (self = [super initWithStyle:style]) {
		set = [[NSUserDefaults alloc] init];
		settings = [set dictionaryRepresentation];
		SoundVolumeSettings = [settings valueForKey:@"soundVolume"];
		SoundOnSettings = [settings valueForKey:@"soundOn"];
		BlockKindSettings = [settings valueForKey:@"BlockKind"];
		VersionSettings = [settings valueForKey:@"Version"];
	}
	return self;
}

// Override to allow orientations other than the default portrait orientation.
-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
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

#pragma mark Table view methods

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 4;
}

// Customize the number of rows in the table view.
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case (0):
			return 2;
			break;
		case (1):
			return 1;
			break;
		case (2):
			return 1;
			break;
		case (3):
			return 0;
			break;
	}
	return 0;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case(0):
			return NSLocalizedString(@"Sound",@"");
			break;
		case(1):
			return NSLocalizedString(@"GameSettings",@"");
			break;
		case(2):
			return @"";
			break;
		case (3):
			return NSLocalizedString(@"Copyright",@"");
			break;
	}
	return nil;
}

-(void) SoundVolume: (id)sender {
	UISlider *control = (UISlider *) sender;
	[set setObject:[NSString stringWithFormat:@"%f",control.value] forKey:@"soundVolume"];
	[set synchronize];
}

-(void) SoundOn: (id)sender {
	UISwitch *control = (UISwitch *) sender;
	[set setBool:control.on forKey:@"soundOn"];
	[set synchronize];
}

-(void) BlocksKind: (id)sender {
	UISegmentedControl *control = (UISegmentedControl *) sender;
	NSLog(@"%d",control.selectedSegmentIndex);
	[set setInteger:control.selectedSegmentIndex forKey:@"BlockKind"];
	[set synchronize];
}


// Customize the appearance of table view cells.
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *CellIdentifier = [NSString stringWithFormat:@"%d:%d", [indexPath indexAtPosition:0],[indexPath indexAtPosition:1]];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] 
			initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		switch ([indexPath indexAtPosition:0]) {
			case (0):
				switch ([indexPath indexAtPosition:1]) {
					case (0):
						SoundVolume = [[UISlider alloc] initWithFrame: CGRectMake(170.0, 0.0, 125.0, 50.0)];
						SoundVolume.minimumValue = 0.0;
						SoundVolume.maximumValue = 1.0;
						SoundVolume.value = [SoundVolumeSettings floatValue];
						[SoundVolume addTarget:self action:@selector(SoundVolume:) forControlEvents:UIControlEventValueChanged];
						[cell addSubview:SoundVolume];
						cell.text = NSLocalizedString(@"SoundVolume",@"");
						break;
					case(1):
						SoundOn = [[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 0, 0)];
						SoundOn.on = [SoundOnSettings boolValue];
						[SoundOn addTarget:self action:@selector(SoundOn:) forControlEvents:UIControlEventValueChanged];
						[cell addSubview:SoundOn];
						cell.text = NSLocalizedString(@"SoundOn",@"");
						break;
				}
				break;
			case (1):
				switch ([indexPath indexAtPosition:1]) {
					case (0):
						BlocksKind = [[UISegmentedControl alloc] initWithFrame:CGRectMake(170, 5, 125, 35)];
						[BlocksKind insertSegmentWithTitle:@" 123 " atIndex:0 animated:NO];
						[BlocksKind insertSegmentWithTitle:@" ABC " atIndex:1 animated:NO];
						BlocksKind.selectedSegmentIndex = [BlockKindSettings intValue];
						[BlocksKind addTarget:self action:@selector(BlocksKind:) forControlEvents:UIControlEventValueChanged];
						[cell addSubview:BlocksKind];
						cell.text = NSLocalizedString(@"BlockKind",@"");
						break;
				}
				break;
			case(2):
				switch ([indexPath indexAtPosition:1]) {
					case (0):
						Version = [[UITextField alloc] initWithFrame:CGRectMake(240, 10, 70, 38)];
						Version.text = @"4.0"; //VersionSettings;
						[cell addSubview:Version];
						[Version setEnabled:NO];
						cell.text = NSLocalizedString(@"Version",@"");
						break;
				}
				break;
			default:
				break;
		}
	}
	return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

- (void)dealloc {
	[super dealloc];
}

@end

