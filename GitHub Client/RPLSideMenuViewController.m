//
//  RPLSideMenuViewController.m
//  GitHub Client
//
//  Created by Richard Lichkus on 1/27/14.
//
//

#import "RPLSideMenuViewController.h"

@interface RPLSideMenuViewController ()

@property (strong, nonatomic) NSArray *menuOptions;
@property (strong, nonatomic) RPLMasterViewController *masterVC;

@end

@implementation RPLSideMenuViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.menuOptions = [[NSArray alloc] initWithObjects:@"My Account",@"Users,"@"Repos",@"Gists", nil];
                    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.tableView.delegate = self;
    //self.tableView.dataSource = self;
    
    self.masterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"masterVC"];
    [self.masterVC setDelegate:self];
    
    [self addChildViewController:self.masterVC];
    self.masterVC.view.frame = self.view.frame;
    [self.view addSubview:self.masterVC.view];
    [self.masterVC didMoveToParentViewController:self];
    
    [self setupPanGesture];
    
    
}

#pragma mark - Pan Gesture
-(void)setupPanGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slidePanel:)];
    
    pan.minimumNumberOfTouches = 1;
    pan.maximumNumberOfTouches = 1;
    
    pan.delegate = self;
    
    [self.masterVC.view addGestureRecognizer:pan];
}

#pragma mark - Slide Panel

-(void)slidePanel:(id)sender
{
    UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)sender;
    
    CGPoint velocity = [pan velocityInView:self.view];
    CGPoint translation = [pan translationInView:self.view];
    
    if (pan.state == UIGestureRecognizerStateChanged)
    {
        if (self.masterVC.view.frame.origin.x + translation.x > 0) {
            
            self.masterVC.view.center = CGPointMake(self.masterVC.view.center.x + translation.x, self.masterVC.view.center.y);
            
            //CGFloat offset = 1 - (self.masterVC.view.frame.origin.x / self.view.frame.size.width);
            //NSLog(@"Offset: %f", offset);
            
            [(UIPanGestureRecognizer *)sender setTranslation:CGPointMake(0,0) inView:self.view];
        }
    }
    if (pan.state == UIGestureRecognizerStateEnded)
    {
        if (self.masterVC.view.frame.origin.x > self.view.frame.size.width / 8)
        {
            [self openMenu];
        }
        if (self.masterVC.view.frame.origin.x < self.view.frame.size.width / 8 )
        {
            [self closeMenu];
            
            /*[UIView animateWithDuration:.4 animations:^{
                self.masterVC.view.frame = self.view.frame;
            } completion:^(BOOL finished) {
                [self closeMenu];
            }];*/
        }
    }
    
}

#pragma mark - Menu Methods
- (void)openMenu
{
    [UIView animateWithDuration:0.2 animations:^{
        self.masterVC.view.frame = CGRectMake(self.view.frame.size.width * .5,
                                              self.masterVC.view.frame.origin.y,
                                              self.masterVC.view.frame.size.width,
                                              self.masterVC.view.frame.size.height);
                                              } completion:^(BOOL finished) { }];
}

- (void)closeMenu
{
    [UIView animateWithDuration:0.2 animations:^{
        self.masterVC.view.frame = CGRectMake(self.masterVC.view.frame.origin.x,
                                              self.masterVC.view.frame.origin.y,
                                              self.masterVC.view.frame.size.width,
                                              self.masterVC.view.frame.size.height); }];
}

-(void)slideBack:(id)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        self.masterVC.view.frame = self.view.frame;
    } completion:^(BOOL finished) {
        [self.masterVC.view removeGestureRecognizer:(UITapGestureRecognizer *)sender];
        [self closeMenu];
    }];
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuOptions.count;
    NSLog(@"here!!!!!!");
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"name";
    //[self.menuOptions objectAtIndex:indexPath.row];
    NSLog(@"%@",cell.textLabel.text);
    return cell;
}
*/
#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




@end
