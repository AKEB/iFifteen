#import <UIKit/UIKit.h>
#import "CounterView.h"
#import "RatingModel.h"

typedef struct {
	UIImageView *img;
	int num;
} Buttons;

#define DEBUG  0

#define DIFFICULTY   300
#define DEBUG_DIFFICULTY   1


#define BLOCK_WIDTH  76
#define BLOCK_HEIGHT 76
#define BLOCKS_COUNT 16
#define BLOCK_DIV    5

@class GameView;

@interface BlockView : UIView {
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	NSMutableArray *RatingData;
	
	UIImage *images[16];
	Buttons buttons[16];
	CGPoint buttonsPoint[16];
	UIView *BlockView2;
	UIAlertView *newGameAlert;
	UIAlertView *menuAlert;
	UIAlertView *FinishGameAlert;
	UIAlertView *ContinueGameAlert;
	
	UITextField *PlayerName;
	int FinishMin;
	int FinishSec;
	int FinishPoint;
	
	GameView *parentView;
	
	CGPoint Click;
	int ClickNum;
	int ClickMoveType;
	BOOL StartGame;
	BOOL FinishGame;
	BOOL StartTimer;
	BOOL LoadGame;
	BOOL Publish;
	NSTimer *time;
	
	AVAudioPlayer *player;
	NSDictionary *settings;
	NSString *SoundOn;
	NSString *SoundVolume;
	NSString *BlocksKind;

}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) NSMutableArray *RatingData;
@property (nonatomic, retain) GameView *parentView;


-(void) newGameButton:(id)sender;
-(void) newGame;
-(void) initGame;
-(void) continueGame;

-(void) loopGame:(NSTimer *)t;
-(int) getRandomNumber:(int)from to:(int)to;
-(void) changePos:(int) i to:(int)j;
-(int) random:(int)current;
-(void) checkFinishGame;
-(void) pauseGame;
-(void) startGame;

- (void)viewDidUnload;

-(NSString *) decline:(int)point string1:(NSString *)s1 string234:(NSString *)s234 stringMany:(NSString *)sMany;

@end
