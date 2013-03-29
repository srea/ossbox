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

#import <ShareThis.h>

@implementation OSSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

    OSSMasterViewController *masterViewController = [[OSSMasterViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:masterViewController];
    
    _tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    [_tabBarController setMinimumHeightToDisplayTitle:40.0];
    
    [_tabBarController setViewControllers:[NSMutableArray arrayWithObjects:nav,
                                           [[OSSFavoriteViewController alloc]init], nil]];
    
    // Tab background Image
    [_tabBarController setBackgroundImageName:@"noise-dark-gray.png"];
    [_tabBarController setSelectedBackgroundImageName:@"noise-dark-blue.png"];
    
    // Tabs top embos Color
    [_tabBarController setTabEdgeColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8]];
    [_tabBarController setHidesBottomBarWhenPushed:YES];
    
    self.window.rootViewController = _tabBarController;
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

@end
