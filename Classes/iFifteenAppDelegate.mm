#import "OpenFeint.h"
#import "OFControllerLoader.h"
#import "OpenFeint+GameCenter.h"

#import "iFifteenAppDelegate.h"

#import "SampleOFDelegate.h"
#import "SampleOFNotificationDelegate.h"
#import "SampleOFChallengeDelegate.h"

#import "SampleRootController.h"
#import "MainMenuViewController.h"

@implementation iFifteenAppDelegate

@synthesize window;
@synthesize rootController;

- (void)performApplicationStartupLogic {
	mainMenuViewController = [[MainMenuViewController alloc] initWithNibName:@"MainMenuViewController" bundle:nil];
	[mainMenuViewController setDelegate:self];
	[rootController pushViewController:mainMenuViewController animated:NO];
    // Override point for customization after app launch    
    window.frame = [UIScreen mainScreen].bounds;
    [window addSubview:rootController.view];
    [window makeKeyAndVisible];
	
	NSMutableDictionary *params = [ [ NSMutableDictionary alloc ] init ];
	[params setValue:@"0" forKey:@"Publish"];
	[params writeToFile:[NSString stringWithFormat:@"%@/Documents/Publish.xml",NSHomeDirectory()] atomically:YES];
	
	NSDictionary* settings = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithInt:UIInterfaceOrientationPortrait], OpenFeintSettingDashboardOrientation,
							  @"SampleApp", OpenFeintSettingShortDisplayName,
							  [NSNumber numberWithBool:YES], OpenFeintSettingEnablePushNotifications,
							  [NSNumber numberWithBool:NO], OpenFeintSettingDisableUserGeneratedContent,
  							  [NSNumber numberWithBool:NO], OpenFeintSettingAlwaysAskForApprovalInDebug,
							  window, OpenFeintSettingPresentationWindow,
							  [NSNumber numberWithBool:YES], OpenFeintSettingGameCenterEnabled,
							  nil
							  ];
							  
	ofDelegate = [SampleOFDelegate new];
	ofNotificationDelegate = [SampleOFNotificationDelegate new];
	ofChallengeDelegate = [SampleOFChallengeDelegate new];

	OFDelegatesContainer* delegates = [OFDelegatesContainer containerWithOpenFeintDelegate:ofDelegate
																	  andChallengeDelegate:ofChallengeDelegate
																   andNotificationDelegate:ofNotificationDelegate];

	[OpenFeint initializeWithProductKey:OPENFEINT_PRODUCT_KEY 
							  andSecret:OPENFEINT_SECRET
						 andDisplayName:@"The 15 puzzle"
							andSettings:settings
						   andDelegates:delegates];
	
	
	
	//Здесь мы указываем значения по умолчанию
	NSString *textValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"soundOn"];
	//Если первое значение равно нулю, значит, настройки по умолчанию не заданы.
	if(textValue == nil) {
		//Получаем доступ к бандлу
		NSString *bPath = [[NSBundle mainBundle] bundlePath];
		NSString *settingsPath = [bPath stringByAppendingPathComponent:@"Settings.bundle"];
		NSString *plistFile = [settingsPath stringByAppendingPathComponent:@"Root.plist"];
		//Получаем из словаря массив настроек
		NSDictionary *settingsDictionary = [NSDictionary dictionaryWithContentsOfFile:plistFile];
		NSArray *preferencesArray = [settingsDictionary objectForKey:@"PreferenceSpecifiers"];
		//Временные переменные
		NSDictionary *item;
		NSString *SoundOn;
		NSString *SoundVolume;
		NSString *BlockKind;
		//Циклический поиск в массиве (элемента preferencesArray)
		for(item in preferencesArray) {
			//Получение ключа элемента
			NSString *keyValue = [item objectForKey:@"Key"];
			
			//Получение значения по умолчанию из файла plist
			id defaultValue = [item objectForKey:@"DefaultValue"];
			
			if([keyValue isEqualToString:@"soundOn"])
				SoundOn = defaultValue;
			
			if([keyValue isEqualToString:@"soundVolume"])
				SoundVolume = defaultValue;
			
			if([keyValue isEqualToString:@"BlockKind"])
				BlockKind = defaultValue;
		}
		//Теперь, когда у нас есть все значения по умолчанию,
		//Создаем его здесь.
		NSDictionary *appPrerfs = [NSDictionary dictionaryWithObjectsAndKeys:
								   SoundOn, @"soundOn",
								   SoundVolume, @"soundVolume",
								   BlockKind, @"BlockKind",
								   nil];
		
		//Регистрируем и сохраняем файл на диск
		[[NSUserDefaults standardUserDefaults] registerDefaults:appPrerfs];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	
	
	
	
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[self performApplicationStartupLogic];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[self performApplicationStartupLogic];
	[OpenFeint respondToApplicationLaunchOptions:launchOptions];
	return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
		//[OpenFeint applicationDidBecomeActive];
}

- (void)applicationWillResignActive:(UIApplication *)application {
		//[OpenFeint applicationWillResignActive];
}

- (void)applicationWillTerminate:(UIApplication*)application {
	[OpenFeint shutdown];
	[self dealloc];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	[OpenFeint applicationDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	[OpenFeint applicationDidFailToRegisterForRemoteNotifications];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	[OpenFeint applicationDidReceiveRemoteNotification:userInfo];
}

- (void)dealloc {
	[ofDelegate release];
	[mainMenuViewController dealloc];
	[ofNotificationDelegate release];
	[ofChallengeDelegate release];
	[rootController release];
	[window release];
	[super dealloc];
}


@end

