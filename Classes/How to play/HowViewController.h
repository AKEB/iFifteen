//
//  FlipsideViewController.h
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

@protocol HowViewControllerDelegate;


@interface HowViewController : UIViewController {
	id <HowViewControllerDelegate> delegate;
}

@property (nonatomic, assign) id <HowViewControllerDelegate> delegate;
- (IBAction)done;

@end


@protocol HowViewControllerDelegate
- (void)howViewControllerDidFinish:(HowViewController *)controller;
@end

