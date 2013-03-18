//
//  OSSMasterViewController.m
//  OSS Box
//
//  Created by tamazawayuuki on 2013/03/16.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSMasterViewController.h"
#import "OSSDetailViewController.h"
#import "OSSAboutViewController.h"

@interface OSSMasterViewController () <UINavigationBarDelegate,UINavigationControllerDelegate> {
    NSMutableArray *_objects;
    NSArray *_title;
}
@end

@implementation OSSMasterViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"OSS Box";

        [self initDataSource];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"About" style:UIBarButtonItemStyleBordered target:self action:@selector(aboutButtonDidPush:)];
}

- (void)aboutButtonDidPush:(id)sender
{
    OSSAboutViewController *aboutController = [[OSSAboutViewController alloc]init];
    aboutController.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:aboutController];
    [self presentModalViewController:nav animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - data source

- (void)initDataSource
{
    _objects = [NSMutableArray array];
    
    NSMutableArray * layout = [NSMutableArray array];
    [layout addObject:@[@"MGBox",@"簡単にレイアウトが出来る",@""]];
    [layout addObject:@[@"MGBox",@"簡単にレイアウトが出来る",@""]];
    [_objects addObject:layout];
    
    NSMutableArray * button = [NSMutableArray array];
    [button addObject:@[@"UIBlossyButton",@"綺麗なボタン",@""]];
    [button addObject:@[@"QBFlatButton",@"フラットで綺麗なボタン",@""]];
    [_objects addObject:button];
    
    NSMutableArray * hud = [NSMutableArray array];
    [hud addObject:@[@"MBProgressHUD",@"",@""]];
    [hud addObject:@[@"SVProgressHUD",@"",@""]];
    [_objects addObject:hud];

    NSMutableArray * view = [NSMutableArray array];
    [view addObject:@[@"KLNoteViewController",@"",@""]];
    [view addObject:@[@"MCSwipeTableViewCell",@"",@""]];
    [view addObject:@[@"SVSegmentedControl",@"",@""]];
    [view addObject:@[@"ZGParallelView",@"",@""]];
    [_objects addObject:view];

    NSMutableArray * other = [NSMutableArray array];
    [other addObject:@[@"iCarousel",@"",@""]];
    [other addObject:@[@"REMenu",@"",@""]];
    [_objects addObject:other];

    NSMutableArray * notification = [NSMutableArray array];
    [notification addObject:@[@"NoticeView",@"",@""]];
    [notification addObject:@[@"AJNotificationView",@"",@""]];
    [notification addObject:@[@"KGStatusBar",@"",@""]];
    [_objects addObject:notification];
    
    _title = @[@"Layout",@"Button",@"Hud",@"View",@"Notification",@"Other"];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_objects objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_title objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSArray* plugin = _objects[indexPath.section][indexPath.row];
    cell.textLabel.text = [plugin objectAtIndex:0];
    cell.detailTextLabel.text = [plugin objectAtIndex:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
// viewDidLoadが呼ばれなくなるのでコメントアウト
//    if (!self.detailViewController) {
        self.detailViewController = [[OSSDetailViewController alloc] init];
//    }
    NSArray *object = _objects[indexPath.section][indexPath.row];
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
