//
//  MainMenuViewController.h
//  MyOpenFeintSample
//
//  Created by AKEB on 9/2/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OFCallbackable.h"

#ifdef __IPHONE_4_1
#import <iAd/iAd.h>
#endif
#import "GADBannerView.h"


@class iFifteenAppDelegate;
@class GameViewController;

@interface MainMenuViewController : UIViewController<OFCallbackable,ADBannerViewDelegate> {
	iFifteenAppDelegate *delegate;
	UIButton *newGame;
	UIButton *continueGame;
	NSString *FileSaveName;
	GameViewController *gameController;
	BOOL bannerIsVisible;
	#ifdef __IPHONE_4_1
		ADBannerView *bann;
	#endif
	GADBannerView *bannerView_;

}

@property (nonatomic, retain) IBOutlet iFifteenAppDelegate *delegate;
@property (nonatomic, retain) IBOutlet UIButton *newGame;
@property (nonatomic, retain) IBOutlet UIButton *continueGame;


- (IBAction) OpenFeilds;
- (IBAction) onHowToPlay;
- (IBAction) onSettings;
- (IBAction) onNewGame;
- (IBAction) onContinueGame;
- (void) sendAddUser:(id) sender;
- (void) checkContinueButton;

@end
