//
//  DemoTableViewController.m
//  ZGParallelViewForTable
//
//  Created by Kyle Fang on 1/7/13.
//  Copyright (c) 2013 kylefang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ZGParallelViewController.h"
#import "UITableView+ZGParallelView.h"

@interface ZGParallelViewController ()
@property (strong, nonatomic) IBOutlet UIView *awesomeZG;
@property (strong, nonatomic) IBOutlet UIScrollView *headerScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *headerPageControl;
@property (strong, nonatomic) IBOutlet UIView *contontView;
@property (strong, nonatomic) IBOutlet UIImageView *avatar;
@property (nonatomic) BOOL usedPageControl;
@end

@implementation ZGParallelViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"asd");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self customizeUI];
    [self awakeFromNib];    
    //[self.tableView addParallelViewWithUIView:self.awesomeZG];
    [self.tableView addParallelViewWithUIView:self.awesomeZG withDisplayRadio:0.8 headerViewStyle:ZGScrollViewStyleCutOffAtMax];
    
}

- (IBAction)SwitchParallelViewStyle:(UISegmentedControl *)sender {
    ZGScrollViewStyle PVStyle = nil;
    switch (sender.selectedSegmentIndex) {
        case 0:
            PVStyle = ZGScrollViewStyleDefault;
            break;
        case 1:
            PVStyle = ZGScrollViewStyleCutOffAtMax;
            break;
        case 2:
            PVStyle = ZGScrollViewStyleStickToTheTop;
            break;
        default:
            break;
    }
    [self.tableView addParallelViewWithUIView:self.awesomeZG withDisplayRadio:0.8 headerViewStyle:PVStyle];
}




//=====================================================================
//
//             Rest of the code is for demo purpose
//
//=====================================================================

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self darkerTheBackground:scrollView.contentOffset.x];
}


- (void)customizeUI{
    self.headerScrollView.contentSize = self.contontView.frame.size;
    self.headerScrollView.scrollsToTop = NO;
    [self.avatar.layer setCornerRadius:5.f];
    [self.avatar.layer setMasksToBounds:YES];
}

- (void)darkerTheBackground:(CGFloat)xOffSet{
    if (xOffSet != 0) {
        CGFloat pageWidth = self.headerScrollView.frame.size.width;
        CGFloat alphaForContentView = xOffSet/pageWidth;
        if (alphaForContentView > 1.f) {
            alphaForContentView = 1.f;
        } else if (alphaForContentView < 0) {
            alphaForContentView = 0;
        }
        self.headerScrollView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7*alphaForContentView];
        if (!self.usedPageControl) {
            int page = floor((xOffSet - pageWidth / 2) / pageWidth) + 1;
            self.headerPageControl.currentPage = page;
        }
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.headerScrollView) {
        self.usedPageControl = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.headerScrollView) {
        self.usedPageControl = NO;
    }
}

- (IBAction)pageChanged:(UIPageControl *)sender {
    CGFloat headerViewWidth = self.headerScrollView.frame.size.width;
    CGRect frame = self.headerScrollView.frame;
    frame.origin = CGPointMake(headerViewWidth*sender.currentPage, 0);
    self.usedPageControl = YES;
    [self.headerScrollView scrollRectToVisible:frame animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
