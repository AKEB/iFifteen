#import <UIKit/UIKit.h>

@class SampleOFDelegate;
@class SampleOFNotificationDelegate;
@class SampleOFChallengeDelegate;

@class MainMenuViewController;

@interface iFifteenAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *rootController;
	SampleOFDelegate *ofDelegate;
	SampleOFNotificationDelegate *ofNotificationDelegate;
	SampleOFChallengeDelegate *ofChallengeDelegate;
	
	MainMenuViewController *mainMenuViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *rootController;

@end

