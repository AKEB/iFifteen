//
//  MainView.h
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainView : UIView {
	UIButton *Continue;
	UIButton *NewGame;
}
@property (nonatomic, retain) IBOutlet UIButton *Continue;
@property (nonatomic, retain) IBOutlet UIButton *NewGame;


-(void) checkContinue;

@end
