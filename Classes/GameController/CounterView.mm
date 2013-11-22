//
//  CounterView.m
//  iFifteen
//
//  Created by AKEB on 9/3/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "CounterView.h"
#import "GameViewController.h"

@implementation CounterView

@synthesize parentViewController;
@synthesize CV1, CV2, CV3, CV4;

- (id) initWithFrame:(CGRect)frame {
	
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
	
	
	for (int i=0; i<=9; i++) {
		images[i] = [UIImage imageNamed:[NSString stringWithFormat:@"c%d.png", i]];
	}
	
	images[10] = [UIImage imageNamed:@"count-blur.png"];
	
	OCnt1 = 0;
	OCnt2 = 0;
	OCnt3 = 0;
	OCnt4 = 0;
	
	[self drawCounter];
}

- (void) setCount:(int) cnt {
	count = cnt;
}

- (int) count {
	return count;
}

- (void) resetCount {
	count = 0;
	[self drawCounter];
}

- (void) addCount {
	count++;
	[self drawCounter];
}

- (void) drawCounter {
	Cnt1 = (int)(count / 1000);
	Cnt2 = (int)((count - (Cnt1 * 1000)) / 100);
	Cnt3 = (int)((count - (Cnt1 * 1000) - (Cnt2 * 100)) / 10);
	Cnt4 = (int)(count - (Cnt1 * 1000) - (Cnt2 * 100) - (Cnt3* 10));
	NSMutableArray *anim;
	
	if (OCnt1 != Cnt1) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OCnt1]];
		[anim addObject:images[10]];
		[anim addObject:images[Cnt1]];
		[CV1 setImage:images[Cnt1]];
		[CV1 setAnimationDuration:0.5];
		[CV1 setAnimationRepeatCount:1];
		[CV1 setAnimationImages:anim];
		[CV1 startAnimating];
	}
	if (OCnt2 != Cnt2) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OCnt2]];
		[anim addObject:images[10]];
		[anim addObject:images[Cnt2]];
		[CV2 setImage:images[Cnt2]];
		[CV2 setAnimationDuration:0.5];
		[CV2 setAnimationRepeatCount:1];
		[CV2 setAnimationImages:anim];
		[CV2 startAnimating];
	}
	if (OCnt3 != Cnt3) {
		NSMutableArray *anim;
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OCnt3]];
		[anim addObject:images[10]];
		[anim addObject:images[Cnt3]];
		[CV3 setImage:images[Cnt3]];
		[CV3 setAnimationDuration:0.5];
		[CV3 setAnimationRepeatCount:1];
		[CV3 setAnimationImages:anim];
		[CV3 startAnimating];
	}
	if (OCnt4 != Cnt4) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OCnt4]];
		[anim addObject:images[10]];
		[anim addObject:images[Cnt4]];
		[CV4 setImage:images[Cnt4]];
		[CV4 setAnimationDuration:0.5];
		[CV4 setAnimationRepeatCount:1];
		[CV4 setAnimationImages:anim];
		[CV4 startAnimating];
	}
	OCnt1 = Cnt1;
	OCnt2 = Cnt2;
	OCnt3 = Cnt3;
	OCnt4 = Cnt4;
	
	
}

- (void) dealloc {
    [super dealloc];
}

@end
