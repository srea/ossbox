//
//  OSSAboutViewController.m
//  OSS Box
//
//  Created by tamazawayuuki on 2013/03/17.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSAboutViewController.h"

@interface OSSAboutViewController () <UINavigationControllerDelegate,UINavigationBarDelegate>

@end

@implementation OSSAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"About";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closeBtnDidPush:)];
}

- (void)closeBtnDidPush:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
