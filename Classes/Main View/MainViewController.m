//
//  MainViewController.m
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "FBConnect.h"
#import "Session.h"
#import "Util.h"


// Your Facebook APP Id must be set before running this example
// See http://www.facebook.com/developers/createapp.php
static NSString* kAppId = @"112752198778262";

@implementation MainViewController

@synthesize mainView;
@synthesize FriendsRating;


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"MainViewController initWithNibName");
	
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Custom initialization
		
		


		
		
		
		_permissions =  [[NSArray arrayWithObjects: @"publish_stream", @"read_stream", @"offline_access",nil] retain];
		
		
		
		
		
		
		
		NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
		NSLog(@"systemVersion=%@",systemVersion);
		NSLog(@"SEND TO akeb.ru Action add_user");
		NSString *uniqId = [[UIDevice currentDevice] uniqueIdentifier];
		NSString *StringForHash = [NSString stringWithFormat:@"%@app_id=1version=400system=%@uniqid=%@",@"secret56For23Akeb94",systemVersion,uniqId];
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.akeb.ru/pub/iPhoneApi.php?action=add_user&version=400&app_id=1&system=%@&uniqid=%@&hash=%@",systemVersion,uniqId,[Util uniqueIDFromString:StringForHash]]];
		NSString *PageData = [NSString stringWithContentsOfURL:url];
		NSLog(@"RESULT [%@]",PageData);
		NSLog(@"END SEND TO akeb.ru Action add_user");
		
	}
	return self;
}

- (void) viewDidLoad {
	
	FriendsRating.enabled = false;
	//FriendsRating.hidden  = true;
	
	
	NSLog(@"MainViewController viewDidLoad");
	_session = [[Session alloc] init];
	_facebook = [[_session restore] retain];
	if (_facebook == nil) {
		NSLog(@"FALSE");
		_facebook = [[[[Facebook alloc] init] autorelease] retain];
		_fbButton.isLoggedIn = NO;
	} else {
		NSLog(@"TRUE");
		_fbButton.isLoggedIn = YES;
		[self fbDidLogin];
	}
	[_fbButton updateImage];
}



-(void) flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

-(void) SettingsViewControllerDidFinish:(SettingsViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

-(void) howViewControllerDidFinish:(HowViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

-(void) ratingViewControllerDidFinish:(RatingViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

-(void) friendsRatingViewControllerDidFinish:(FriendsRatingViewController *)controller {
	[self dismissModalViewControllerAnimated:YES];
}

-(void) gameViewControllerDidFinish:(GameViewController *)controller {
	NSLog(@"MainViewController gameViewControllerDidFinish");
	[self dismissModalViewControllerAnimated:YES];
	[mainView checkContinue];
}

-(IBAction) showInfo {
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

-(IBAction) showHow {
	
	HowViewController *controller = [[HowViewController alloc] initWithNibName:@"HowView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

-(IBAction) showRating {
	
	RatingViewController *controller = [[RatingViewController alloc] initWithNibName:@"RatingView" bundle:nil];
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

-(IBAction) showFriendsRating {
	
	FriendsRatingViewController *controller = [[FriendsRatingViewController alloc] initWithNibName:@"FriendsRatingView" bundle:nil];
	controller.delegate = self;
	[controller setUserInfo:_userInfo];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	[controller release];
}

-(IBAction) showSettings {
	
	SettingsViewController *controller = [[SettingsViewController alloc] initWithNibName:@"SettingsView" bundle:nil];
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

-(IBAction) showGame {
	gameViewController = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
	gameViewController.delegate = self;
	[gameViewController setRoot:self];
	
	gameViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:gameViewController animated:YES];
	
	[gameViewController release];
}

-(void) didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(void) viewDidUnload {
	NSLog(@"MainViewController viewDidUnload");
	if (gameViewController != nil) {
		[gameViewController viewDidUnload];
	}
}


- (void)dealloc {
	NSLog(@"MainViewController dealloc");
	[_fbButton release];
	[_facebook release];
	[_permissions release];
	[_userInfo release];
	[super dealloc];
}



- (void) login {
	[_facebook authorize:kAppId permissions:_permissions delegate:self];
}

- (void) logout {
	[_session unsave];
	[_facebook logout:self]; 
}

- (IBAction) fbButtonClick: (id) sender {
	if (_fbButton.isLoggedIn) {
		[self logout];
	} else {
		[self login];
	}
}

-(void) Publish:(NSString *)min seconds:(NSString *)sec Points:(NSString *)point Kind:(NSString *)kind {
	NSLog(@"MainViewController Publish %@:%@ %@",min,sec,point);
	
	SBJSON *jsonWriter = [[SBJSON new] autorelease];
	
	NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys: 
														   @"The 15 puzzle",@"text",@"http://itunes.apple.com/us/app/id363507222?mt=8",@"href", nil], nil];
	NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
	
	NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
								@"The 15 puzzle", @"name",
								@"I cracked \"The 15 puzzle\" game", @"caption",
								[NSString stringWithFormat:@"I cracked \"The 15 puzzle\" game in %@ minute %@ seconds having made %@ steps. Try to hit my score!",min,sec,point], @"description",
								@"http://itunes.apple.com/us/app/id363507222?mt=8", @"href",
								nil];
	NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   kAppId, @"api_key",
								   @"Share on Facebook",  @"user_message_prompt",
								   actionLinksStr, @"action_links",
								   attachmentStr, @"attachment",
								   nil];
	
	[_facebook dialog: @"stream.publish"
			andParams: params
			andDelegate:self];
	NSLog(@"MainViewController Publish END %@:%@ %@",min,sec,point);
	
	NSLog(@"SEND TO akeb.ru");
	NSString *uniqId = [[UIDevice currentDevice] uniqueIdentifier];
	NSString *StringForHash = [NSString stringWithFormat:@"%@app_id=%duid=%@point=%@level=0min=%@sec=%@version=400uniqid=%@kind=%@",@"secret56For23Akeb94",1,_userInfo.uid,point,min,sec,uniqId,kind];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.akeb.ru/pub/iPhoneApi.php?action=add_record&version=400&app_id=1&uniqid=%@&uid=%@&point=%@&level=0&min=%@&sec=%@&kind=%@&hash=%@",uniqId,_userInfo.uid,point,min,sec,kind,[Util uniqueIDFromString:StringForHash]]];
	NSString *PageData = [NSString stringWithContentsOfURL:url];
	NSLog(@"%@",PageData);
	NSLog(@"END SEND TO akeb.ru");
}

- (IBAction) publishStream: (id) sender {
	[self Publish:@"20" seconds:@"40" Points:@"123"];
}

-(void) fbDidLogin {
	_fbButton.isLoggedIn         = YES;
	[_fbButton updateImage];
	_userInfo = [[[[UserInfo alloc] initializeWithFacebook:_facebook andDelegate: self] 
				  autorelease]
				 retain];
	[_userInfo requestAllInfo];
	
}

- (void)userInfoDidLoad {
	[_session setSessionWithFacebook:_facebook andUid:_userInfo.uid];
	[_session save];
	FriendsRating.enabled = true;
}

- (void)userInfoFailToLoad {
	[self logout]; 
	_fbButton.isLoggedIn = NO;
	FriendsRating.enabled = false;
}

- (void)fbDidNotLogin {
	NSLog(@"did not login");
}

-(void) fbDidLogout {
	[_session unsave];
	FriendsRating.enabled = false;
	_fbButton.isLoggedIn         = NO;
	[_fbButton updateImage];
}

- (void)request:(FBRequest*)request didReceiveResponse:(NSURLResponse*)response{
};

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error{
};

- (void)request:(FBRequest*)request didLoad:(id)result{
	if ([result isKindOfClass:[NSArray class]]) {
		result = [result objectAtIndex:0]; 
	}
};

- (void)dialogDidComplete:(FBDialog*)dialog{
}


@end
