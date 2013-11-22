//
//  iFifteenAppDelegate.m
//  iFifteen
//
//  Created by AKEB on 3/10/10.
//  Copyright AKEB.RU 2010. All rights reserved.
//

#import "iFifteenAppDelegate.h"
#import "MainViewController.h"

@implementation iFifteenAppDelegate

@synthesize window;
@synthesize mainViewController;


-(void) applicationDidFinishLaunching:(UIApplication *)application {
	
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
		NSString *Version;
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
			
			if([keyValue isEqualToString:@"Version"])
				Version = defaultValue;
			
			if([keyValue isEqualToString:@"BlockKind"])
				BlockKind = defaultValue;
		}
		//Теперь, когда у нас есть все значения по умолчанию,
		//Создаем его здесь.
		NSDictionary *appPrerfs = [NSDictionary dictionaryWithObjectsAndKeys:
			SoundOn, @"soundOn",
			SoundVolume, @"soundVolume",
			Version, @"Version",
			BlockKind, @"BlockKind",
			nil];
		
		//Регистрируем и сохраняем файл на диск
		[[NSUserDefaults standardUserDefaults] registerDefaults:appPrerfs];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
	
	MainViewController *aController = [[MainViewController alloc] initWithNibName:@"MainView" bundle:nil];
	self.mainViewController = aController;
	[aController release];
	
	mainViewController.view.frame = [UIScreen mainScreen].applicationFrame;
	
	[window addSubview:[mainViewController view]];
	[window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	NSLog(@"iFifteenAppDelegate applicationWillTerminate");
	
	[mainViewController viewDidUnload];
}

-(void) dealloc {
	NSLog(@"iFifteenAppDelegate dealloc");
	
	[mainViewController release];
	[window release];
	[super dealloc];
}

@end
