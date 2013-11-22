//
//  MainMenuViewController.mm
//  MyOpenFeintSample
//
//  Created by AKEB on 9/2/10.
//  Copyright 2010 AKEB.RU. All rights reserved.
//

#import "MainMenuViewController.h"
#import "OFControllerLoader.h"
#import "OFViewHelper.h"
#import "OpenFeint.h"

#import	"HowToPlayController.h"
#import "SettingsController.h"
#import "GameViewController.h"

#import "iFifteenAppDelegate.h"
#import "Util.h"
// temp
#import "OFHighScoreService.h"
#import "OFCloudStorageService.h"
#import "OFAnnouncement.h"


#define MY_BANNER_UNIT_ID @"a14de6505903038"

@interface MainMenuViewController ()
	- (bool)canReceiveCallbacksNow;
	- (void)_push:(NSString*)name;
@end

@implementation MainMenuViewController

@synthesize delegate;
@synthesize newGame;
@synthesize continueGame;


- (bool)canReceiveCallbacksNow {
		//NSLog(@"[MainMenuViewController canReceiveCallbacksNow]");
	return true;
}

- (void) _push:(NSString*)name {
		//NSLog(@"[MainMenuViewController _push]");
	[self.navigationController pushViewController:OFControllerLoader::load(name) animated:YES];
}

- (IBAction) OpenFeilds {
		//NSLog(@"[MainMenuViewController OpenFeilds]");
	[OpenFeint launchDashboard];
}

- (IBAction) onHowToPlay {
		//NSLog(@"[MainMenuViewController onHowToPlay]");
	HowToPlayController *howToPlayController = [[HowToPlayController alloc] initWithNibName:@"HowToPlayController" bundle:nil];
	[howToPlayController setRootController:[[self delegate] rootController]];
	[[[self delegate] rootController] pushViewController:howToPlayController animated:YES];
}

- (IBAction) onSettings {
		//NSLog(@"[MainMenuViewController onSettings]");
	SettingsController *settingsController = [[SettingsController alloc] initWithNibName:@"SettingsController" bundle:nil];
	[settingsController setRootController:[[self delegate] rootController]];
	[settingsController setMainMenu:self];
	[[[self delegate] rootController] pushViewController:settingsController animated:YES];
}

- (IBAction) onNewGame {
		//NSLog(@"[MainMenuViewController onNewGame]");
	gameController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil newGame:true];
	[gameController setRootController:[[self delegate] rootController]];
	[gameController setMenuController:self];
	[[[self delegate] rootController] pushViewController:gameController animated:YES];
}

- (IBAction) onContinueGame {
		//NSLog(@"[MainMenuViewController onContinueGame]");
	gameController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil newGame:false];
	[gameController setMenuController:self];
	[gameController setRootController:[[self delegate] rootController]];
	[[[self delegate] rootController] pushViewController:gameController animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
		//NSLog(@"[MainMenuViewController initWithNibName]");
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void) checkContinueButton {
		//NSLog(@"[MainMenuViewController checkContinueButton]");
	
	NSUserDefaults *set = [[NSUserDefaults alloc] init];
	NSMutableDictionary *settings = [NSMutableDictionary dictionaryWithDictionary:[set dictionaryRepresentation]];
	NSString *BlocksKind = [settings valueForKey:@"BlockKind"];
	
	
	NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@/Documents/Save%d.xml",NSHomeDirectory(),[BlocksKind intValue]]];
	NSString *SSTATUS = [params valueForKey:@"STATUS"];
	if ([SSTATUS intValue] == 1) {
			//NSLog(@"GOOD LOAD");
		[continueGame setHidden:false];
		[newGame setHidden:true];
	} else {
			//NSLog(@"FALSE LOAD");
		[continueGame setHidden:true];
		[newGame setHidden:false];
	}
	
	if (bannerView_) [bannerView_ loadRequest:[GADRequest request]];
}

- (void)viewDidLoad {
		//NSLog(@"[MainMenuViewController viewDidLoad]");
    [super viewDidLoad];
	[self checkContinueButton];
	
	[self performSelectorInBackground:@selector(reportAppOpenToAdMob) withObject:nil];
	
	[self performSelectorInBackground:@selector(BannerLoad:) withObject:nil];
	[self performSelectorInBackground:@selector(sendAddUser:) withObject:nil];
}


// This method requires adding #import <CommonCrypto/CommonDigest.h> to your source file.
- (NSString *)hashedISU {
	NSString *result = nil;
	NSString *isu = @"";//[UIDevice currentDevice].uniqueIdentifier;
	
	if(isu) {
		unsigned char digest[16];
		NSData *data = [isu dataUsingEncoding:NSASCIIStringEncoding];
		CC_MD5([data bytes], [data length], digest);
		
		result = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
				  digest[0], digest[1],
				  digest[2], digest[3],
				  digest[4], digest[5],
				  digest[6], digest[7],
				  digest[8], digest[9],
				  digest[10], digest[11],
				  digest[12], digest[13],
				  digest[14], digest[15]];
		result = [result uppercaseString];
	}
	return result;
}

- (void)reportAppOpenToAdMob {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; // we're in a new thread here, so we need our own autorelease pool
																// Have we already reported an app open?
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
																		NSUserDomainMask, YES) objectAtIndex:0];
	NSString *appOpenPath = [documentsDirectory stringByAppendingPathComponent:@"admob_app_open"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if(![fileManager fileExistsAtPath:appOpenPath]) {
			// Not yet reported -- report now
		NSString *appOpenEndpoint = [NSString stringWithFormat:@"http://a.admob.com/f0?isu=%@&md5=1&app_id=%@",
									 [self hashedISU], @"363507222"];
		NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:appOpenEndpoint]];
		NSURLResponse *response;
		NSError *error = nil;
		NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
		if((!error) && ([(NSHTTPURLResponse *)response statusCode] == 200) && ([responseData length] > 0)) {
			[fileManager createFileAtPath:appOpenPath contents:nil attributes:nil]; // successful report, mark it as such
		}
	}
	[pool release];
}




#ifdef __IPHONE_4_1
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
	[UIView beginAnimations:@"animateAdBannerOff" context:NULL];
		// assumes the banner view is at the top of the screen.
	banner.frame = CGRectOffset(banner.frame, 0, 50);
	[UIView commitAnimations];
	
	
	bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
											self.view.frame.size.height -
											GAD_SIZE_320x50.height,
											GAD_SIZE_320x50.width,
											GAD_SIZE_320x50.height)];
	
		// Specify the ad's "unit identifier." This is your AdMob Publisher ID.
	bannerView_.adUnitID = MY_BANNER_UNIT_ID;
	
		// Let the runtime know which UIViewController to restore after taking
		// the user wherever the ad goes and add it to the view hierarchy.
	bannerView_.rootViewController = self;
	[self.view addSubview:bannerView_];
	
	// Initiate a generic request to load it with an ad.
	[bannerView_ loadRequest:[GADRequest request]];

}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
	
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
	
}
#endif

-(void) BannerLoad:(id)sender {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
#ifdef __IPHONE_4_1
	bann = [[[ADBannerView alloc] init] autorelease];
	[bann setFrame:CGRectMake(0, 430, 320, 50)];
	[bann setDelegate:self];
	[self.view addSubview:bann];
#else
	bannerView_ = [[GADBannerView alloc]
                   initWithFrame:CGRectMake(0.0,
                   self.view.frame.size.height -
                   GAD_SIZE_320x50.height,
                   GAD_SIZE_320x50.width,
                   GAD_SIZE_320x50.height)];
	
	// Specify the ad's "unit identifier." This is your AdMob Publisher ID.
	bannerView_.adUnitID = MY_BANNER_UNIT_ID;
	
	// Let the runtime know which UIViewController to restore after taking
	// the user wherever the ad goes and add it to the view hierarchy.
	bannerView_.rootViewController = self;
	[self.view addSubview:bannerView_];
	
	// Initiate a generic request to load it with an ad.
	[bannerView_ loadRequest:[GADRequest request]];
#endif
	[pool release];
}


-(void) sendAddUser:(id) sender {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	Util *util = [[[Util alloc] init] autorelease];
	[util SendAddUser];
	[pool release];
}


- (void)didReceiveMemoryWarning {
		//NSLog(@"[MainMenuViewController didReceiveMemoryWarning]");
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
		//NSLog(@"[MainMenuViewController viewDidUnload]");
    [super viewDidUnload];
	if (bannerView_)  [bannerView_ release];
	if (bann)  [bann release];
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
		//NSLog(@"[MainMenuViewController dealloc]");
	if (gameController) {
		//[gameController release];
		[gameController WillTerminate];
	}
    [super dealloc];
}


@end
