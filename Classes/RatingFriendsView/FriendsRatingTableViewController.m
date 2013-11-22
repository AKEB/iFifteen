//
//  RatingTableViewController.m
//  iFifteen
//
//  Created by AKEB on 4/8/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "FriendsRatingTableViewController.h"
#import "FriendsRatingTableViewCell.h"

@implementation FriendsRatingTableViewController

@synthesize userInfo = _userInfo;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	self.tableView.rowHeight = 60;
	
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [[_userInfo friendsInfo] count];
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d:%d", [indexPath indexAtPosition:0],[indexPath indexAtPosition:1]];
	NSLog(@"START CELL %d:%d", [indexPath indexAtPosition:0],[indexPath indexAtPosition:1]);
	static NSNumberFormatter *numberFormatter = nil;
	if (numberFormatter == nil) {
		numberFormatter = [[NSNumberFormatter alloc] init];
		[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	}
	FriendsRatingTableViewCell *cell = (FriendsRatingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[FriendsRatingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	NSMutableDictionary *cellValue = [[_userInfo friendsInfo] objectAtIndex:indexPath.row];
    NSString *picURL = [cellValue objectForKey:@"pic"];
    if ((picURL != (NSString *) [NSNull null]) && (picURL.length !=0)) {
		NSData *imgData = [[[NSData dataWithContentsOfURL:
							 [NSURL URLWithString:
							  [cellValue objectForKey:@"pic"]]] autorelease] retain];
		cell.runImageView.image = [[UIImage alloc] initWithData:imgData];
    } else {
		cell.runImageView.image = nil;
    }
    cell.primaryLabel.text = [cellValue objectForKey:@"name"]; 
	
	cell.point1Label.text = [cellValue objectForKey:@"point1"];
	cell.Label1.text = @"123...";
	cell.time1Label.text = [NSString stringWithFormat:@"%.2d:%.2d",[[cellValue objectForKey:@"min1"] intValue],[[cellValue objectForKey:@"sec1"] intValue]];
    
	cell.point2Label.text = [cellValue objectForKey:@"point2"];
	cell.Label2.text = @"ABC...";
	cell.time2Label.text = [NSString stringWithFormat:@"%.2d:%.2d",[[cellValue objectForKey:@"min2"] intValue],[[cellValue objectForKey:@"sec2"] intValue]];
    
	
	
	// Configure the cell...
    NSLog(@"END CELL %d:%d", [indexPath indexAtPosition:0],[indexPath indexAtPosition:1]);
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}




- (void)dealloc {
    [super dealloc];
}


@end

