//
//  RatingTableViewController.h
//  iFifteen
//
//  Created by AKEB on 4/8/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>


@class UserInfo;
@class FriendsRatingTableViewCell;

@interface FriendsRatingTableViewController : UITableViewController {
	UserInfo *_userInfo;
}

@property(nonatomic, retain) UserInfo *userInfo;

@end
