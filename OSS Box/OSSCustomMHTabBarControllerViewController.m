//
//  OSSCustomMHTabBarControllerViewController.m
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/31.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSCustomMHTabBarControllerViewController.h"

@interface OSSCustomMHTabBarControllerViewController ()

@end

@implementation OSSCustomMHTabBarControllerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self animationPopFrontScaleUp];
}
@end
