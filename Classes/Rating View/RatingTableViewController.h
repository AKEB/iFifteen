//
//  RatingTableViewController.h
//  iFifteen
//
//  Created by AKEB on 4/8/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RatingTableViewCell;

@interface RatingTableViewController : UITableViewController {
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	NSMutableArray *RatingData1;
	NSMutableArray *RatingData2;
	
	RatingTableViewCell *ratingTableViewCell;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) NSMutableArray *RatingData1;
@property (nonatomic, retain) NSMutableArray *RatingData2;

@property (nonatomic, assign) IBOutlet RatingTableViewCell *ratingTableViewCell;

@property (nonatomic, readonly) NSString *applicationDocumentsDirectory;



@end
