#import "BlockView.h"
#import "CounterView.h"
#import "FBConnect.h"
#import "UserInfo.h"
#import "FBLoginButton.h"
#import "Session.h"

@protocol GameViewControllerDelegate;

@class GameView;
@class MainViewController;


@interface GameViewController : UIViewController {
	id <GameViewControllerDelegate> delegate;
	BlockView *blockView;
	GameView *gameview;
	id root;
	UIAlertView *menuAlert;
}

@property (nonatomic, assign) id <GameViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet BlockView *blockView;
@property (nonatomic, retain) IBOutlet GameView *gameview;
@property (nonatomic, retain) id root;

- (void)menu:(id)sender;

@end


@protocol GameViewControllerDelegate
- (void)gameViewControllerDidFinish:(GameViewController *)controller;
- (void)Publish:(NSString *)min seconds:(NSString *)sec Points:(NSString *)point Kind:(NSString *)kind;
@end

