//
//  RatingTableViewCell.h
//  iFifteen
//
//  Created by AKEB on 4/9/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingTableViewCell : UITableViewCell {
	UITextField *name;
	UILabel *time;
	UILabel *point;
	UILabel *number;
}

@property (nonatomic, retain) IBOutlet UITextField *name;
@property (nonatomic, retain) IBOutlet UILabel *time;
@property (nonatomic, retain) IBOutlet UILabel *point;
@property (nonatomic, retain) IBOutlet UILabel *number;


@end

