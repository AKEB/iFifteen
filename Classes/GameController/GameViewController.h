//
//  GameViewController.h
//  iFifteen
//
//  Created by AKEB on 9/3/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFCallbackable.h"
#import "OFDefaultTextField.h"
#import "OFLeaderboard.h"
#import "OFCurrentUser.h"


#ifdef __IPHONE_4_1
#import <iAd/iAd.h>
#endif
#import "GADBannerView.h"

@class TimeView;
@class CounterView;
@class GameView;
@class MainMenuViewController;

@interface GameViewController : UIViewController<OFCurrentUserDelegate, OFCallbackable, OFLeaderboardDelegate, OFHighScoreDelegate,ADBannerViewDelegate> {
	UINavigationController *rootController;
	BOOL newGame;
	UIButton *pauseButton;
	UIButton *playButton;
	TimeView *timeView;
	CounterView *counterView;
	GameView *gameView;
	
	MainMenuViewController *menuController;
	
	UIAlertView *newGameAlert;
	BOOL gameIsPaused;
	UIActivityIndicatorView *indicator;
	BOOL connectToSocialNetwork;
	BOOL bannerIsVisible;
#ifdef __IPHONE_4_1
	ADBannerView *bann;
#endif
	GADBannerView *bannerView_;
}

@property (nonatomic, retain) IBOutlet UINavigationController *rootController;
@property (nonatomic, retain) IBOutlet UIButton *pauseButton;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet TimeView *timeView;
@property (nonatomic, retain) IBOutlet CounterView *counterView;
@property (nonatomic, retain) IBOutlet GameView *gameView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *indicator;
@property (nonatomic, retain) IBOutlet MainMenuViewController *menuController;
@property (nonatomic) BOOL gameIsPaused;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil newGame:(BOOL) NewGame;

-(IBAction) onMenu:(id) sender;
-(IBAction) onNewGame:(id) sender;
-(IBAction) onPause:(id) sender;
-(IBAction) onPlay:(id) sender;

- (void) stopGame;
- (void) newGame;
- (void) startGame;
- (void) pauseGame:(BOOL) pause;
- (void) sendHighScore:(int) point min:(int)min sec:(int)sec;
- (void)WillTerminate;

@end
