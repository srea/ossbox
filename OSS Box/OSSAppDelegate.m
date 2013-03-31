//
//  OSSAppDelegate.m
//  OSS Box
//
//  Created by tamazawayuuki on 2013/03/16.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSAppDelegate.h"
#import "OSSMasterViewController.h"
#import "OSSFavoriteViewController.h"
#import "OSSAboutViewController.h"
#import "UIViewController+HCPushBackAnimation.h"
#import <ShareThis.h>
#import <QuartzCore/QuartzCore.h>

@implementation OSSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    _masterViewController = [[OSSMasterViewController alloc]init];
    _favoriteViewController = [[OSSFavoriteViewController alloc]init];
    
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:masterViewController];

    NSArray *viewControllers = @[_masterViewController, _favoriteViewController];
//    NSArray *viewControllers = @[[[UITableViewController alloc]init], [[UITableViewController alloc]init]];
	_tabBarController = [[OSSCustomMHTabBarControllerViewController alloc] init];
	_tabBarController.viewControllers = viewControllers;
    _tabBarController.delegate = self;
	_tabBarController.title = @"OSS Box";
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_tabBarController];
	navController.navigationBar.tintColor = [UIColor blackColor];
    _tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"About" style:UIBarButtonItemStyleBordered target:self action:@selector(aboutButtonDidPush:)];

    navController.view.layer.cornerRadius = 5.0f;
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark tab delegate
- (BOOL)mh_tabBarController:(MHTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
	DLog(@"mh_tabBarController %@ shouldSelectViewController %@ at index %u", tabBarController, viewController, index);
    
    
	// Uncomment this to prevent "Tab 3" from being selected.
	//return (index != 2);
    
	return YES;
}

- (void)mh_tabBarController:(MHTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSUInteger)index
{
	DLog(@"mh_tabBarController %@ didSelectViewController %@ at index %u", tabBarController, viewController, index);
}


- (void)aboutButtonDidPush:(id)sender
{
    OSSAboutViewController *aboutController = [[OSSAboutViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:aboutController];
    nav.navigationBar.tintColor = [UIColor darkGrayColor];
    [_tabBarController presentModalViewController:nav animated:YES];
    [_tabBarController animationPushBackScaleDown];
}


@end
