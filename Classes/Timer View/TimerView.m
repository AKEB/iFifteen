//
//  CounterView.m
//  iFifteen
//
//  Created by AKEB on 3/19/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "TimerView.h"


@implementation TimerView


-(id) initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}


-(void) drawRect:(CGRect)rect {
	draw = TRUE;
	UIImage *backimage = [UIImage imageNamed: @"timerBG.png"];
	UIImageView *background = [[UIImageView alloc] initWithImage:backimage];
	[self addSubview:background];
	
	
	for (int i=0; i<=9; i++) {
		images[i] = [UIImage imageNamed:[NSString stringWithFormat:@"c%d.png", i]];
	}
	
	images[10] = [UIImage imageNamed:@"count-blur.png"];
	
	imageRect1 = CGRectMake(0.0, 0.0, 27.0, 39.0);
	imageRect2 = CGRectMake(27.0, 0.0, 27.0, 39.0);
	imageRect3 = CGRectMake(65.0, 0.0, 27.0, 39.0);
	imageRect4 = CGRectMake(92.0, 0.0, 27.0, 39.0);
	
	imageView[0] = [[UIImageView alloc] initWithImage:images[0]];
	imageView[0].frame = imageRect1;
	imageView[1] = [[UIImageView alloc] initWithImage:images[0]];
	imageView[1].frame = imageRect2;
	imageView[2] = [[UIImageView alloc] initWithImage:images[0]];
	imageView[2].frame = imageRect3;
	imageView[3] = [[UIImageView alloc] initWithImage:images[0]];
	imageView[3].frame = imageRect4;
	
	[self addSubview:imageView[0]];
	[self addSubview:imageView[1]];
	[self addSubview:imageView[2]];
	[self addSubview:imageView[3]];
	
	OldCount1 = 0;
	OldCount2 = 0;
	OldCount3 = 0;
	OldCount4 = 0;
	
	[self resetTimer];
}

-(void) resetTimer {
	Min = 0;
	Sec = 0;
	[self stopTimer];
	if (draw == FALSE) return;
	[self drawTimer];
}

-(void) startTimer {
	[self loopTimer];
	timer = [NSTimer scheduledTimerWithTimeInterval:1.000 target:self selector:@selector(loopTimer) userInfo:nil repeats:YES];
	
}

-(void) stopTimer {
	[timer invalidate];
	timer = nil;
}

-(int) minTimer {
	return Min;
}

-(int) secTimer {
	return Sec;
}

-(void) setTimer:(int)min Sec:(int)sec {
	Min = min;
	Sec = sec;
	[self drawTimer];
}

-(void) setMin:(int)min {
	Min = min;
	[self drawTimer];
}

-(int) setSec:(int)sec {
	Sec = sec;
	[self drawTimer];
}


-(void) loopTimer {
	if (Sec >= 59) {
		Sec = 0;
		Min++;
	} else {
		Sec++;
	}
	[self drawTimer];
}

-(void) drawTimer {
	Count1 = (int)(Min / 10);
	Count2 = (int)(Min - (Count1 * 10));
	
	Count3 = (int)(Sec / 10);
	Count4 = (int)(Sec - (Count3 * 10));
	
	NSMutableArray *anim;
	
	if (OldCount1 != Count1) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OldCount1]];
		[anim addObject:images[10]];
		[anim addObject:images[Count1]];
		imageView[0].image = images[Count1];
		imageView[0].animationDuration = 0.3;
		imageView[0].animationRepeatCount = 1;
		imageView[0].animationImages = anim;
		[imageView[0] startAnimating];
	}
	if (OldCount2 != Count2) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OldCount2]];
		[anim addObject:images[10]];
		[anim addObject:images[Count2]];
		imageView[1].image = images[Count2];
		imageView[1].animationDuration = 0.3;
		imageView[1].animationRepeatCount = 1;
		imageView[1].animationImages = anim;
		[imageView[1] startAnimating];
	}
	if (OldCount3 != Count3) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OldCount3]];
		[anim addObject:images[10]];
		[anim addObject:images[Count3]];
		imageView[2].image = images[Count3];
		imageView[2].animationDuration = 0.3;
		imageView[2].animationRepeatCount = 1;
		imageView[2].animationImages = anim;
		[imageView[2] startAnimating];
	}
	if (OldCount4 != Count4) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OldCount4]];
		[anim addObject:images[10]];
		[anim addObject:images[Count4]];
		imageView[3].image = images[Count4];
		imageView[3].animationDuration = 0.3;
		imageView[3].animationRepeatCount = 1;
		imageView[3].animationImages = anim;
		[imageView[3] startAnimating];
	}
	OldCount1 = Count1;
	OldCount2 = Count2;
	OldCount3 = Count3;
	OldCount4 = Count4;
}

-(void) dealloc {
	for (int i=0; i<=3; i++) {
		[imageView[i] release];
	}
	[super dealloc];
}

@end
