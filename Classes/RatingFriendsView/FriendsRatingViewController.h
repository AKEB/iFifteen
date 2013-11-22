//
//  FlipsideViewController.h
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

@protocol FriendsRatingViewControllerDelegate;

@class UserInfo;

@interface FriendsRatingViewController : UIViewController {
	id <FriendsRatingViewControllerDelegate> delegate;
	UserInfo *userInfo;
}

@property (nonatomic, assign) id <FriendsRatingViewControllerDelegate> delegate;
@property(nonatomic, retain) UserInfo *userInfo;


-(IBAction) done;

@end

@protocol FriendsRatingViewControllerDelegate

-(void) friendsRatingViewControllerDidFinish:(FriendsRatingViewController *)controller;

@end

