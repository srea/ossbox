//
//  OSSAppDelegate.h
//  OSS Box
//
//  Created by tamazawayuuki on 2013/03/16.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Crittercism.h"

#import "OSSMasterViewController.h"
#import "OSSFavoriteViewController.h"
#import "OSSCustomMHTabBarControllerViewController.h"


@interface OSSAppDelegate : UIResponder <UIApplicationDelegate,MHTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) OSSMasterViewController *masterViewController;
@property (strong, nonatomic) OSSFavoriteViewController *favoriteViewController;
@property (strong, nonatomic) OSSCustomMHTabBarControllerViewController *tabBarController;
//@property (strong, nonatomic) UINavigationController *navigationController;

@end
