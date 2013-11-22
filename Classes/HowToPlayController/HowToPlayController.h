//
//  HowToPlayController.h
//  iFifteen
//
//  Created by AKEB on 9/2/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HowToPlayController : UIViewController {
	UINavigationController *rootController;
}

@property (nonatomic, retain) IBOutlet UINavigationController *rootController;


-(IBAction) back:(id) sender;

@end
