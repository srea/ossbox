//
//  EDColorViewController.m
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/23.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "EDColorViewController.h"
#import "EDFirstViewController.h"
#import "EDSecondViewController.h"
#import "EDThirdViewController.h"
#import "EDFourthViewController.h"

@interface EDColorViewController ()
@property (nonatomic, strong) UITabBarController *tab;
@end

@implementation EDColorViewController

- (id) init {
    if (self = [super init]) {
        _tab = [[UITabBarController alloc]init];
        UIViewController *viewController1 = [[EDFirstViewController alloc] initWithNibName:@"EDFirstViewController" bundle:nil];
        UIViewController *viewController2 = [[EDSecondViewController alloc] initWithNibName:@"EDSecondViewController" bundle:nil];
        UIViewController *viewController3 = [[EDThirdViewController alloc] initWithNibName:@"EDThirdViewController" bundle:nil];
        UIViewController *viewController4 = [[EDFourthViewController alloc] initWithNibName:@"EDFourthViewController" bundle:nil];
        _tab.viewControllers = @[viewController1, viewController2, viewController3, viewController4];
    }
    return (EDColorViewController *)_tab; // MARK: キャストしてエラーを回避
}
@end
