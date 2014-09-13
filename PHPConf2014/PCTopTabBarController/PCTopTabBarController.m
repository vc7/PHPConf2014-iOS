//
//  PCTopTabBarController.m
//  PHPConf2014
//
//  Created by vincent on 2014/09/05.
//  Copyright (c) 2014 Vincent Chen. All rights reserved.
//

#import "PCTopTabBarController.h"

#import "UIColor+PHPConfAdditions.h"

@interface PCTopTabBarController () <PCTopTabBarDelegate>

@property (nonatomic, readwrite) PCTopTabBar *tabBar;

@property (strong, nonatomic) UIView *containerView;

@end

@implementation PCTopTabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBar = [[PCTopTabBar alloc] initWithFrame:CGRectZero];
    self.tabBar.backgroundColor = [UIColor phpconfDarkBlueColor];
    self.tabBar.delegate = self;
    
    self.containerView = [[UIView alloc] initWithFrame:self.view.frame];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.tabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self layoutTabBar];
    [self layoutSelectedViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Orientation Management

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutTabBar]; // Will call layout subviews while adjust the frame of the tab bar
    [self layoutSelectedViewController];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.view.userInteractionEnabled = NO; // Turn off user interaction during rotation
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.view.userInteractionEnabled = YES; // Turn on user interaction during rotation
}

#pragma mark - Accessor

- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    
    NSInteger count = [_viewControllers count];
    NSMutableArray *items = [NSMutableArray array];
    
    if (count > 0) {
        
        // Change the tab layout
        
        [_viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger index, BOOL *stop) {
            
            // Generate tab bar items
            PCTopTabBarItem *item = [[PCTopTabBarItem alloc] initWithTitle:viewController.title tag:index];
            
            // Add to items array
            [items addObject:item];
        }];
    }
    
    // Assign new items array back
    self.tabBar.items = items;
    
    [self initializeSelectedState];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    if (_selectedViewController != selectedViewController) {
        
        [_selectedViewController willMoveToParentViewController:nil]; // view controller hierarchy - will exit old one
        
        [_selectedViewController.view removeFromSuperview];
        
        [_selectedViewController removeFromParentViewController]; // view controller hierarchy - remove old one
        
        _selectedViewController = selectedViewController;
        
        [self addChildViewController:_selectedViewController]; // view controller hierarchy -  add new one
        
        [self layoutSelectedViewController];
        
        [_selectedViewController didMoveToParentViewController:self]; // view controller hierarchy - will display new one
        
        [self.containerView addSubview:self.selectedViewController.view];
    }
}

#pragma mark - Private Methods

- (void)layoutTabBar
{
    CGFloat tabBarHieght = 44;
    CGFloat statusBarHeight = 20;
    
    if (self.navigationController) {
        
        CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
        
        DLog(@"Navigation Bar Height - %.2f points",CGRectGetHeight(self.navigationController.navigationBar.frame));
        
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation) &&
            UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone &&
            NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1) {
            
            // status bar will hide while iPhone is in landscape mode when iOS version is iOS 8
            DLog(@"iOS version is larger than iOS 7");
            statusBarHeight = 0;
            
        }
        
        self.tabBar.frame = CGRectMake(0,
                                       navigationBarHeight + statusBarHeight,
                                       CGRectGetWidth(self.view.frame),
                                       tabBarHieght);
    } else {
        self.tabBar.frame = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(self.view.frame),
                                       tabBarHieght + statusBarHeight);
    }
    
    [self.tabBar setNeedsLayout];
}

- (void)layoutSelectedViewController
{
    if ([self.selectedViewController.view isKindOfClass:[UIScrollView class]]) {
        
        UIScrollView *scrollView = (UIScrollView *)self.selectedViewController.view;
        
        UIEdgeInsets scrollIndicatorInsets = scrollView.scrollIndicatorInsets;
        UIEdgeInsets contentInset = scrollView.contentInset;
        CGPoint contentOffset = scrollView.contentOffset;
        
        scrollIndicatorInsets.top = CGRectGetMaxY(self.tabBar.frame);
        contentInset.top = CGRectGetMaxY(self.tabBar.frame);
        contentOffset.y = - CGRectGetMaxY(self.tabBar.frame);
        
        if (self.navigationController) {
            
            if (self.navigationController.tabBarController) {
                
                scrollIndicatorInsets.bottom = CGRectGetHeight(((UITabBarController *)self.parentViewController.parentViewController).tabBar.frame);
                contentInset.bottom = CGRectGetHeight(self.navigationController.tabBarController.tabBar.frame);
            }
        }
        
        scrollView.scrollIndicatorInsets = scrollIndicatorInsets;
        scrollView.contentInset = contentInset;
        scrollView.contentOffset = contentOffset;
    }
    
    self.containerView.frame = self.view.frame;
    self.selectedViewController.view.frame = self.containerView.frame;
}

- (void)initializeSelectedState
{
    [self setSelectedItemWithIndex:0];
}

- (void)setSelectedItemWithIndex:(NSInteger)index
{
    self.tabBar.selectedItem = self.tabBar.items[index];
    self.selectedIndex = index;
    self.selectedViewController = self.viewControllers[index];
}

#pragma mark - PCTopTabBarDelegate 

- (void)tabBar:(PCTopTabBar *)tabBar didSelectItem:(PCTopTabBarItem *)item
{
    DLog(@"item clicked");
    
    [self setSelectedItemWithIndex:item.tag];
}

@end

@implementation UIViewController (PCTopTabBarControllerItem)

@dynamic topTabBarItem;

@end
