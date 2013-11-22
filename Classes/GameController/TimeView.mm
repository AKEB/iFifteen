//
//  TimeView.m
//  iFifteen
//
//  Created by AKEB on 9/3/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "TimeView.h"
#import "GameViewController.h"

@implementation TimeView

@synthesize parentViewController;
@synthesize TV1, TV2, TV3, TV4;
@synthesize Min, Sec;


- (id) initWithFrame:(CGRect)frame {
		//NSLog(@"[TimeView initWithFrame]");
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
		//NSLog(@"[TimeView drawRect]");
	for (int i=0; i<=9; i++) {
		images[i] = [UIImage imageNamed:[NSString stringWithFormat:@"c%d.png", i]];
	}
	
	images[10] = [UIImage imageNamed:@"count-blur.png"];
	
	OCnt1 = 0;
	OCnt2 = 0;
	OCnt3 = 0;
	OCnt4 = 0;
	
	[self drawTimer];
}

- (BOOL) isStartTimer {
		//NSLog(@"[TimeView isStartTimer]");
	return StartTimer;
}

- (void) setStartTimer:(BOOL)start {
		//NSLog(@"[TimeView setStartTimer %@]",start ? @"true":@"false");
	StartTimer = start;
}

- (void) resetTimer {
		//NSLog(@"[TimeView resetTimer]");
	Min = 0;
	Sec = 0;
	[self stopTimer];
	
	[self drawTimer];
}

- (void) stopTimer {
		//NSLog(@"[TimeView stopTimer]");
	pause = false;
	[self setStartTimer:false];
	if (timer) {
		[timer invalidate];
		timer = nil;
	}
}

- (void) drawTimer {
		//NSLog(@"[TimeView drawTimer]");
	Cnt1 = (int)(Min / 10);
	Cnt2 = (int)(Min - (Cnt1 * 10));
	
	Cnt3 = (int)(Sec / 10);
	Cnt4 = (int)(Sec - (Cnt3 * 10));
	
	NSMutableArray *anim;
	if (OCnt1 != Cnt1) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OCnt1]];
		[anim addObject:images[10]];
		[anim addObject:images[Cnt1]];
		[TV1 setImage:images[Cnt1]];
		[TV1 setAnimationDuration:0.3];
		[TV1 setAnimationRepeatCount:1];
		[TV1 setAnimationImages:anim];
		[TV1 startAnimating];
	}
	if (OCnt2 != Cnt2) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OCnt2]];
		[anim addObject:images[10]];
		[anim addObject:images[Cnt2]];
		[TV2 setImage:images[Cnt2]];
		[TV2 setAnimationDuration:0.3];
		[TV2 setAnimationRepeatCount:1];
		[TV2 setAnimationImages:anim];
		[TV2 startAnimating];
	}
	if (OCnt3 != Cnt3) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OCnt3]];
		[anim addObject:images[10]];
		[anim addObject:images[Cnt3]];
		[TV3 setImage:images[Cnt3]];
		[TV3 setAnimationDuration:0.3];
		[TV3 setAnimationRepeatCount:1];
		[TV3 setAnimationImages:anim];
		[TV3 startAnimating];
	}
	if (OCnt4 != Cnt4) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OCnt4]];
		[anim addObject:images[10]];
		[anim addObject:images[Cnt4]];
		[TV4 setImage:images[Cnt4]];
		[TV4 setAnimationDuration:0.3];
		[TV4 setAnimationRepeatCount:1];
		[TV4 setAnimationImages:anim];
		[TV4 startAnimating];
	}
	OCnt1 = Cnt1;
	OCnt2 = Cnt2;
	OCnt3 = Cnt3;
	OCnt4 = Cnt4;
}

- (void) setTimerWithSec:(int) Minute sec:(int) Seconds {
		//NSLog(@"[TimeView setTimerWithSec]");
	[self setMin:Minute];
	[self setSec:Seconds];
}

- (void) startTimer {
		//NSLog(@"[TimeView startTimer]");
	pause = false;
	[self resetTimer];
	[self setStartTimer:true];
	timer = [NSTimer scheduledTimerWithTimeInterval:1.000 target:self selector:@selector(loopTimer:) userInfo:nil repeats:YES];
}

- (void) pauseTimer:(BOOL)pause_bool {
		//NSLog(@"[TimeView pauseTimer]");
	pause = pause_bool;
}

- (void) loopTimer:(id)sender {
	//NSLog(@"[TimeView loopTimer]");
	if (pause) return;
	if (Sec >= 59) {
		Sec = 0;
		Min++;
	} else {
		Sec++;
	}
	[self drawTimer];
}

- (void) dealloc {
		//NSLog(@"[TimeView dealloc]");
	[TV1 release];
	[TV2 release];
	[TV3 release];
	[TV4 release];
	if (timer) {
		[timer invalidate];
	}
    [super dealloc];
}


@end
