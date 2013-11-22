//
//  iFifteenAppDelegate.h
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

@class MainViewController;

@interface iFifteenAppDelegate : NSObject <UIApplicationDelegate> {
	
	UIWindow *window;
	MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MainViewController *mainViewController;

@end

