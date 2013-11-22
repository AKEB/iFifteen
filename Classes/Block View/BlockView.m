#import "BlockView.h"
#import "RatingModel.h"
#import "FBConnect.h"
#import "Session.h"

static NSString* kAppId = @"112752198778262";

@implementation BlockView

@synthesize RatingData;
@synthesize parentView;


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        // Initialization code
		Publish = false;
		time = [NSTimer scheduledTimerWithTimeInterval:0.500 target:self selector:@selector(loopGame:) userInfo:nil repeats:YES];
	}
	
    return self;
}

- (void)drawRect:(CGRect)rect {
	
	NSUserDefaults *set = [[NSUserDefaults alloc] init];
	settings = [set dictionaryRepresentation];
	SoundVolume = [settings valueForKey:@"soundVolume"];
	SoundOn = [settings valueForKey:@"soundOn"];
	BlocksKind = [settings valueForKey:@"BlockKind"];
	//Регистрируем и сохраняем файл на диск
	[set synchronize];
	
	for (int i=1; i<=16; i++) {
		images[i] = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png",([BlocksKind intValue] == 1 ? @"b":@"n"), i]];
	}
	
	NSError *err;
	player = [[AVAudioPlayer alloc] initWithContentsOfURL: [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"sound14" ofType:@"mp3" inDirectory:@"/"]] error: &err];
	[player prepareToPlay];
	
	PlayerName = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, 220, 25)];
	[PlayerName setBackgroundColor:[UIColor whiteColor]];
	
	
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/Save.xml",NSHomeDirectory()]];
	NSString *SSTATUS = [params valueForKey:@"STATUS"];
	if ([SSTATUS intValue] == 1) {
		[self continueGame];
	} else {
		[self initGame];
		[self newGame];
	}
	
}

-(void) continueGame {
	NSLog(@"BlockView continueGame");
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/Save.xml",NSHomeDirectory()]];
	
	[parentView resetPoint];
	[parentView resetTimer];
	LoadGame = true;
	StartGame = TRUE;
	FinishGame = FALSE;
	StartTimer = TRUE;
	FinishSec = 0;
	FinishMin = 0;
	FinishPoint = 0;
	[parentView setBeginGame:true];
	[parentView startGame];
	
	NSString *SMin = [params valueForKey:@"Min"];
	NSString *SSec = [params valueForKey:@"Sec"];
	NSString *SPoint = [params valueForKey:@"Point"];
	
	[[parentView timerView] setTimer:[SMin intValue] Sec:[SSec intValue]];
	[[parentView counterView] setPoints:[SPoint intValue]];
	
	int kx=0;
	int ky=-1;
	CGRect TempRect;
	
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		NSString *SNum = [params valueForKey:[NSString stringWithFormat:@"img%d num",i]];
		
		if ((kx % 4) == 0) {
			ky++;
			kx = 0;
		}
		buttons[i].img = [[UIImageView alloc] initWithImage:images[[SNum intValue]]];
		buttons[i].num = [SNum intValue];
		TempRect = buttons[i].img.frame;
		TempRect.origin.x = kx*BLOCK_WIDTH;
		TempRect.origin.y = ky*BLOCK_HEIGHT;
		buttonsPoint[i].x = TempRect.origin.x;
		buttonsPoint[i].y = TempRect.origin.y;
		TempRect.size.width = BLOCK_WIDTH;
		TempRect.size.height = BLOCK_HEIGHT;
		buttons[i].img.frame = TempRect;
		[self addSubview:buttons[i].img];
		kx++;
	}
	
	[parentView pauseGame];
}

- (void)initGame {
	NSLog(@"BlockView initGame");
	int kx=0;
	int ky=-1;
	CGRect TempRect;
	
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		if ((kx % 4) == 0) {
			ky++;
			kx = 0;
		}
		buttons[i].img = [[UIImageView alloc] initWithImage:images[i]];
		buttons[i].num = i;
		TempRect = buttons[i].img.frame;
		TempRect.origin.x = kx*BLOCK_WIDTH;
		TempRect.origin.y = ky*BLOCK_HEIGHT;
		buttonsPoint[i].x = TempRect.origin.x;
		buttonsPoint[i].y = TempRect.origin.y;
		TempRect.size.width = BLOCK_WIDTH;
		TempRect.size.height = BLOCK_HEIGHT;
		buttons[i].img.frame = TempRect;
		[self addSubview:buttons[i].img];
		kx++;
	}
}

-(void)newGame {
	NSLog(@"BlockView newGame");
	
	NSMutableDictionary *params = [ [ NSMutableDictionary alloc ] init ];
	[params setValue:@"0" forKey:@"STATUS"];
	[params writeToFile:[NSString stringWithFormat:@"%@/Documents/Save.xml",NSHomeDirectory()] atomically:YES];
	
	LoadGame = false;
	StartGame = false;
	FinishGame = false;
	StartTimer = false;
	FinishSec = 0;
	FinishMin = 0;
	FinishPoint = 0;
	
	[parentView resetPoint];
	[parentView resetTimer];
	[parentView stopGame];
	
	int first = 0;
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		if (buttons[i].num == BLOCKS_COUNT) {
			first = i;
			break;
		}
	}
	int next = 0;
	int Difficulty = DIFFICULTY;
	
	if (DEBUG == 1) {
		Difficulty = DEBUG_DIFFICULTY;
	}
	
	for (int i=1; i<=Difficulty; i++) {
		next = [self random:first];
		if (next > BLOCKS_COUNT || next < 1) {
			continue;
		}
		if (first == 5 && next == 4) continue;
		if (first == 9 && next == 8) continue;
		if (first == 13 && next == 12) continue;
		if (first == 4 && next == 5) continue;
		if (first == 8 && next == 9) continue;
		if (first == 12 && next == 13) continue;
		
		[self changePos:first to:next];
		first = next;
	}
	
}

- (void)newGameButton:(id)sender {
	if (StartGame) {
		newGameAlert = [[UIAlertView alloc] 
				  initWithTitle:NSLocalizedString(@"NewGameTitle",@"") 
				  message:NSLocalizedString(@"NewGameMessage",@"")  
				  delegate:self 
				  cancelButtonTitle:NSLocalizedString(@"Cansel",@"") 
				  otherButtonTitles:NSLocalizedString(@"OK",@""),nil];
		[newGameAlert show];
	} else {
		[self newGame];
	}

}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex {
	if (alertView == FinishGameAlert) {
		// Что-то при финише игры!!! Полюбому нужно!!!!!!!
		if (buttonIndex == 1) {
			managedObjectContext = [self managedObjectContext];
			if (!managedObjectContext) {
				// Handle the error.
				NSLog(@"Unresolved error (no context)");
				exit(-1);  // Fail
			}
		
			NSFetchRequest *request = [[NSFetchRequest alloc] init];
			NSEntityDescription *entity = [NSEntityDescription entityForName:@"RatingModel" inManagedObjectContext:managedObjectContext];
			[request setEntity:entity];
		
			NSError *error1 = nil;
			NSMutableArray *mutableFetchResults1 = [[managedObjectContext executeFetchRequest:request error:&error1] mutableCopy];
			if (mutableFetchResults1 == nil) {
				NSLog(@"Unresolved error %@, %@", error1, [error1 userInfo]);
				exit(-1);
			}
			[self setRatingData:mutableFetchResults1];
			[mutableFetchResults1 release];
		
		
		
			RatingModel *Rating = (RatingModel *)[NSEntityDescription insertNewObjectForEntityForName:@"RatingModel" inManagedObjectContext:managedObjectContext];
			
			static NSNumberFormatter *numberFormatter = nil;
			if (numberFormatter == nil) {
				numberFormatter = [[NSNumberFormatter alloc] init];
				[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
			}
			
			NSMutableDictionary *params = [ [ NSMutableDictionary alloc ] init ];
			[params setValue:[NSString stringWithFormat:@"%@",[PlayerName text]] forKey:@"PlayerName"];
			[params writeToFile:[NSString stringWithFormat:@"%@/Documents/PlayerName.xml",NSHomeDirectory()] atomically:YES];
			
			
			Rating.name = PlayerName.text;
			[Rating setPoint:[numberFormatter numberFromString:[NSString stringWithFormat:@"%d",FinishPoint]]];
			[Rating setType:[numberFormatter numberFromString:[NSString stringWithFormat:@"%d",([BlocksKind intValue]+1)]]];
			[Rating setTimeMin:[numberFormatter numberFromString:[NSString stringWithFormat:@"%d",FinishMin]]];
			[Rating setTimeSec:[numberFormatter numberFromString:[NSString stringWithFormat:@"%d",FinishSec]]];
			[RatingData insertObject:Rating atIndex:0];
			
			NSError *error3 = nil;
			if (![[self managedObjectContext] save:&error3]) {
				// Handle the error.
				NSLog(@"Unresolved error %@, %@", error3, [error3 userInfo]);
				exit(-1);  // Fail
			}
			NSLog(@"PUBLISH");
			
			Publish = true;
			NSLog(@"PUBLISH END");
		}
		
	} else if (alertView == newGameAlert) {
		// Шаманство не понятно почему НО координата Y у 16 клетки обнуляется
		buttonsPoint[16].y = buttonsPoint[15].y;

		if (buttonIndex == 1) {
			[self newGame];
		}
	} else if (alertView == ContinueGameAlert) {
		
		if (buttonIndex == 0) {
			[self initGame];
			[self newGame];
		} else {
			[self continueGame];
		}
	}
	[alertView release];
}

-(void) loopGame:(NSTimer *)t {
	if (Publish == false) return;
	NSLog(@"LOOP GAME");
	[[[parentView gameViewController] delegate] Publish:[NSString stringWithFormat:@"%d",FinishMin] 
												seconds:[NSString stringWithFormat:@"%d",FinishSec] 
												Points:[NSString stringWithFormat:@"%d",FinishPoint] 
												Kind:[NSString stringWithFormat:@"%d",[BlocksKind intValue]+1]];
	
	Publish = false;
	
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (FinishGame == TRUE) return;
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	CGRect rect = CGRectMake(0.0, 0.0, 304.0, 304.0);
	Click.x = -1;
	Click.y = -1;
	if (FinishGame == false && CGRectContainsPoint(rect, location)) {
		Click.x = (int)location.x;
		Click.y = (int)location.y;
		ClickNum = (int)(Click.y / BLOCK_HEIGHT) * 4 + (int)(Click.x / BLOCK_WIDTH) + 1;
		if (ClickNum < 1 || ClickNum > BLOCKS_COUNT) return;
		if (ClickNum-1 >= 1 && ClickNum-1 <= BLOCKS_COUNT && buttons[ClickNum-1].num == BLOCKS_COUNT) {
			ClickMoveType = 1;
		} else if (ClickNum-4 >= 1 && ClickNum-4 <= BLOCKS_COUNT && buttons[ClickNum-4].num == BLOCKS_COUNT) {
			ClickMoveType = 2;
		} else if (ClickNum+1 >= 1 && ClickNum+1 <= BLOCKS_COUNT && buttons[ClickNum+1].num == BLOCKS_COUNT) {
			ClickMoveType = 3;
		} else if (ClickNum+4 >= 1 && ClickNum+4 <= BLOCKS_COUNT && buttons[ClickNum+4].num == BLOCKS_COUNT) {
			ClickMoveType = 4;
		} else {
			ClickMoveType = 0;
		}
	}
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (FinishGame == TRUE) return;
	if (ClickMoveType < 1 || ClickMoveType > 4) return;
	if (ClickNum < 1 || ClickNum > BLOCKS_COUNT) return;
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	int xy;
	CGRect TempRect;
	if (ClickMoveType == 1) {
		if (location.x >= buttonsPoint[ClickNum - 1].x && location.x <= buttonsPoint[ClickNum].x + BLOCK_WIDTH) {
			xy = buttonsPoint[ClickNum].x + (location.x - Click.x);
			if (xy <= buttonsPoint[ClickNum - 1].x) xy = buttonsPoint[ClickNum - 1].x;
			else if (xy >= buttonsPoint[ClickNum].x) xy = buttonsPoint[ClickNum].x;	
			TempRect.origin.x = xy;
			TempRect.origin.y = buttonsPoint[ClickNum].y;
			TempRect.size.width = BLOCK_WIDTH;
			TempRect.size.height = BLOCK_HEIGHT;
			buttons[ClickNum].img.frame = TempRect;
		}
	} else if (ClickMoveType == 2) {
		if (location.y >= buttonsPoint[ClickNum - 4].y && location.y <= buttonsPoint[ClickNum].y + BLOCK_HEIGHT) {
			xy = buttonsPoint[ClickNum].y + (location.y - Click.y);
			if (xy <= buttonsPoint[ClickNum - 4].y) xy = buttonsPoint[ClickNum - 4].y;
			else if (xy >= buttonsPoint[ClickNum].y) xy = buttonsPoint[ClickNum].y;
			TempRect.origin.x = buttonsPoint[ClickNum].x;
			TempRect.origin.y = xy;
			TempRect.size.width = BLOCK_WIDTH;
			TempRect.size.height = BLOCK_HEIGHT;
			buttons[ClickNum].img.frame = TempRect;
		}
	} else if (ClickMoveType == 3) {
		if (location.x <= buttonsPoint[ClickNum + 1].x + BLOCK_WIDTH && location.x >= buttonsPoint[ClickNum].x) {
			xy = buttonsPoint[ClickNum].x + (location.x - Click.x);
			if (xy >= buttonsPoint[ClickNum + 1].x) xy = buttonsPoint[ClickNum + 1].x;
			else if (xy <= buttonsPoint[ClickNum].x) xy = buttonsPoint[ClickNum].x;	
			TempRect.origin.x = xy;
			TempRect.origin.y = buttonsPoint[ClickNum].y;
			TempRect.size.width = BLOCK_WIDTH;
			TempRect.size.height = BLOCK_HEIGHT;
			buttons[ClickNum].img.frame = TempRect;
		}
	} else if (ClickMoveType == 4) {
		if (location.y <= buttonsPoint[ClickNum + 4].y + BLOCK_HEIGHT && location.y >= buttonsPoint[ClickNum].y) {
			xy = buttonsPoint[ClickNum].y + (location.y - Click.y);
			if (xy >= buttonsPoint[ClickNum + 4].y) xy = buttonsPoint[ClickNum + 4].y;
			else if (xy <= buttonsPoint[ClickNum].y) xy = buttonsPoint[ClickNum].y;
			TempRect.origin.x = buttonsPoint[ClickNum].x;
			TempRect.origin.y = xy;
			TempRect.size.width = BLOCK_WIDTH;
			TempRect.size.height = BLOCK_HEIGHT;
			buttons[ClickNum].img.frame = TempRect;
		}
	}
}

-(void)pauseGame {
	StartTimer = false;
}

-(void)startGame {
	StartTimer = true;
}

-(NSString *)decline:(int)point string1:(NSString *)s1 string234:(NSString *)s234 stringMany:(NSString *)sMany {
	NSString *s;
	int d;
	s = sMany;
	d = point % 100;
	if ((d < 10) || (d > 20)) {
		int l = point % 10;
		if (l == 1) s = s1;
		if ((l >= 2) && (l <= 4)) s = s234;
	}
	return s;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (FinishGame == TRUE) return;
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	int ClickNumEnd;
	if (FinishGame == true) return;
	
	if (ClickMoveType == 1) {
		if (Click.x - location.x >= BLOCK_WIDTH / BLOCK_DIV || location.x < buttonsPoint[ClickNum - 1].x) {
			location.x = buttonsPoint[ClickNum - 1].x;
		}
		ClickNumEnd = (int)(buttonsPoint[ClickNum].y / BLOCK_HEIGHT) * 4 + (int)(location.x / BLOCK_WIDTH) + 1;
	} else if (ClickMoveType == 2) {
		if (Click.y - location.y >= BLOCK_HEIGHT / BLOCK_DIV || location.y < buttonsPoint[ClickNum - 4].y) {
			location.y = buttonsPoint[ClickNum - 4].y;
		}
		ClickNumEnd = (int)(location.y / BLOCK_HEIGHT) * 4 + (int)(buttonsPoint[ClickNum].x / BLOCK_WIDTH) + 1;
	} else if (ClickMoveType == 3) {
		if (location.x - Click.x >= BLOCK_WIDTH / BLOCK_DIV || location.x > buttonsPoint[ClickNum + 1].x) {
			location.x = buttonsPoint[ClickNum + 1].x;
		}
		ClickNumEnd = (int)(buttonsPoint[ClickNum].y / BLOCK_HEIGHT) * 4 + (int)(location.x / BLOCK_WIDTH) + 1;
	} else if (ClickMoveType == 4) {
		if (location.y - Click.y >= BLOCK_HEIGHT / BLOCK_DIV || location.y > buttonsPoint[ClickNum + 4].y) {
			location.y = buttonsPoint[ClickNum + 4].y;
		}
		ClickNumEnd = (int)(location.y / BLOCK_HEIGHT) * 4 + (int)(buttonsPoint[ClickNum].x / BLOCK_WIDTH) + 1;
	} else {
		location.x = buttonsPoint[ClickNum].x;
		location.y = buttonsPoint[ClickNum].y;
		ClickNumEnd = ClickNum;
	}

	CGRect TempRect;
	TempRect.origin.x = buttonsPoint[ClickNum].x;
	TempRect.origin.y = buttonsPoint[ClickNum].y;
	TempRect.size.width = BLOCK_WIDTH;
	TempRect.size.height = BLOCK_HEIGHT;
	buttons[ClickNum].img.frame = TempRect;
	
	if (ClickNumEnd < 1 || ClickNumEnd > BLOCKS_COUNT || ClickNumEnd == ClickNum || buttons[ClickNumEnd].num != BLOCKS_COUNT) {
		ClickNum = 0;
		ClickMoveType = 0;
		Click.x = -1;
		Click.y = -1;
		return;
	} else {
		if (StartTimer == FALSE) {
			//[parentView startTimer];
			[parentView setBeginGame:true];
			[parentView startGame];
			StartTimer = TRUE;
		}
		
		if ([SoundOn intValue] == 1) {
			player.currentTime = 0.0;
			player.volume = [SoundVolume floatValue];
			[player play];
		}
		
		[parentView addPoint:1];
		
		
		[self changePos:ClickNum to:ClickNumEnd];
		StartGame = true;
		[self checkFinishGame];
	}
	
}

-(void)checkFinishGame {
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		if (buttons[i].num != i) {
			return;
		}
	}
	
	FinishMin = [parentView minTimer];
	FinishSec = [parentView secTimer];
	FinishPoint =  [parentView getPoint];
	
	[parentView stopGame];
	StartTimer = FALSE;
	FinishGame = TRUE;
	StartGame = false;
	if (FinishPoint > 0) {	
		FinishGameAlert = [[UIAlertView alloc] 
				initWithTitle:NSLocalizedString(@"FinishTitle",@"") 
				message:[NSString stringWithFormat: NSLocalizedString(@"FinishMessage",@""),FinishMin,FinishSec,FinishPoint,[self decline:FinishPoint string1:NSLocalizedString(@"step1",@"") string234:NSLocalizedString(@"step234",@"") stringMany:NSLocalizedString(@"step5",@"")]] 
				delegate:self 
				cancelButtonTitle:NSLocalizedString(@"Cansel",@"") 
				otherButtonTitles:NSLocalizedString(@"FinishButton",@""),nil];
		CGAffineTransform myTransform = CGAffineTransformMakeTranslation(0, 60);
		[FinishGameAlert setTransform:myTransform];
		
		
		
		NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/PlayerName.xml",NSHomeDirectory()]];
		NSString *PlayerNameText = [params valueForKey:@"PlayerName"];

		[PlayerName setText:PlayerNameText];
		
		[FinishGameAlert addSubview:PlayerName];
		[FinishGameAlert show];
	}
}

-(void)changePos:(int) i to:(int)j {
	Buttons tempButton;
	tempButton = buttons[i];
	buttons[i] = buttons[j];
	buttons[j] = tempButton;
	
	CGRect TempRect;
	TempRect = buttons[i].img.frame;
	buttons[i].img.frame = buttons[j].img.frame;
	buttons[j].img.frame = TempRect;
}

-(int)getRandomNumber:(int)from to:(int)to {
    return (int) from + arc4random() % (to-from+1);
}

-(int)random:(int)current {
	int i = [self getRandomNumber:1 to:4];
	if (i == 1) return current-4;
	if (i == 2) return current+1;
	if (i == 3) return current+4;
	if (i == 4) return current-1;	
	return current;
}

- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"iFifteenRating.sqlite"]];
	
	NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
    }    
	
    return persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (void)viewDidUnload {
	NSLog(@"BlockView viewDidUnload");

	NSMutableDictionary *params = [ [ NSMutableDictionary alloc ] init ];
	
	if (FinishGame == false && (StartGame == true || LoadGame == true)) {
		[parentView pauseGame];
		
		[params setValue:@"1" forKey:@"STATUS"];
		
		[params setValue:[NSString stringWithFormat:@"%d",[parentView minTimer]] forKey:@"Min"];
		[params setValue:[NSString stringWithFormat:@"%d",[parentView secTimer]] forKey:@"Sec"];
		[params setValue:[NSString stringWithFormat:@"%d",[parentView getPoint]] forKey:@"Point"];
		for (int i=1; i<=BLOCKS_COUNT; i++) {
			[params setValue:[NSString stringWithFormat:@"%d",buttons[i].num] forKey:[NSString stringWithFormat:@"img%d num",i]];
		}
	} else {
		[params setValue:@"0" forKey:@"STATUS"];
	}
	[params writeToFile:[NSString stringWithFormat:@"%@/Documents/Save.xml",NSHomeDirectory()] atomically:YES];
}

- (void)dealloc {
	NSLog(@"BlockView dealloc");
	[time invalidate];
	[managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
	
    [super dealloc];
}

@end
