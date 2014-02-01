//
//  RPLMasterViewController.m
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import "RPLMasterViewController.h"
#import "RPLDetailViewController.h"

@interface RPLMasterViewController () {
    NSMutableArray *_objects;
}

@property (strong, nonatomic) NSArray *searchResultsArray;
- (IBAction)pressedMenu:(id)sender;

@end

@implementation RPLMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.txtSearch.delegate = self;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.detailViewController = (RPLDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    if(self.searchString)
    {
        self.searchResultsArray = [[RPLNetworkController sharedController] reposForSearchString: self.searchString];
    }
    else
    {
        self.searchResultsArray = [[RPLNetworkController sharedController] reposForSearchString: @"iOS"];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *repo = [self.searchResultsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [repo objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        NSDictionary *repoDict = _searchResultsArray[indexPath.row];
     //   self.detailViewController.detailItem = repoDict;
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *selectedItem = self.searchResultsArray[indexPath.row];
     //   [[segue destinationViewController] setDetailItem:selectedItem];
        [[segue destinationViewController] setTitle: [selectedItem objectForKey:@"name"]];
    }
}

#pragma mark - Search Bar
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.txtSearch resignFirstResponder];
    self.searchResultsArray = [[RPLNetworkController sharedController] reposForSearchString: [self.txtSearch text]];
    [self.view setNeedsDisplay];
}

#pragma mark - Menu
- (IBAction)pressedMenu:(id)sender {
    if (self.view.frame.origin.x > 1.f) {
        [self.delegate openMenu];
    } else {
        [self.delegate closeMenu];
    }
}

#pragma mark - Lazy Instantiation
- (void) setSearchResultsArray:(NSArray *)searchResultsArray
{
    _searchResultsArray = [[NSArray alloc]initWithArray:searchResultsArray];
}

- (void) setSearchString:(NSString *)searchString
{
    _searchString = [[NSString alloc] initWithString: searchString];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
