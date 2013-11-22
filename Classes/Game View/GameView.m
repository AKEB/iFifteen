//
//  GameView.m
//  iFifteen
//
//  Created by AKEB on 3/19/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "GameView.h"


@implementation GameView

@synthesize gameViewController;
@synthesize timerView;
@synthesize counterView;

- (id)initWithFrame:(CGRect)frame viewController:(GameViewController *)aController {
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self setGameViewController:aController];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
	CGRect  gameScreen = CGRectMake(194.0, 10.0, 108.0, 39.0);
	counterView = [[CounterView alloc] initWithFrame:gameScreen];
	
	CGRect  timerScreen = CGRectMake(11.0, 10.0, 119.0, 39.0);
	timerView = [[TimerView alloc] initWithFrame:timerScreen];
	
	UIImage *backimage = [UIImage imageNamed: @"bg.png"];
	UIImageView *background = [[UIImageView alloc] initWithImage:backimage];
	[self addSubview:background];
	
	
	CGRect  gameScreen2 = CGRectMake(8.0, 62.0, 304.0, 304.0);
	
	blockView = [[BlockView alloc] initWithFrame:gameScreen2];
	[blockView setParentView:self];
	[self addSubview:blockView];
	
	
	
	UIImage *backimage2 = [UIImage imageNamed: @"blockbg.png"];
	UIImageView *background2 = [[UIImageView alloc] initWithImage:backimage2];
	[blockView addSubview:background2];
	
	UIButton *newGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	newGameButtonFrame = CGRectMake(7.0, 377.0, 147.0, 39.0);
	newGameButton.frame = newGameButtonFrame;
	[newGameButton setBackgroundImage:[UIImage imageNamed:@"new-1.png"] forState:UIControlStateNormal];
	[newGameButton setBackgroundImage:[UIImage imageNamed:@"new-2.png"] forState:UIControlStateHighlighted];
	[newGameButton addTarget:blockView action:@selector(newGameButton:) forControlEvents:UIControlEventTouchUpInside];
	
	pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	pauseButtonFrame = CGRectMake(-33.0, -33.0, 33.0, 33.0);
	pauseButton.frame = pauseButtonFrame;
	[pauseButton setBackgroundImage:[UIImage imageNamed:@"pause_off.png"] forState:UIControlStateNormal];
	[pauseButton setBackgroundImage:[UIImage imageNamed:@"pause_on.png"] forState:UIControlStateHighlighted];
	[pauseButton addTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
	pausedGame = true;

	playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	playButtonFrame = CGRectMake(-33.0, -33.0, 33.0, 33.0);
	playButton.frame = playButtonFrame;
	[playButton setBackgroundImage:[UIImage imageNamed:@"play_off.png"] forState:UIControlStateNormal];
	[playButton setBackgroundImage:[UIImage imageNamed:@"play_on.png"] forState:UIControlStateHighlighted];
	[playButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];
	
	
	
	UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	menuButtonFrame = CGRectMake(165.0, 377.0, 147.0, 39.0);
	menuButton.frame = menuButtonFrame;
	[menuButton setBackgroundImage:[UIImage imageNamed:@"menu-1.png"] forState:UIControlStateNormal];
	[menuButton setBackgroundImage:[UIImage imageNamed:@"menu-2.png"] forState:UIControlStateHighlighted];
	[menuButton addTarget:[self gameViewController] action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
	
	[self addSubview:newGameButton];
	[self addSubview:menuButton];
	[self addSubview:pauseButton];
	[self addSubview:playButton];
	
	[self addSubview:counterView];
	[self addSubview:timerView];
	
}

-(void)pauseGame {
	pausedGame = true;
	pauseButtonFrame = CGRectMake(-33.0, -33.0, 33.0, 33.0);
	pauseButton.frame = pauseButtonFrame;
	playButtonFrame = CGRectMake(145.0, 13.0, 33.0, 33.0);
	playButton.frame = playButtonFrame;
	[self stopTimer];
	[blockView pauseGame];

}

-(void)startGame {
	pausedGame = false;
	playButtonFrame = CGRectMake(-33.0, -33.0, 33.0, 33.0);
	playButton.frame = playButtonFrame;
	pauseButtonFrame = CGRectMake(145.0, 13.0, 33.0, 33.0);
	pauseButton.frame = pauseButtonFrame;
	[self startTimer];
	[blockView startGame];
}


-(void)stopGame {
	pauseButtonFrame = CGRectMake(-33.0, -33.0, 33.0, 33.0);
	pauseButton.frame = pauseButtonFrame;
	playButtonFrame = CGRectMake(-33.0, -33.0, 33.0, 33.0);
	playButton.frame = playButtonFrame;
	[self setBeginGame:false];
	pausedGame = true;
	[self stopTimer];
	[blockView pauseGame];
}

-(void)resetPoint {
	[counterView resetPoint];
}

-(void)addPoint:(int)add {
	[counterView addPoint:add];
}

-(int)getPoint {
	return [counterView getPoint];
}


-(void)resetTimer {
	[timerView resetTimer];
}

-(void)startTimer {
	[timerView startTimer];
}

-(void)stopTimer {
	[timerView stopTimer];
}

- (int) minTimer {
	return [timerView minTimer];
}

- (int) secTimer {
	return [timerView secTimer];
}


-(BOOL) beginGame {
	return beginGame;
}

-(void) setBeginGame:(BOOL)begin {
	beginGame = begin;
}

- (void)viewDidUnload {
	NSLog(@"GameView viewDidUnload");
	[blockView viewDidUnload];
}


- (void)dealloc {
	NSLog(@"GameView dealloc");
	[counterView release];
    [super dealloc];
}

@end
