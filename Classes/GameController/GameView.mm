//
//  GameView.mm
//  iFifteen
//
//  Created by AKEB on 9/3/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "GameView.h"
#import "GameViewController.h"
#import "CounterView.h"
#import "TimeView.h"
#import "Util.h"

@implementation GameView

@synthesize parentViewController;
@synthesize gameIsStarted, gameIsFinished;


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	NSUserDefaults *set = [[NSUserDefaults alloc] init];
	settings = [set dictionaryRepresentation];
	SoundVolume = [settings valueForKey:@"soundVolume"];
	SoundOn = [settings valueForKey:@"soundOn"];
	BlocksKind = [settings valueForKey:@"BlockKind"];
	//Регистрируем и сохраняем файл на диск
	[set synchronize];
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		images[i] = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.png",([BlocksKind intValue] == 1 ? @"b":@"n"), i]];
	}
	
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/Save%d.xml",NSHomeDirectory(),[BlocksKind intValue]]];
	NSString *SSTATUS = [params valueForKey:@"STATUS"];
	
	NSError *err;
	NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource: @"sound14" ofType:@"mp3" inDirectory:@"/"]];
	player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &err];
	[player prepareToPlay];
	[player setCurrentTime:0.0f];
	[player setVolume:[SoundVolume floatValue]];
	
	
	
	if ([SSTATUS intValue] == 1) {
		[self continueGame];
	} else {
		[self initGame];
		[self newGame];
	}
}

-(void) initGame {
	int kx=0;
	int ky=-1;
	CGRect TempRect;
	
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		if ((kx % ROW_SIZE) == 0) {
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
	
	[[self parentViewController] stopGame];
	
}

-(void) newGame {
	isNewGame = true;
	[self setGameIsStarted:false];
	[self setGameIsFinished:false];

	
	[[[self parentViewController] counterView] resetCount];
	[[[self parentViewController] timeView] setStartTimer:false];
	
	NSMutableDictionary *params = [ [ NSMutableDictionary alloc ] init ];
	[params setValue:@"0" forKey:@"STATUS"];
	[params writeToFile:[NSString stringWithFormat:@"%@/Documents/Save%d.xml",NSHomeDirectory(),[BlocksKind intValue]] atomically:YES];
	
	int first = 0;
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		if (buttons[i].num == BLOCKS_COUNT) {
			first = i;
			break;
		}
	}
	
	int next = 0;
	prev = 0;
	for (int i=1; i<=DIFFICULTY; i++) {
		next = (int)[self random_step:first];
		[self changePos:first to:next];
		first = next;
	}
	prev = 0;
	
	[[self parentViewController] newGame];
	
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([self gameIsFinished]) return;
	buttonMove = false;
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	CGRect rect = CGRectMake(0.0, 0.0, 304.0, 304.0);
	Click.x = -1;
	Click.y = -1;
	//if (FinishGame == false && CGRectContainsPoint(rect, location)) {
	if (CGRectContainsPoint(rect, location)) {
		Click.x = (int)location.x;
		Click.y = (int)location.y;
		ClickNum = (int)(Click.y / BLOCK_HEIGHT) * 4 + (int)(Click.x / BLOCK_WIDTH) + 1;
		if (ClickNum < 1 || ClickNum > BLOCKS_COUNT) return;
		if (ClickNum-1 >= 1 && ClickNum-1 <= BLOCKS_COUNT && buttons[ClickNum-1].num == BLOCKS_COUNT) {
			// Влево
			ClickMoveType = 1;
		} else if (ClickNum-ROW_SIZE >= 1 && ClickNum-ROW_SIZE <= BLOCKS_COUNT && buttons[ClickNum-ROW_SIZE].num == BLOCKS_COUNT) {
			// Вверх
			ClickMoveType = 2;
		} else if (ClickNum+1 >= 1 && ClickNum+1 <= BLOCKS_COUNT && buttons[ClickNum+1].num == BLOCKS_COUNT) {
			// Вправо
			ClickMoveType = 3;
		} else if (ClickNum+ROW_SIZE >= 1 && ClickNum+ROW_SIZE <= BLOCKS_COUNT && buttons[ClickNum+ROW_SIZE].num == BLOCKS_COUNT) {
			// Вниз
			ClickMoveType = 4;
		} else {
			ClickMoveType = 0;
		}
	}
	
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([self gameIsFinished]) return;
	if (ClickMoveType < 1 || ClickMoveType > 4) return;
	if (ClickNum < 1 || ClickNum > BLOCKS_COUNT) return;
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	buttonMove = true;
	int xy;
	CGRect TempRect;
	switch (ClickMoveType) {
		case 1:
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
			break;
		case 2:
			if (location.y >= buttonsPoint[ClickNum - ROW_SIZE].y && location.y <= buttonsPoint[ClickNum].y + BLOCK_HEIGHT) {
				xy = buttonsPoint[ClickNum].y + (location.y - Click.y);
				if (xy <= buttonsPoint[ClickNum - ROW_SIZE].y) xy = buttonsPoint[ClickNum - ROW_SIZE].y;
				else if (xy >= buttonsPoint[ClickNum].y) xy = buttonsPoint[ClickNum].y;
				TempRect.origin.x = buttonsPoint[ClickNum].x;
				TempRect.origin.y = xy;
				TempRect.size.width = BLOCK_WIDTH;
				TempRect.size.height = BLOCK_HEIGHT;
				buttons[ClickNum].img.frame = TempRect;
			}
			break;
		case 3:
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
			break;
		case 4:
			if (location.y <= buttonsPoint[ClickNum + ROW_SIZE].y + BLOCK_HEIGHT && location.y >= buttonsPoint[ClickNum].y) {
				xy = buttonsPoint[ClickNum].y + (location.y - Click.y);
				if (xy >= buttonsPoint[ClickNum + ROW_SIZE].y) xy = buttonsPoint[ClickNum + ROW_SIZE].y;
				else if (xy <= buttonsPoint[ClickNum].y) xy = buttonsPoint[ClickNum].y;
				TempRect.origin.x = buttonsPoint[ClickNum].x;
				TempRect.origin.y = xy;
				TempRect.size.width = BLOCK_WIDTH;
				TempRect.size.height = BLOCK_HEIGHT;
				buttons[ClickNum].img.frame = TempRect;
			}
			break;

		default:
			break;
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([self gameIsFinished]) return;
	UITouch *touch = [touches anyObject];
	CGPoint location = [touch locationInView:self];
	int ClickNumEnd;
	switch (ClickMoveType) {
		case 1:
			if (!buttonMove || Click.x - location.x >= BLOCK_WIDTH / BLOCK_DIV || location.x < buttonsPoint[ClickNum - 1].x) {
				location.x = buttonsPoint[ClickNum - 1].x;
			}
			ClickNumEnd = (int)(buttonsPoint[ClickNum].y / BLOCK_HEIGHT) * 4 + (int)(location.x / BLOCK_WIDTH) + 1;
			break;
		case 2:
			if (!buttonMove || Click.y - location.y >= BLOCK_HEIGHT / BLOCK_DIV || location.y < buttonsPoint[ClickNum - ROW_SIZE].y) {
				location.y = buttonsPoint[ClickNum - ROW_SIZE].y;
			}
			ClickNumEnd = (int)(location.y / BLOCK_HEIGHT) * 4 + (int)(buttonsPoint[ClickNum].x / BLOCK_WIDTH) + 1;
			break;
		case 3:
			if (!buttonMove || location.x - Click.x >= BLOCK_WIDTH / BLOCK_DIV || location.x > buttonsPoint[ClickNum + 1].x) {
				location.x = buttonsPoint[ClickNum + 1].x;
			}
			ClickNumEnd = (int)(buttonsPoint[ClickNum].y / BLOCK_HEIGHT) * 4 + (int)(location.x / BLOCK_WIDTH) + 1;
			break;
		case 4:
			if (!buttonMove || location.y - Click.y >= BLOCK_HEIGHT / BLOCK_DIV || location.y > buttonsPoint[ClickNum + ROW_SIZE].y) {
				location.y = buttonsPoint[ClickNum + ROW_SIZE].y;
			}
			ClickNumEnd = (int)(location.y / BLOCK_HEIGHT) * 4 + (int)(buttonsPoint[ClickNum].x / BLOCK_WIDTH) + 1;
			break;
		default:
			location.x = buttonsPoint[ClickNum].x;
			location.y = buttonsPoint[ClickNum].y;
			ClickNumEnd = ClickNum;
			break;
	}
	buttonMove = false;
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
		if ([[[self parentViewController] timeView] isStartTimer] == false ) {
			[self setGameIsStarted:true];
			[[[self parentViewController] timeView] startTimer];
			[[self parentViewController] startGame];
		}
		if ([[self parentViewController] gameIsPaused]) {
			[[self parentViewController] pauseGame:false];
		}
		
		if ([SoundOn intValue] == 1 && player && player != nil) {
			[player stop];
			[player setCurrentTime:0.0f];
			[player play];
			
		}

		// ОЧЕРЕДНОЕ ШАМАНСТВО!!!!!!
		buttonsPoint[BLOCKS_COUNT].x = buttonsPoint[BLOCKS_COUNT-ROW_SIZE].x;
		buttonsPoint[BLOCKS_COUNT].y = buttonsPoint[BLOCKS_COUNT-1].y;
		
		[[[self parentViewController] counterView] addCount];
		
		[self changePos:ClickNum to:ClickNumEnd];
		//StartGame = true;
		[self checkFinishGame];
	}
}

-(void)checkFinishGame {
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		if (buttons[i].num != i) {
			return;
		}
	}
	
	int Min = [[[self parentViewController] timeView] Min];
	int Sec = [[[self parentViewController] timeView] Sec];
	int Count = [[[self parentViewController] counterView] count];
	[[self parentViewController] stopGame];
	[self setGameIsFinished:true];
	[self setGameIsStarted:false];
	
	// СТАТИСТИКА!!!!
	[[self parentViewController] sendHighScore:Count min:Min sec:Sec];
	
	if (Count > 0) {	
		FinishGameAlert = [[UIAlertView alloc] 
						   initWithTitle:NSLocalizedString(@"FinishTitle",@"") 
						   message:[NSString stringWithFormat: NSLocalizedString(@"FinishMessage",@""),Min,Sec,Count,[Util decline:Count string1:NSLocalizedString(@"step1",@"") string234:NSLocalizedString(@"step234",@"") stringMany:NSLocalizedString(@"step5",@"")]] 
						   delegate:self 
						   cancelButtonTitle:NSLocalizedString(@"Cansel",@"") 
						   otherButtonTitles:NSLocalizedString(@"FinishButton",@""),nil];
		[FinishGameAlert show];
	}
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex {
	if (alertView == FinishGameAlert) {
		if (buttonIndex == 1) {
			
		}
	}
	[alertView release];
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

-(int)random_step:(int)current {
	BOOL doit;
	doit = true;
	int newI = 0;
	int i;
	do {
		i = [self getRandomNumber:1 to:4];
		switch (i) {
			case 1:
				if (prev != 3) newI = current-ROW_SIZE;
				break;
			case 2:
				if ((current % ROW_SIZE) != 0 && prev != 4) {
					newI = current+1;
				}
				break;
			case 3:
				if (prev != 1) newI = current+ROW_SIZE;
				break;
			case 4:
				if ((current % ROW_SIZE) != 1 && prev != 2) {
					newI = current-1;
				}
				break;
			default:
				break;
		}
		if (newI <= BLOCKS_COUNT && newI >= 1 && current != newI) doit = false;
	} while (doit);
	prev = i;
	return newI;
}

- (void) saveGame {
	
	NSMutableDictionary *params = [ [ NSMutableDictionary alloc ] init ];
	
	if (![self gameIsFinished] && [self gameIsStarted]) {
		[[self parentViewController] pauseGame:true];
		
		[params setValue:@"1" forKey:@"STATUS"];
		[params setValue:[NSString stringWithFormat:@"%d",[[[self parentViewController] timeView] Min]] forKey:@"Min"];
		[params setValue:[NSString stringWithFormat:@"%d",[[[self parentViewController] timeView] Sec]] forKey:@"Sec"];
		[params setValue:[NSString stringWithFormat:@"%d",[[[self parentViewController] counterView] count]] forKey:@"Point"];
		for (int i=1; i<=BLOCKS_COUNT; i++) {
			[params setValue:[NSString stringWithFormat:@"%d",buttons[i].num] forKey:[NSString stringWithFormat:@"img%d num",i]];
		}
	} else {
		[params setValue:@"0" forKey:@"STATUS"];
	}
	[params writeToFile:[NSString stringWithFormat:@"%@/Documents/Save%d.xml",NSHomeDirectory(),[BlocksKind intValue]] atomically:YES];	
}

-(void) continueGame {
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/Save%d.xml",NSHomeDirectory(),[BlocksKind intValue]]];
	
	
	
	[[[self parentViewController] counterView] resetCount];
	[[[self parentViewController] timeView] resetTimer];
	
	[self setGameIsStarted:true];
	[self setGameIsFinished:false];
	
	[[self parentViewController] startGame];
	[[self parentViewController] pauseGame:true];
	
	NSString *SMin = [params valueForKey:@"Min"];
	NSString *SSec = [params valueForKey:@"Sec"];
	NSString *SPoint = [params valueForKey:@"Point"];
	[[[self parentViewController] timeView] setTimerWithSec:[SMin intValue] sec:[SSec intValue]];
	[[[self parentViewController] counterView] setCount:[SPoint intValue]];

	int kx=0;
	int ky=-1;
	CGRect TempRect;
	for (int i=1; i<=BLOCKS_COUNT; i++) {
		NSString *SNum = [params valueForKey:[NSString stringWithFormat:@"img%d num",i]];
		
		if ((kx % ROW_SIZE) == 0) {
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
}

- (void)dealloc {
	if (player) [player release];
    [super dealloc];
}


@end
