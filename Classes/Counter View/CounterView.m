//
//  CounterView.m
//  iFifteen
//
//  Created by AKEB on 3/19/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "CounterView.h"


@implementation CounterView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	draw = true;
	
	UIImage *backimage = [UIImage imageNamed: @"counter.png"];
	UIImageView *background = [[UIImageView alloc] initWithImage:backimage];
	[self addSubview:background];
	
	
	for (int i=0; i<=9; i++) {
		images[i] = [UIImage imageNamed:[NSString stringWithFormat:@"c%d.png", i]];
	}
	
	images[10] = [UIImage imageNamed:@"count-blur.png"];
	
	imageRect1 = CGRectMake(0.0, 0.0, 27.0, 39.0);
	imageRect2 = CGRectMake(27.0, 0.0, 27.0, 39.0);
	imageRect3 = CGRectMake(54.0, 0.0, 27.0, 39.0);
	imageRect4 = CGRectMake(81.0, 0.0, 27.0, 39.0);
	
	
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
		
	[self resetPoint];
}

-(void)resetPoint {
	Counter = 0;
	if (draw == false) return;
	[self drawCounter];
}

-(void)addPoint:(int)add {
	if (!add || add < 1) add = 1;
	Counter += add;
	[self drawCounter];
	
	
}

-(void)setPoints:(int)point {
	Counter = point;
	[self drawCounter];
}


-(int)getPoint {
	return Counter;
}


-(void)drawCounter {
	Count1 = (int)(Counter / 1000);
	Count2 = (int)((Counter - (Count1 * 1000)) / 100);
	Count3 = (int)((Counter - (Count1 * 1000) - (Count2 * 100)) / 10);
	Count4 = (int)(Counter - (Count1 * 1000) - (Count2 * 100) - (Count3* 10));
	NSMutableArray *anim;

	if (OldCount1 != Count1) {
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OldCount1]];
		[anim addObject:images[10]];
		[anim addObject:images[Count1]];
		imageView[0].image = images[Count1];
		imageView[0].animationDuration = 0.5;
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
		imageView[1].animationDuration = 0.5;
		imageView[1].animationRepeatCount = 1;
		imageView[1].animationImages = anim;
		[imageView[1] startAnimating];
	}
	if (OldCount3 != Count3) {
		NSMutableArray *anim;
		anim = [NSMutableArray arrayWithCapacity:3];
		[anim addObject:images[OldCount3]];
		[anim addObject:images[10]];
		[anim addObject:images[Count3]];
		imageView[2].image = images[Count3];
		imageView[2].animationDuration = 0.5;
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
		imageView[3].animationDuration = 0.5;
		imageView[3].animationRepeatCount = 1;
		imageView[3].animationImages = anim;
		[imageView[3] startAnimating];
	}
	OldCount1 = Count1;
	OldCount2 = Count2;
	OldCount3 = Count3;
	OldCount4 = Count4;
	

}



- (void)dealloc {
	for (int i=0; i<=3; i++) {
		[imageView[i] release];
	}
    [super dealloc];
}


@end
