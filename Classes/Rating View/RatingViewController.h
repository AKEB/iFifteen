//
//  FlipsideViewController.h
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

@protocol RatingViewControllerDelegate;


@interface RatingViewController : UIViewController {
	id <RatingViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <RatingViewControllerDelegate> delegate;

-(IBAction) done;

@end

@protocol RatingViewControllerDelegate

-(void) ratingViewControllerDidFinish:(RatingViewController *)controller;

@end

