//
//  CounterView.h
//  iFifteen
//
//  Created by AKEB on 9/3/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameViewController;

@interface CounterView : UIView {
	GameViewController *parentViewController;
	
	int OCnt1, Cnt1;
	int OCnt2, Cnt2;
	int OCnt3, Cnt3;
	int OCnt4, Cnt4;
	
	UIImageView *CV1;
	UIImageView *CV2;
	UIImageView *CV3;
	UIImageView *CV4;
	
	UIImage *images[11];
	
	int count;
}

@property (nonatomic, retain) IBOutlet GameViewController *parentViewController;

@property (nonatomic, retain) IBOutlet UIImageView *CV1;
@property (nonatomic, retain) IBOutlet UIImageView *CV2;
@property (nonatomic, retain) IBOutlet UIImageView *CV3;
@property (nonatomic, retain) IBOutlet UIImageView *CV4;


- (void) setCount:(int) cnt;
- (int) count;
- (void) resetCount;
- (void) addCount;
- (void) drawCounter;
@end
