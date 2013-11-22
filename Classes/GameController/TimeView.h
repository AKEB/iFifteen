//
//  TimeView.h
//  iFifteen
//
//  Created by AKEB on 9/3/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameViewController;

@interface TimeView : UIView {
	GameViewController *parentViewController;
	
	UIImageView *TV1;
	UIImageView *TV2;
	UIImageView *TV3;
	UIImageView *TV4;
	
	int Min, Sec;
	int OCnt1, Cnt1;
	int OCnt2, Cnt2;
	int OCnt3, Cnt3;
	int OCnt4, Cnt4;
	
	UIImage *images[11];
	NSTimer *timer;
	BOOL pause;
	BOOL StartTimer;
}

@property (nonatomic, retain) IBOutlet GameViewController *parentViewController;

@property (nonatomic, retain) IBOutlet UIImageView *TV1;
@property (nonatomic, retain) IBOutlet UIImageView *TV2;
@property (nonatomic, retain) IBOutlet UIImageView *TV3;
@property (nonatomic, retain) IBOutlet UIImageView *TV4;
@property (nonatomic) int Min;
@property (nonatomic) int Sec;

- (BOOL) isStartTimer;
- (void) setStartTimer:(BOOL)start;
- (void) resetTimer;
- (void) stopTimer;
- (void) startTimer;
- (void) pauseTimer:(BOOL) pause;
- (void) loopTimer:(id)sender;
- (void) setTimerWithSec:(int) Minute sec:(int) Seconds;
- (void) drawTimer;
@end
