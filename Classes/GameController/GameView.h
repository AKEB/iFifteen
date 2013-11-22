//
//  GameView.h
//  iFifteen
//
//  Created by AKEB on 9/3/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct {
	UIImageView *img;
	int num;
} Buttons;

@class GameViewController;

@interface GameView : UIView {
	GameViewController *parentViewController;
	
	NSString *FileName;
	
	UIImage *images[BLOCKS_COUNT+1];
	Buttons buttons[BLOCKS_COUNT+1];
	CGPoint buttonsPoint[BLOCKS_COUNT+1];
	
	AVAudioPlayer *player;
	
	NSDictionary *settings;
	NSString *SoundOn;
	NSString *SoundVolume;
	NSString *BlocksKind;
	
	BOOL gameIsStarted;
	BOOL isNewGame;
	BOOL gameIsFinished;
	
	UIAlertView *FinishGameAlert;
	
	BOOL buttonMove;
	int prev;
	CGPoint Click;
	int ClickNum;
	int ClickMoveType;
}

@property (nonatomic, retain) IBOutlet GameViewController *parentViewController;
@property (nonatomic) BOOL gameIsStarted;
@property (nonatomic) BOOL gameIsFinished;



- (void) initGame;
- (void) newGame;
- (void) continueGame;
- (void) saveGame;
- (int) random_step:(int) current;
- (int) getRandomNumber:(int) from to:(int) to;
- (void) changePos:(int) i to:(int) j;
- (void) checkFinishGame;

@end
