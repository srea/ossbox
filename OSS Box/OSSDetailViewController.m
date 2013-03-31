//
//  OSSDetailViewController.m
//  OSS Box
//
//  Created by tamazawayuuki on 2013/03/16.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSDetailViewController.h"
#import "OSSLibrary.h"

#import <MGBox/MGBox.h>
#import <MGScrollView.h>
#import <MGBoxLine.h>
#import <MGStyledBox.h>

#import <ShareThis.h>

#import <SVWebViewController.h>

#define ANIM_SPEED 0

@interface OSSDetailViewController ()
@property(nonatomic, strong) MGScrollView *scroller;
@property (nonatomic, strong) OSSLibrary *library;
@property (nonatomic, strong) NSMutableArray *objects;
@end

@implementation OSSDetailViewController

- (id)init
{
    if (self = [super init]) {
        _objects = [[NSMutableArray alloc]init];
        _library = [[OSSLibrary alloc]init];
        self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = [NSDictionary dictionaryWithDictionary:newDetailItem];
        [_library setName:[_detailItem objectForKey:@"name"]];
        [self makeDataSource];
    }
}

- (void)makeDataSource
{
    [_objects removeAllObjects];
    [_objects addObject:@[[_library name]]];
    [_objects addObject:@[[_library controller], [_library version]]];
    [_objects addObject:@[[_library detailText]]];
    [_objects addObject:@[[_library url], [_library arc], [_library targetOS]]];
    [_objects addObject:@[[_library licenseType], [_library licenseBody]]];
}

- (void)loadView
{
    [super loadView];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareBtn:)];
    self.navigationItem.rightBarButtonItem = shareBtn;
    _scroller = [[MGScrollView alloc] initWithFrame:self.view.frame];
    self.view = _scroller;
}

- (UIButton *)button:(NSString *)title for:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    CGSize size = [title sizeWithFont:button.titleLabel.font];
    button.frame = CGRectMake(0, 0, size.width + 40, 30);
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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = [_library name];
    [self.view setBackgroundColor: [UIColor colorWithPatternImage:[UIImage imageNamed:@"background-dark-gray-tex.png"]]];
    
    UIFont *headerFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];

    [_scroller.boxes removeAllObjects];
    _scroller.alwaysBounceVertical = YES;
    _scroller.delegate = self;
    
    //[self addBox:nil];
    
    // new section
    MGStyledBox *box1 = [MGStyledBox box];
    [_scroller.boxes addObject:box1];
    MGBoxLine *head1 = [MGBoxLine lineWithLeft:[_library name] right:[self button:@"Run" for:@selector(demoView:)]];
    head1.font = headerFont;
    [box1.topLines addObject:head1];
    MGBoxLine *author = [MGBoxLine lineWithLeft:@"Author" right:[_library author]];
    author.font = headerFont;
    [box1.topLines addObject:author];
    MGBoxLine *author_url = [MGBoxLine lineWithLeft:@"Link" right:[self button:@"WebPage" for:@selector(webView:)]];
    author_url.font = headerFont;
    [box1.topLines addObject:author_url];
    
    MGStyledBox *info = [MGStyledBox box];
    [_scroller.boxes addObject:info];
    MGBoxLine *arc = [MGBoxLine lineWithLeft:@"ARC" right:[_library arc]];
    arc.font = headerFont;
    [info.topLines addObject:arc];
    MGBoxLine *version = [MGBoxLine lineWithLeft:@"VERSION" right:[_library version]];
    version.font = headerFont;
    [info.topLines addObject:version];
    MGBoxLine *target = [MGBoxLine lineWithLeft:@"TARGET" right:[_library targetOS]];
    target.font = headerFont;
    [info.topLines addObject:target];
    
    
    
    MGStyledBox *box2 = [MGStyledBox box];
    [_scroller.boxes addObject:box2];
    
    MGBoxLine *head2 = [MGBoxLine lineWithLeft:@"Description" right:nil];
    head2.font = headerFont;
    [box2.topLines addObject:head2];
    
    MGBoxLine *multi = [MGBoxLine multilineWithText:[_library detailText] font:nil padding:24];
    [box2.topLines addObject:multi];
    
    MGStyledBox *box3 = [MGStyledBox box];
    [_scroller.boxes addObject:box3];
    
    MGBoxLine *head3 = [MGBoxLine lineWithLeft:@"Lisence Type" right:[_library licenseType]];
    head3.font = headerFont;
    [box3.topLines addObject:head3];
    
        UIFont *lisence = [UIFont fontWithName:@"HelveticaNeue" size:9];
    MGBoxLine *wordsLine = [MGBoxLine multilineWithText:[_library licenseBody] font:lisence padding:0];
    [box3.topLines addObject:wordsLine];
    
    [_scroller drawBoxesWithSpeed:ANIM_SPEED];
    [_scroller flashScrollIndicators];
    [_scroller setContentOffset:CGPointMake(0, 0)];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_objects objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.detailTextLabel.text = _objects[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        cell.textLabel.text = _objects[indexPath.section][indexPath.row];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Demo";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"Version";
        }
    } else if (indexPath.section == 2) {
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Source";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"ARC";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"Target";
        }
    } else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"License";
        } else if (indexPath.row == 1) {
            
        }
    }
    
    return cell;
}

- (void)demoView:(id)sender
{
    Class class = NSClassFromString([_library controller]);
    id controller = [[class alloc]init];
    [controller setTitle:[_library name]];
    if ([_library pageType] == 1) {
        [self.navigationController presentModalViewController:controller animated:YES];
    } else {
        [self.navigationController pushViewController:controller animated:YES];        
    }
}

- (void)webView:(id)sender
{
    if ([[_library url] length] > 0) {
        NSURL *url = [NSURL URLWithString:[_library url]];
        SVModalWebViewController *webViewController = [[SVModalWebViewController alloc] initWithURL:url];
        webViewController.modalPresentationStyle = UIModalPresentationPageSheet;
        webViewController.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsCopyLink | SVWebViewControllerAvailableActionsMailLink;
        webViewController.barsTintColor = [UIColor darkGrayColor];
        [self presentModalViewController:webViewController animated:YES];
    }
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


- (void)shareBtn:(id)sender
{
    NSURL *url = [[NSURL alloc]initWithString:[_library url]];
    [ShareThis showShareOptionsToShareUrl:url title:[_library name] image:nil onViewController:self];
}
@end
