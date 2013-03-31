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

#import "UIViewController+HCPushBackAnimation.h"

@interface OSSMasterViewController ()<UINavigationBarDelegate,UINavigationControllerDelegate,UISearchBarDelegate,UIScrollViewDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate> {
}
@property (nonatomic, strong) UISearchDisplayController * ossSearchDisplayController;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *searchView;
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray *objects;
@property (nonatomic,strong) NSMutableArray *searchObjects;
@property (nonatomic) BOOL isSearch;
@end

@implementation OSSMasterViewController


- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"Libraries";
        self.tableView = [[UITableView alloc]init];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self initDataSource];
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
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];    
    [self.tableView setBackgroundView:nil];

    // 検索
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
    [self.searchBar setDelegate:self];
    self.searchBar.tintColor = [UIColor darkGrayColor];
    self.searchBar.placeholder = @"Input Text";
    self.searchBar.keyboardType = UIKeyboardTypeASCIICapable;
    [_searchView addSubview:self.searchBar];
    

    _ossSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    _ossSearchDisplayController.delegate = self;
    _ossSearchDisplayController.searchResultsDelegate = self;
    _ossSearchDisplayController.searchResultsDataSource = self;
    
    self.tableView.tableHeaderView = self.searchView;
    [self.tableView.tableHeaderView sizeToFit];
    
    // 検索バーを隠す
    [self.tableView setContentOffset:CGPointMake(0, 44)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
    [self setView:_tableView];
    
    [self animationPopFrontScaleUp];
    [_searchView setFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44.0f)];
    [_searchBar sizeToFit];

}

- (void)refresh
{
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.tableView setContentOffset:CGPointMake(0, 44) animated:YES];
    [self.searchBar resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - data source

- (void)initDataSource
{
    _objects = [OSSGlobal getMenuPlist];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.ossSearchDisplayController.searchResultsTableView){
        return [_searchObjects count];
    } else {
        return [_objects count];        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.ossSearchDisplayController.searchResultsTableView) {
        return [[[_searchObjects objectAtIndex:section] objectForKey:@"rows"] count];
    } else {
        return [[[_objects objectAtIndex:section] objectForKey:@"rows"] count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.ossSearchDisplayController.searchResultsTableView) {
        return [[_searchObjects objectAtIndex:section] objectForKey:@"section"];
    } else {
        return [[_objects objectAtIndex:section] objectForKey:@"section"];
    }
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

    NSDictionary* cellData;
    if (tableView == self.ossSearchDisplayController.searchResultsTableView) {
        cellData = [_searchObjects[indexPath.section] objectForKey:@"rows"][indexPath.row];
    } else {
        cellData = [_objects[indexPath.section] objectForKey:@"rows"][indexPath.row];
    }
    cell.textLabel.text = [cellData objectForKey:@"name"];
    cell.detailTextLabel.text = [cellData objectForKey:@"detail"];
    cell.starBtn.selected = [OSSFavorite getStatusWitLibraryName:cell.textLabel.text];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    cell.userInteractionEnabled = YES;
    [cell addGestureRecognizer:singleTap];
    return cell;
}

- (void) handleTapGesture:(UITapGestureRecognizer*)sender {
    if (sender.state == UIGestureRecognizerStateEnded){
        CGPoint tapPoint = [sender locationInView:self.tableView];
//        DLog(@"%f %f",tapPoint.x,tapPoint.y );
        if (tapPoint.x >= 230) { // ★タップのしきい値
            [self starStatusChange:tapPoint];
        } else {
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:tapPoint];
            [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
        }
    }
}

- (void)starTapped:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    [self starStatusChange:currentTouchPosition];
}

- (void)starStatusChange:(CGPoint)touchPosition
{
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: touchPosition];
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
    
    NSDictionary *object;
    if (tableView == self.ossSearchDisplayController.searchResultsTableView) {
        object = [_searchObjects[indexPath.section] objectForKey:@"rows"][indexPath.row];
    } else {
        object = [_objects[indexPath.section] objectForKey:@"rows"][indexPath.row];
    }
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
    if (self.ossSearchDisplayController.active == YES) {
        return;
    }
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
    NSString *name;
    if (tableView == self.ossSearchDisplayController.searchResultsTableView) {
        name = [[_searchObjects[indexPath.section] objectForKey:@"rows"][indexPath.row] objectForKey:@"name"];
    } else {
        name = [[_objects[indexPath.section] objectForKey:@"rows"][indexPath.row] objectForKey:@"name"];
    }

    DLog(@"save %@, status %@", name, [cell.starBtn isSelected] ? @"YES" : @"NO");
    [OSSFavorite saveToStatus:[cell.starBtn isSelected] andLibraryName:name];
}

- (void)filterContentForSearchText:(NSString*)searchString scope:(NSString*)scope {
    [_searchObjects removeAllObjects];
    _searchObjects = [OSSGlobal getMenuPlistWithString:searchString];
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    DLog(@"search Display");
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    DLog(@"search Display Did End Search");
}

- (BOOL)searchDisplayController:(UISearchDisplayController*)controller shouldReloadTableForSearchString:(NSString*)searchString {
    [self filterContentForSearchText: searchString
                               scope: [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}
@end
