#import "GameViewController.h"


@implementation GameViewController

@synthesize delegate;
@synthesize blockView;
@synthesize gameview;
@synthesize root;


-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	NSLog(@"MainViewController initWithNibName");
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Custom initialization
		
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[gameview setGameViewController:self];
}

- (void)menu:(id)sender {
	if (0 && [gameview beginGame]) {
		menuAlert = [[UIAlertView alloc] 
					 initWithTitle:NSLocalizedString(@"MenuTitle",@"") 
					 message:NSLocalizedString(@"MenuMessage",@"")  
					 delegate:self 
					 cancelButtonTitle:NSLocalizedString(@"Cansel",@"") 
					 otherButtonTitles:NSLocalizedString(@"OK",@""),nil];
		[menuAlert show];
	} else {
		[gameview viewDidUnload];
		[self.delegate gameViewControllerDidFinish:self];
	}
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger) buttonIndex {
	if (buttonIndex == 1) {
		[gameview viewDidUnload];
		[self.delegate gameViewControllerDidFinish:self];
	}
	[alertView release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	NSLog(@"GameViewController viewDidUnload");
	[gameview viewDidUnload];
}


- (void)dealloc {
	NSLog(@"GameViewController dealloc");
	
	if (gameview != nil ) {
		[gameview viewDidUnload];
	}
    [super dealloc];
}


@end
