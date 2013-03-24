//
//  OSSAboutViewController.m
//  OSS Box
//
//  Created by tamazawayuuki on 2013/03/17.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSAboutViewController.h"

#import <MGBox/MGBox.h>
#import <MGScrollView.h>
#import <MGBoxLine.h>
#import <MGStyledBox.h>

#define ANIM_SPEED 0

@interface OSSAboutViewController () <UINavigationControllerDelegate,UINavigationBarDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) MGScrollView *scroller;

@end

@implementation OSSAboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"About";
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(closeBtnDidPush:)];
    
    [self.view setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-dark-gray-tex.png"]]];
    
    UIFont *headerFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    
    _scroller.alwaysBounceVertical = YES;
    _scroller.delegate = self;
    
    //[self addBox:nil];
    
    NSString *versionString = [NSString stringWithFormat:@"%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    
    // new section
    MGStyledBox *box1 = [MGStyledBox box];
    [_scroller.boxes addObject:box1];
    MGBoxLine *head1 = [MGBoxLine lineWithLeft:@"Version" right:versionString];
    head1.font = headerFont;
    [box1.topLines addObject:head1];
    MGBoxLine *author = [MGBoxLine lineWithLeft:@"Author" right:@"srea"];
    author.font = headerFont;
    [box1.topLines addObject:author];
    
    // new section
    MGStyledBox *box2 = [MGStyledBox box];
    [_scroller.boxes addObject:box2];
    MGBoxLine *count = [MGBoxLine lineWithLeft:@"Count" right:@"10"];
    count.font = headerFont;
    [box2.topLines addObject:count];
    
    [_scroller drawBoxesWithSpeed:ANIM_SPEED];
    [_scroller flashScrollIndicators];
    

}

- (void)closeBtnDidPush:(id)sender
{
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)loadView
{
    [super loadView];
    _scroller = [[MGScrollView alloc] initWithFrame:self.view.frame];
    self.view = _scroller;
    
}

- (UIButton *)button:(NSString *)title for:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0, -1);
    CGSize size = [title sizeWithFont:button.titleLabel.font];
    button.frame = CGRectMake(0, 0, size.width + 20, 26);
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = 3;
    button.backgroundColor = [UIColor whiteColor];
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0, 1);
    button.layer.shadowRadius = 0.8;
    button.layer.shadowOpacity = 0.6;
    return button;
}

- (void)addBox:(UIButton *)sender {
    MGStyledBox *box = [MGStyledBox box];
    MGBox *parentBox = [self parentBoxOf:sender];
    if (parentBox) {
        int i = [_scroller.boxes indexOfObject:parentBox];
        [_scroller.boxes insertObject:box atIndex:i + 1];
    } else {
        [_scroller.boxes addObject:box];
    }
    
    
    [_scroller drawBoxesWithSpeed:ANIM_SPEED];
    [_scroller flashScrollIndicators];
}

- (MGBox *)parentBoxOf:(UIView *)view {
    while (![view.superview isKindOfClass:[MGBox class]]) {
        if (!view.superview) {
            return nil;
        }
        view = view.superview;
    }
    return (MGBox *)view.superview;
}


@end
