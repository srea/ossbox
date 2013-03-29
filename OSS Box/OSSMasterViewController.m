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
#import "OSSCell.h"
#import "OSSFavorite.h"

@interface OSSMasterViewController () <UISearchBarDelegate,UIScrollViewDelegate> {
    NSMutableArray *_objects;
    NSArray *_title;
    BOOL _isSearch;
}
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *searchView;
@end

@implementation OSSMasterViewController


- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.title = @"OSS Box";
        
        [self initDataSource];
    }
    return self;
}

- (NSString *)tabTitle
{
    return @"OSS Libraries";
}

- (void)loadView
{
    [super loadView];
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44.0f)];
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"About" style:UIBarButtonItemStyleBordered target:self action:@selector(aboutButtonDidPush:)];
    [self.tableView setBackgroundView:nil];

    // 検索
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
    [self.searchBar setDelegate:self];
    self.searchBar.tintColor = [UIColor darkGrayColor];
    [_searchView addSubview:self.searchBar];
    
    self.tableView.tableHeaderView = _searchView;
    [self.tableView.tableHeaderView sizeToFit];
    
    // 検索バーを隠す
//    [self.tableView setContentOffset:CGPointMake(0, 44)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_searchView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44.0f)];
    [_searchBar sizeToFit];
    [self.tableView setContentOffset:CGPointMake(0, 44)];
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
    
    OSSCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OSSCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.starBtn addTarget:self action:@selector(starTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    }

    NSDictionary* cellData = [_objects[indexPath.section] objectForKey:@"rows"][indexPath.row];
    cell.textLabel.text = [cellData objectForKey:@"name"];
    cell.detailTextLabel.text = [cellData objectForKey:@"detail"];
    cell.starBtn.selected = [OSSFavorite getStatusWitLibraryName:cell.textLabel.text]; // TODO:nsuserdefaultsから取得して設定する。
    return cell;
}

- (void)starTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil)
    {
        [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // viewDidLoadが呼ばれなくなるのでコメントアウト
    if (!self.detailViewController) {
        self.detailViewController = [[OSSDetailViewController alloc] init];
    }
    NSDictionary *object = [_objects[indexPath.section] objectForKey:@"rows"][indexPath.row];
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if(YES) {
        return nil;
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (NSDictionary*section in _objects) {
        [tempArray addObject:[section objectForKey:@"section"]];
    }
    return tempArray;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        [_searchBar setFrame:CGRectMake(0,
                                        scrollView.contentOffset.y,
                                        _searchBar.frame.size.width,
                                        _searchBar.frame.size.height)];
    }
}
- (void) tableView: (UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    OSSCell *cell = (OSSCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.starBtn.selected = !cell.starBtn.selected;

    // 選択した行のお気に入りを解除なり登録なりする。
    NSString *name = [[_objects[indexPath.section] objectForKey:@"rows"][indexPath.row] objectForKey:@"name"];
    NSLog(@"save %@, status %@", name, [cell.starBtn isSelected] ? @"YES" : @"NO");
    [OSSFavorite saveToStatus:[cell.starBtn isSelected] andLibraryName:name];
}
@end
