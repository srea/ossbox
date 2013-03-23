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

@interface OSSMasterViewController () <UINavigationBarDelegate,UINavigationControllerDelegate,UISearchBarDelegate> {
    NSMutableArray *_objects;
    NSArray *_title;
    BOOL _isSearch;
}
@property (nonatomic,strong)UISearchBar *searchBar;
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

    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44.0f)];
    [self.searchBar setDelegate:self];
    self.searchBar.tintColor = [UIColor darkGrayColor];
    self.tableView.tableHeaderView = self.searchBar;
    [self.tableView.tableHeaderView sizeToFit];
    // 検索バーを隠す
    [self.tableView setContentOffset:CGPointMake(0, 44)];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.tableView setContentOffset:CGPointMake(0, 44) animated:YES];
    [self.searchBar resignFirstResponder];
}

- (void)aboutButtonDidPush:(id)sender
{
    OSSAboutViewController *aboutController = [[OSSAboutViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:aboutController];
    nav.navigationBar.tintColor = [UIColor darkGrayColor];
    [self presentModalViewController:nav animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - data source

- (void)initDataSource
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"OSSListDev" ofType:@"plist"];
    _objects = [NSArray arrayWithContentsOfFile:path];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_objects count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[_objects objectAtIndex:section] objectForKey:@"rows"] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[_objects objectAtIndex:section] objectForKey:@"section"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    NSDictionary* cellData = [_objects[indexPath.section] objectForKey:@"rows"][indexPath.row];
    cell.textLabel.text = [cellData objectForKey:@"name"];
    cell.detailTextLabel.text = [cellData objectForKey:@"detail"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
// viewDidLoadが呼ばれなくなるのでコメントアウト
//    if (!self.detailViewController) {
        self.detailViewController = [[OSSDetailViewController alloc] init];
//    }
    NSDictionary *object = [_objects[indexPath.section] objectForKey:@"rows"][indexPath.row];
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end
