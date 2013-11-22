//
//  GameView.h
//  iFifteen
//
//  Created by AKEB on 3/19/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "CounterView.h";
#import "TimerView.h";

#import "BlockView.h";
@class GameViewController;

@interface GameView : UIView {
	GameViewController *gameViewController;
	CounterView *counterView;
	TimerView *timerView;
	BlockView *blockView;
	CGRect newGameButtonFrame;
	CGRect menuButtonFrame;
	CGRect pauseButtonFrame;
	CGRect playButtonFrame;
	BOOL pausedGame;
	BOOL beginGame;
	UIButton *pauseButton;
	UIButton *playButton;
	
	
}

@property (nonatomic, assign) GameViewController *gameViewController;
@property (nonatomic, assign) TimerView *timerView;
@property (nonatomic, assign) CounterView *counterView;


-(void)addPoint:(int)add;
-(void)resetPoint;
-(int)getPoint;

-(void)stopGame;
-(void)pauseGame;
-(void)startGame;

-(void)resetTimer;
-(void)startTimer;
-(void)stopTimer;

-(int)minTimer;
-(int)secTimer;

-(BOOL) beginGame;
-(void) setBeginGame:(BOOL)begin;

- (void)viewDidUnload;

@end
