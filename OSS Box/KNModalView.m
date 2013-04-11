//
//  KNModalView.m
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/25.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "KNModalView.h"

#import "KNFirstViewController.h"
#import "KNSecondViewController.h"
#import "KNAboutViewController.h"
#import "KNTableDemoController.h"


@interface KNModalView ()
@property (nonatomic, strong) UITabBarController *tab;
@end


@implementation KNModalView

- (id)init {
    if (self = [super init]) {
        _tab = [[UITabBarController alloc]init];
        
        // First tab
        UIViewController * vc1 = [[KNFirstViewController alloc] initWithNibName:@"KNFirstViewController" bundle:nil];
        
        // Second tab
        UINavigationController * uinav = [[UINavigationController alloc] initWithRootViewController:vc1];
        UIViewController * vc2 = [[KNSecondViewController alloc] initWithNibName:@"KNSecondViewController" bundle:nil];
        
        // Third tab
        KNTableDemoController * vc3 = [[KNTableDemoController alloc] initWithStyle:UITableViewStyleGrouped];
        
        // About tab
        KNAboutViewController * ab = [[KNAboutViewController alloc] initWithNibName:@"KNAboutViewController" bundle:nil];
        
        _tab.viewControllers = [NSArray arrayWithObjects:uinav, vc2, vc3, ab, nil];

    }
    return (KNModalView *)_tab; // MARK:
}

@end
