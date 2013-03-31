//
//  OSSFavoriteViewController.m
//  OSS Box
//
//  Created by 玉澤 裕貴 on 2013/03/29.
//  Copyright (c) 2013年 srea. All rights reserved.
//

#import "OSSFavoriteViewController.h"
#import "OSSDetailViewController.h"
#import "OSSCell.h"
#import "OSSFavorite.h"

#import "UIViewController+HCPushBackAnimation.h"

@interface OSSFavoriteViewController () <UINavigationBarDelegate,UINavigationControllerDelegate,UISearchBarDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray *objects;
@property (nonatomic) BOOL isSearch;
@end

@implementation OSSFavoriteViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = @"★Stars";
        self.objects = [OSSGlobal getMenuPlistStar];
//        self.tableView = [[UITableView alloc]init];
//        self.tableView.dataSource = self;
//        self.tableView.delegate = self;
    }
    return self;
}


- (void)loadView
{
    [super loadView];
    _searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44.0f)];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

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
    [self.tableView setContentOffset:CGPointMake(0, 44)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setView:_tableView];
    [self refresh];
    [self animationPopFrontScaleUp];
    [_searchView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44.0f)];
    [_searchBar sizeToFit];

}

- (void)refresh
{
    self.objects = [OSSGlobal getMenuPlistStar];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    cell.starBtn.selected = [OSSFavorite getStatusWitLibraryName:cell.textLabel.text];
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
    DLog(@"save %@, status %@", name, [cell.starBtn isSelected] ? @"YES" : @"NO");
    [OSSFavorite saveToStatus:[cell.starBtn isSelected] andLibraryName:name];
    [self refresh];
}

@end
