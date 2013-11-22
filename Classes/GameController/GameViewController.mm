//
//  GameViewController.m
//  iFifteen
//
//  Created by AKEB on 9/3/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "GameViewController.h"
#import "TimeView.h"
#import "GameView.h"
#import "CounterView.h"
#import "Util.h"
#import "MainMenuViewController.h"


#import "OpenFeint.h"
#import "OpenFeint+Dashboard.h"
#import "OFHighScoreService.h"
#import "OFLeaderboardService.h"
#import "OFLeaderboard.h"
#import "OFViewHelper.h"
#import "OFControllerLoader.h"
#import "OFLeaderboard.h"
#import "OFSocialNotificationApi.h"
#import "OFDefaultTextField.h"

#define MY_BANNER_UNIT_ID @"a14de6505903038"

@implementation GameViewController

@synthesize rootController;
@synthesize pauseButton;
@synthesize playButton;
@synthesize timeView;
@synthesize counterView;
@synthesize gameView;
@synthesize indicator;
@synthesize gameIsPaused;
@synthesize menuController;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil newGame:(BOOL) NewGame {

    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		newGame = NewGame;
		
    }
    return self;
}

- (void) viewDidLoad {

    [super viewDidLoad];
	[gameView setParentViewController:self];
	[counterView setParentViewController:self];
	[timeView setParentViewController:self];
	[self release];
	[self release];
	[self release];
	connectToSocialNetwork = false;
	[OFCurrentUser setDelegate:self];
	[OFCurrentUser checkConnectedToSocialNetwork];
	
	
	
	[indicator stopAnimating];
	
	[self performSelectorInBackground:@selector(BannerLoad:) withObject:nil];
	
	
}

- (void) viewDidAppear:(BOOL)animated {

	[OFHighScore setDelegate:self];
	[OFLeaderboard setDelegate:self];
	[OFCurrentUser setDelegate:self];
	[OFCurrentUser checkConnectedToSocialNetwork];

	[super viewDidAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {

	[super viewWillDisappear:animated];
	
	// This class must relinquish it's role as leaderboard delegate.
	[OFLeaderboard setDelegate:nil];
	[OFHighScore setDelegate:nil];
	[OFCurrentUser setDelegate:nil];
}

- (void) viewDidDisappear:(BOOL)animated {

	[super viewDidDisappear:animated];
}

- (bool) canReceiveCallbacksNow {
	return YES;
}

- (void) _highScoreSet {

}

- (void) _highScoreFailedSetting {

	
}

- (void) didCheckConnectedToSocialNetwork:(BOOL)connected {
	if(connected) {
		connectToSocialNetwork = true;
	} else {
		connectToSocialNetwork = false;
	}
	
}

- (void) didFailCheckConnectedToSocialNetwork {
	connectToSocialNetwork = false;
}

- (void) sendHighScore:(int) point min:(int)min sec:(int)sec {
	OFDelegate success = OFDelegate(self, @selector(_highScoreSet));	
	OFDelegate failure = OFDelegate(self, @selector(_highScoreFailedSetting));
	
	NSUserDefaults *set = [[NSUserDefaults alloc] init];
	NSDictionary *settings;
	NSString *BlocksKind;
	
	settings = [set dictionaryRepresentation];
	BlocksKind = [settings valueForKey:@"BlockKind"];
	
	NSString *leadTotalAll = LEADERBOARD_TOTAL;
	NSString *leadStep = LEADERBOARD_N_STEP;
	NSString *leadTime = LEADERBOARD_N_TIME;
	NSString *leadTotal = LEADERBOARD_N_TOTAL;
	
	if([BlocksKind intValue] == 1) {
		leadStep = LEADERBOARD_A_STEP;
		leadTime = LEADERBOARD_A_TIME;
		leadTotal = LEADERBOARD_A_TOTAL;
	}
	
	
	OFLeaderboard *leaderboard;
	NSNumber *num;
	//OFHighScore *score;
	
	leaderboard = [OFLeaderboard leaderboard:leadStep];
	num = [NSNumber numberWithLongLong:[[NSString stringWithFormat:@"%d",point] longLongValue]];
	OFHighScore *score1 = [[[OFHighScore alloc] initForSubmissionWithScore:[num longLongValue]] autorelease];
	score1.displayText = [NSString stringWithFormat:@"%d",point];
	[score1 submitTo:leaderboard];
	//[score release];
	
	
	leaderboard = [OFLeaderboard leaderboard:leadTime];
	num = [NSNumber numberWithLongLong:[[NSString stringWithFormat:@"%d",(min*60)+sec] longLongValue]];
	OFHighScore *score2 = [[[OFHighScore alloc] initForSubmissionWithScore:[num longLongValue]] autorelease];
	score2.displayText = [NSString stringWithFormat:@"%d:%d",min,sec];
	[score2 submitTo:leaderboard];
	//[score release];
	
	
	
	leaderboard = [OFLeaderboard leaderboard:leadTotal];
	OFHighScore *currScore3 = [leaderboard highScoreForCurrentUser];
	int64_t scor3;
	if ([currScore3 score] < 1) {
		currScore3 = [[[OFHighScore alloc] initForSubmissionWithScore:1] autorelease];
		scor3 = 1;
	} else {
		scor3 = [currScore3 score] + 1;
	}
	
	[currScore3 setScore:scor3];
	[currScore3 setDisplayText:[NSString stringWithFormat:@"%d",scor3]];
	[currScore3 submitTo:leaderboard];
	
	leaderboard = [OFLeaderboard leaderboard:leadTotalAll];
	OFHighScore *currScore4 = [leaderboard highScoreForCurrentUser];
	int64_t scor4;
	if ([currScore4 score] < 1) {
		currScore4 = [[[OFHighScore alloc] initForSubmissionWithScore:1] autorelease];
		scor4 = 1;
	} else {
		scor4 = [currScore4 score] + 1;
	}
	[currScore4 setScore:scor4];
	[currScore4 setDisplayText:[NSString stringWithFormat:@"%d",scor4 ]];
	[currScore4 submitTo:leaderboard];
	
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/Publish.xml",NSHomeDirectory()]];
	NSString *SPublish = [params valueForKey:@"Publish"];
	if ([SPublish intValue] == 0 && connectToSocialNetwork) {
		// Нужна публикация на Стену
		[OFSocialNotificationApi setCustomUrl:@"http://itunes.apple.com/us/app/id363507222"];
		[OFSocialNotificationApi sendWithPrepopulatedText:[NSString stringWithFormat:@"I cracked \"The 15 puzzle\" game in %d minute %d seconds having made %d steps. Try to hit my score!",min,sec,point] originalMessage:@"" imageNamed:@"myLogo"];
	}
	NSMutableDictionary *params2 = [ [ NSMutableDictionary alloc ] init ];
	[params2 setValue:@"1" forKey:@"Publish"];
	[params2 writeToFile:[NSString stringWithFormat:@"%@/Documents/Publish.xml",NSHomeDirectory()] atomically:YES];
	
	
	
		//Util *util = [[Util alloc] init];
		//[util SendFinishGame:point min:min sec:sec kind:[BlocksKind intValue]];
	
	
	
}

- (void) didSubmit:(OFHighScore*)score {
}

- (void) didFailSubmit:(OFHighScore*)score {
}

- (void) stopGame {
	[self setGameIsPaused:false];
	[pauseButton setHidden:true];
	[playButton setHidden:true];
	[timeView stopTimer];
	if (bannerView_) [bannerView_ loadRequest:[GADRequest request]];
	
}

- (void) newGame {
	[self setGameIsPaused:false];
	[pauseButton setHidden:true];
	[playButton setHidden:true];
	[timeView resetTimer];
	if (bannerView_) [bannerView_ loadRequest:[GADRequest request]];
	
}

- (void) startGame {
	[self setGameIsPaused:false];
	[pauseButton setHidden:false];
	[playButton setHidden:true];
	[timeView startTimer];
	if (bannerView_) [bannerView_ loadRequest:[GADRequest request]];
}

- (void) pauseGame:(BOOL) pause {
	[self setGameIsPaused:pause];
	[pauseButton setHidden:pause];
	[playButton setHidden:!pause];
	[timeView pauseTimer:pause];
	if (bannerView_) [bannerView_ loadRequest:[GADRequest request]];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex {
	if (alertView == newGameAlert) {
		if (buttonIndex == 1) {
			[gameView newGame];
		}
	}
	[alertView release];
}

- (IBAction) onMenu:(id) sender {

	[gameView saveGame];
	[menuController checkContinueButton];
	[self release];
	[rootController popViewControllerAnimated:true];
}

- (IBAction) onPause:(id) sender {

	[self pauseGame:true];
	
}

- (IBAction) onPlay:(id) sender {

	[self pauseGame:false];
}

- (IBAction) onNewGame:(id) sender {
	if ([gameView gameIsStarted]) {
		newGameAlert = [[UIAlertView alloc] 
						initWithTitle:NSLocalizedString(@"NewGameTitle",@"") 
						message:NSLocalizedString(@"NewGameMessage",@"")  
						delegate:self 
						cancelButtonTitle:NSLocalizedString(@"Cansel",@"") 
						otherButtonTitles:NSLocalizedString(@"OK",@""),nil];
		[newGameAlert show];
		
	} else {
		[gameView newGame];
	}
	
	if (bannerView_) [bannerView_ loadRequest:[GADRequest request]];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#ifdef __IPHONE_4_1
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
	[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
		// assumes the banner view is at the top of the screen.
	banner.frame = CGRectOffset(banner.frame, 0, 50);
	[UIView commitAnimations];
	
	
	bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
											self.view.frame.size.height -
											GAD_SIZE_320x50.height,
											GAD_SIZE_320x50.width,
											GAD_SIZE_320x50.height)];
	
		// Specify the ad's "unit identifier." This is your AdMob Publisher ID.
	bannerView_.adUnitID = MY_BANNER_UNIT_ID;
	
		// Let the runtime know which UIViewController to restore after taking
		// the user wherever the ad goes and add it to the view hierarchy.
	bannerView_.rootViewController = self;
	[self.view addSubview:bannerView_];
	
		// Initiate a generic request to load it with an ad.
	[bannerView_ loadRequest:[GADRequest request]];
	
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
	
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
	
}
#endif

-(void) BannerLoad:(id)sender {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#ifdef __IPHONE_4_1
	bann = [[[ADBannerView alloc] init] autorelease];
	[bann setFrame:CGRectMake(0, 430, 320, 50)];
	[bann setDelegate:self];
	[self.view addSubview:bann];
#else
	bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
											self.view.frame.size.height -
											GAD_SIZE_320x50.height,
											GAD_SIZE_320x50.width,
											GAD_SIZE_320x50.height)];
	
		// Specify the ad's "unit identifier." This is your AdMob Publisher ID.
	bannerView_.adUnitID = MY_BANNER_UNIT_ID;
	
		// Let the runtime know which UIViewController to restore after taking
		// the user wherever the ad goes and add it to the view hierarchy.
	bannerView_.rootViewController = self;
	[self.view addSubview:bannerView_];
	
		// Initiate a generic request to load it with an ad.
	[bannerView_ loadRequest:[GADRequest request]];
#endif
	[pool release];
}





- (void) viewDidUnload {
    [super viewDidUnload];
	if (bannerView_)  [bannerView_ release];
	if (bann)  [bann release];

}

- (void) WillTerminate {
	[gameView saveGame];
	//[self dealloc];
}

- (void) dealloc {
	[timeView release];
	[gameView release];
	[counterView release];	
    [super dealloc];
}

@end