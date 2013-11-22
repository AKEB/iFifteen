//
//  RatingTableViewController.m
//  iFifteen
//
//  Created by AKEB on 4/8/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "RatingTableViewController.h"
#import "RatingModel.h"
#import "RatingTableViewCell.h"

@implementation RatingTableViewController


@synthesize RatingData1,RatingData2,ratingTableViewCell;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"HiScore";
    
	self.tableView.rowHeight = 53;
	
	managedObjectContext = [self managedObjectContext];
	if (!managedObjectContext) {
		// Handle the error.
		NSLog(@"Unresolved error (no context)");
		exit(-1);  // Fail
	}
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"RatingModel" inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];

	
	// Order the events by creation date, most recent first.
	NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"point" ascending:YES];
	NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"timeMin" ascending:YES];
	NSSortDescriptor *sortDescriptor3 = [[NSSortDescriptor alloc] initWithKey:@"timeSec" ascending:YES];
	
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, sortDescriptor2, sortDescriptor3, nil];
	[request setSortDescriptors:sortDescriptors];
	[sortDescriptor1 release];
	[sortDescriptor2 release];
	[sortDescriptor3 release];
	
	[sortDescriptors release];
	
	
	NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(type = %d)",1];
	[request setPredicate:predicate1];

	NSError *error1 = nil;
	NSMutableArray *mutableFetchResults1 = [[managedObjectContext executeFetchRequest:request error:&error1] mutableCopy];
	if (mutableFetchResults1 == nil) {
		NSLog(@"Unresolved error %@, %@", error1, [error1 userInfo]);
		exit(-1);
	}
	[self setRatingData1:mutableFetchResults1];
	[mutableFetchResults1 release];
	
	
	NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"(type = %d)",2];
	[request setPredicate:predicate2];

	NSError *error2 = nil;
	NSMutableArray *mutableFetchResults2 = [[managedObjectContext executeFetchRequest:request error:&error2] mutableCopy];
	if (mutableFetchResults2 == nil) {
		NSLog(@"Unresolved error %@, %@", error2, [error2 userInfo]);
		exit(-1);
	}
	[self setRatingData2:mutableFetchResults2];
	[mutableFetchResults2 release];
	[request release];
	
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
		case(0):
			return [RatingData1 count] == nil ? 5 : ([RatingData1 count] > 15 ? 15 : [RatingData1 count]);
			break;
		case (1):
			return [RatingData2 count] == nil ? 5 : ([RatingData2 count] > 15 ? 15 : [RatingData2 count]);
			break;
	}
	return 10;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case(0):
			return @"123";
			break;
		case(1):
			return @"ABC";
			break;
	}
	return nil;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d:%d", [indexPath indexAtPosition:0],[indexPath indexAtPosition:1]];
	//static NSString *CellIdentifier = @"RatingTableViewCell";
	NSLog(@"START CELL %d:%d", [indexPath indexAtPosition:0],[indexPath indexAtPosition:1]);
	NSString *name;
	NSString *point;
	NSString *timeMin;
	NSString *timeSec;
	
	static NSNumberFormatter *numberFormatter = nil;
	if (numberFormatter == nil) {
		numberFormatter = [[NSNumberFormatter alloc] init];
		[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		//[numberFormatter setMaximumFractionDigits:3];
	}
	
	name = nil;
	if ([indexPath indexAtPosition:0] == 0) {
		if ([RatingData1 count] > [indexPath indexAtPosition:1]) {
			RatingModel *Rating = (RatingModel *)[RatingData1 objectAtIndex:[indexPath indexAtPosition:1]];
			name = Rating.name;
			point = [numberFormatter stringFromNumber:[Rating point]];
			timeMin = [numberFormatter stringFromNumber:[Rating timeMin]];
			timeSec = [numberFormatter stringFromNumber:[Rating timeSec]];
		}
	} else {
		if ([RatingData2 count] > [indexPath indexAtPosition:1]) {
			RatingModel *Rating = (RatingModel *)[RatingData2 objectAtIndex:[indexPath indexAtPosition:1]];
			name = Rating.name;
			point = [numberFormatter stringFromNumber:[Rating point]];
			timeMin = [numberFormatter stringFromNumber:[Rating timeMin]];
			timeSec = [numberFormatter stringFromNumber:[Rating timeSec]];
		}
	}
	RatingTableViewCell *cell = (RatingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"RatingTableViewCell" owner:self options:nil];
		cell = ratingTableViewCell;
		self.ratingTableViewCell = nil;
    }
	cell.number.text = [NSString stringWithFormat:@"%d",([indexPath indexAtPosition:1]+1)];
	if (name) {
		cell.name.text = name;
		cell.point.text = point;
		cell.time.text = [NSString stringWithFormat:@"%.2d:%.2d",[timeMin intValue],[timeSec intValue]];
	}
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

- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"iFifteenRating.sqlite"]];
	
	NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
    }    
	
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}




- (void)dealloc {
	[managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
	
    [super dealloc];
}


@end

