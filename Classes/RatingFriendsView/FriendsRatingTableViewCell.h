//
//  RatingTableViewCell.h
//  iFifteen
//
//  Created by AKEB on 4/9/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsRatingTableViewCell : UITableViewCell {
	UILabel *_primaryLabel;
	
	UILabel *_point1Label;
	UILabel *_Label1;
	UILabel *_time1Label;

	UILabel *_point2Label;
	UILabel *_Label2;
	UILabel *_time2Label;
	
	UIImageView *_runImageView;
}

@property(nonatomic,retain)UILabel *primaryLabel;

@property(nonatomic,retain)UILabel *point1Label;
@property(nonatomic,retain)UILabel *Label1;
@property(nonatomic,retain)UILabel *time1Label;

@property(nonatomic,retain)UILabel *point2Label;
@property(nonatomic,retain)UILabel *Label2;
@property(nonatomic,retain)UILabel *time2Label;

@property(nonatomic,retain)UIImageView *runImageView;


@end

