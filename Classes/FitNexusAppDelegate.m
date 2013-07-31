//
//  FitNexusAppDelegate.m
//  FitNexus
//
//  Created by keith on 26/08/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "FitNexusAppDelegate.h"


@implementation FitNexusAppDelegate

@synthesize window;
@synthesize tabBarController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
		//application.statusBarOrientation = UIInterfaceOrientationLandscapeRight;
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)dealloc {
	NSLog(@"del dealoc");
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

