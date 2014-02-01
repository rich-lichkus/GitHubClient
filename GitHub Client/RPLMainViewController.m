//
//  RPLMainViewController.m
//  GitHub Client
//
//  Created by Richard Lichkus on 1/28/14.
//
//

#import "RPLMainViewController.h"

@interface RPLMainViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *btnCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *txtSearchBar;

// Actions
- (IBAction)pressedChangedView:(id)sender;

// Storage
@property (strong, nonatomic) NSMutableArray *users;
@property (strong, nonatomic) NSMutableArray *repos;

@property (nonatomic) NSInteger menuSelection;
@property (nonatomic) NSInteger viewSelection;

@end

@implementation RPLMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuSelection = 2;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadFinishedNotification:) name:@"DownloadedImage" object:nil];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.txtSearchBar.delegate = self;
}

#pragma mark - Collection Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellType;
    
    if(self.viewSelection == 0) {
        cellType = @"cell";
    } else  if (self.viewSelection == 1) {
        cellType = @"tableCell";
    }
    
    RPLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellType forIndexPath: indexPath];
    
    GitHubUser *user = [[GitHubUser alloc]init];
    user = [self.users objectAtIndex:indexPath.row];
    
    RPLGitHubRepo *repo = [RPLGitHubRepo new];
    repo = [self.repos objectAtIndex:indexPath.row];
    
   if(self.menuSelection == 1) {
       cell.lblName.text = user.name;
       if(user.avatar){
           cell.imgView.image = user.avatar;
       } else {
           [user downloadAvatar];
           user.downloading = YES;
           cell.imgView.image = [UIImage imageNamed:@"default_profile.png"];
       }
   } else if(self.menuSelection == 2) {
       cell.lblName.text = repo.repoName;
       cell.imgView.image = [UIImage imageNamed:@"default_profile.png"];
    }
    return cell;
}

#pragma mark - Collection DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger numItems = 0;
    switch (self.menuSelection) {
        case 1:
            numItems = self.users.count;
            break;
        case 2:
            numItems = self.repos.count;
            break;
    }
    return numItems;
}

#pragma mark - Segmented Controller

- (IBAction)pressedChangedView:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0 ) {
        self.viewSelection = 0;
    } else if (sender.selectedSegmentIndex == 1) {
        self.viewSelection = 1;
    }
    [self.collectionView reloadData];
}

#pragma mark - Search Bar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    if(self.menuSelection == 1){
        self.users = [[RPLNetworkController sharedController] usersForSearchString: [self.txtSearchBar text]];
    }
    else if (self.menuSelection == 2){
        self.repos = [[RPLNetworkController sharedController] reposForSearchString: [self.txtSearchBar text]];
    }
    [self.collectionView reloadData];
}

#pragma mark - NSNotificationCenter

- (void)downloadFinishedNotification:(NSNotification *)note
{
    id sender = [[note userInfo] objectForKey:@"user"];
    if ([sender isKindOfClass:[GitHubUser class]]) {
        NSLog(@"Download Finished For User: %@", sender);
        NSIndexPath *userPath = [NSIndexPath indexPathForItem:[self.users indexOfObject:sender] inSection:0];
        RPLCollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:userPath];
        cell.downloadingImage = NO;
        [_collectionView reloadItemsAtIndexPaths:@[userPath]];
    } else {
        NSLog(@"Sender was not a GitUser");
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSArray *indexPath = [self.collectionView indexPathsForSelectedItems];
        
        NSIndexPath *selectedCell = indexPath[0];
        RPLGitHubRepo *selectedRepo = [RPLGitHubRepo new];
        selectedRepo = [self.repos objectAtIndex:selectedCell.row];
        
        [[segue destinationViewController] setDetailItem:selectedRepo];
        [[segue destinationViewController] setTitle: selectedRepo.repoName];
    }
}
#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
