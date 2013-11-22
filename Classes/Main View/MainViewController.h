//
//  MainViewController.h
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import "FlipsideViewController.h"
#import "HowViewController.h"
#import "SettingsViewController.h"
#import "GameViewController.h"
#import "RatingViewController.h"
#import "FriendsRatingViewController.h"
#import "FBConnect.h"
#import "UserInfo.h"
#import "FBLoginButton.h"
#import "Session.h"


@class MainView;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, FBRequestDelegate, FBDialogDelegate, FBSessionDelegate> {
	GameViewController *gameViewController;
	MainView *mainView;
	IBOutlet FBLoginButton* _fbButton;
	
	UIButton *FriendsRating;
	
	Facebook* _facebook;
	Session *_session;
	UserInfo *_userInfo;
	NSArray* _permissions;
}

@property (nonatomic, retain) IBOutlet MainView *mainView;
@property (nonatomic, retain) IBOutlet UIButton *FriendsRating;


-(IBAction) showInfo;
-(IBAction) showGame;
-(IBAction) showSettings;
-(IBAction) showHow;
-(IBAction) showRating;
-(IBAction) showFriendsRating;


- (IBAction) publishStream: (id) sender;
-(IBAction) fbButtonClick: (id) sender;
-(void) Publish:(NSString *)min seconds:(NSString *)sec Points:(NSString *)point;

-(id) getManagedObjectContext;



@end
