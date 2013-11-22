//
//  CounterView.h
//  iFifteen
//
//  Created by AKEB on 3/19/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterView : UIView {
	int Counter;
	int OldCount1, Count1;
	int OldCount2, Count2;
	int OldCount3, Count3;
	int OldCount4, Count4;
	UIImageView *imageView[4];
	CGRect imageRect1,imageRect2,imageRect3,imageRect4;
	UIImage *images[11];
	BOOL draw;
}

-(void)setPoint:(int)point;


-(void)addPoints:(int)add;
-(void)resetPoint;
-(int)getPoint;
-(void)drawCounter;

@end

