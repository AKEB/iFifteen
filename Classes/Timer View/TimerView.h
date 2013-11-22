//
//  CounterView.h
//  iFifteen
//
//  Created by AKEB on 3/19/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerView : UIView {
	int Min, Sec;
	int OldCount1, Count1;
	int OldCount2, Count2;
	int OldCount3, Count3;
	int OldCount4, Count4;
	UIImageView *imageView[4];
	CGRect imageRect1,imageRect2,imageRect3,imageRect4;
	UIImage *images[11];
	BOOL draw;
	NSTimer *timer;
}

-(void)drawTimer;
-(void)resetTimer;
-(void)startTimer;
-(void)stopTimer;
-(int)minTimer;
-(int)secTimer;
-(void)loopTimer;

-(void) setMin:(int)min;
-(int) setSec:(int)sec;

-(void) setTimer:(int)min Sec:(int)sec;

@end

