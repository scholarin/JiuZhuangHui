//
//  RootTabBarViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/11/30.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "BasicNavigationViewController.h"
#import "MainTableViewController.h"
#import "WineryTableViewController.h"
#import "UserTalkViewController.h"
#import "ShopingCartViewController.h"
#import "UserInfoViewController.h"

#import "ShopingBarButtonItme.h"
@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainTableViewController *mainTVC = [[MainTableViewController alloc]init];
    BasicNavigationViewController *mainNavC = [[BasicNavigationViewController alloc]initWithRootViewController:mainTVC];
    mainNavC.tabBarItem.title = @"首页";
    [mainNavC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [mainNavC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [mainNavC.tabBarItem setImage:[UIImage imageNamed:@"home"]];
    [mainNavC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_home"]];
    
    
    NSLog(@"tabbar加载了");
    WineryTableViewController *wineryVC = [[WineryTableViewController alloc]init];
    BasicNavigationViewController *wineryNaVC = [[BasicNavigationViewController alloc]initWithRootViewController:wineryVC];
    wineryNaVC.tabBarItem.title = @"酒庄";
    [wineryNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [wineryNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [wineryNaVC.tabBarItem setImage:[UIImage imageNamed:@"winery"]];
    [wineryNaVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_winery"]];
    
    UserTalkViewController *userTalkVC = [[UserTalkViewController alloc]init];
    BasicNavigationViewController *userTalkNaVC = [[BasicNavigationViewController alloc]initWithRootViewController:userTalkVC];
    userTalkNaVC.tabBarItem.title = @"用户说";
    [userTalkNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [userTalkNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [userTalkNaVC.tabBarItem setImage:[UIImage imageNamed:@"talk"]];
    [userTalkNaVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_talk"]];
    
    ShopingCartViewController *shopCartVC = [[ShopingCartViewController alloc]init];
    BasicNavigationViewController *shopingCartNaVC = [[BasicNavigationViewController alloc]initWithRootViewController:shopCartVC];
    shopingCartNaVC.tabBarItem.title = @"购物车";
    [shopingCartNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [shopingCartNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    
    ShopingBarButtonItme *item = [[ShopingBarButtonItme alloc]initWithShopCartCount:5];
    UIImage *image = [[self convertViewToImage:item] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [shopingCartNaVC.tabBarItem setImage:image];
    [shopingCartNaVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_shoping"]];
    
    UserInfoViewController *userInfoVc = [[UserInfoViewController alloc]init];
    BasicNavigationViewController *userInfoNaVC = [[BasicNavigationViewController alloc]initWithRootViewController:userInfoVc];
    userInfoNaVC.tabBarItem.title = @"会员";
    [userInfoNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [userInfoNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [userInfoNaVC.tabBarItem setImage:[UIImage imageNamed:@"user"]];
    [userInfoNaVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_user"]];

    
    self.viewControllers = @[mainNavC,wineryNaVC,userTalkNaVC,shopingCartNaVC,userInfoNaVC];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)convertViewToImage:(UIView *)view
{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


@end
