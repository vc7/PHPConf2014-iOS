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
    self.view.backgroundColor = [UIColor grayColor];
    
    self.tabBar = [[PCTopTabBar alloc] initWithFrame:CGRectZero];
    self.tabBar.backgroundColor = [UIColor phpconfDarkBlueColor];
    
    [self layoutTabBar];
    
    [self.view addSubview:self.tabBar];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([self.parentViewController isKindOfClass:[UINavigationController class]]) {
        NSLog(@"parent is a navigation controller");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Orientation Management

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self layoutTabBar]; // Will call layout subviews while adjust the frame of the tab bar
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
    
}

#pragma mark - Private Methods

- (void)layoutTabBar
{
    CGFloat tabBarHieght = 44;
    CGFloat statusBarHieght = 20;
    
    if (self.navigationController) {
        CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
        
        self.tabBar.frame = CGRectMake(0,
                                       CGRectGetHeight(navigationBarFrame) + statusBarHieght,
                                       CGRectGetWidth(self.view.frame),
                                       tabBarHieght);
    } else {
        self.tabBar.frame = CGRectMake(0,
                                       0,
                                       CGRectGetWidth(self.view.frame),
                                       tabBarHieght + statusBarHieght);
    }
}

#pragma mark - PCTopTabBarDelegate 

- (void)tabBar:(PCTopTabBar *)tabBar didSelectItem:(PCTopTabBarItem *)item
{
    
}

@end

@implementation UIViewController (PCTopTabBarControllerItem)

@dynamic topTabBarItem;

@end
