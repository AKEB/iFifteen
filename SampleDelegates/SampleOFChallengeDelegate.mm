#import "SampleOFChallengeDelegate.h"
#import "PlayAChallengeController.h"
#import "iFifteenAppDelegate.h"

#import "OFChallengeToUser.h"
#import "OFChallenge.h"
#import "OFChallengeDefinition.h"
#import "OFControllerLoader.h"

@implementation SampleOFChallengeDelegate

- (void)userLaunchedChallenge:(OFChallengeToUser*)challengeToLaunch withChallengeData:(NSData*)challengeData
{
	OFLog(@"Launched Challenge: %@", challengeToLaunch.challenge.challengeDefinition.title);
	PlayAChallengeController* controller = (PlayAChallengeController*)OFControllerLoader::load(@"PlayAChallenge");
	[controller setChallenge:challengeToLaunch];
	[controller setData:challengeData];
	iFifteenAppDelegate* appDelegate = (iFifteenAppDelegate*)[[UIApplication sharedApplication] delegate];	
	[appDelegate.rootController pushViewController:controller animated:YES];
}

- (void)userRestartedChallenge
{
	OFLog(@"Ignoring challenge restart.");
}

@end
