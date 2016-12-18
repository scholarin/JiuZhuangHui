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
#import "NetRequestManeger.h"  
#import "WinePurchaseModel.h"
#import "LogIn.h"

#import "ShopingBarButtonItme.h"
static NSString *const kShopCartNumberChange = @"shopCartNumberChange";
@interface RootTabBarViewController ()

@property (nonatomic, strong)BasicNavigationViewController *mainNavC,*wineryNaVC,*userTalkNaVC,*shopingCartNaVC,*userInfoNaVC;

@end

@implementation RootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainTableViewController *mainTVC = [[MainTableViewController alloc]init];
    self.mainNavC = [[BasicNavigationViewController alloc]initWithRootViewController:mainTVC];
    _mainNavC.tabBarItem.title = @"首页";
    [_mainNavC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [_mainNavC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [_mainNavC.tabBarItem setImage:[UIImage imageNamed:@"home"]];
    [_mainNavC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_home"]];
    
    
    WineryTableViewController *wineryVC = [[WineryTableViewController alloc]init];
    self.wineryNaVC = [[BasicNavigationViewController alloc]initWithRootViewController:wineryVC];
    _wineryNaVC.tabBarItem.title = @"酒庄";
    [_wineryNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [_wineryNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [_wineryNaVC.tabBarItem setImage:[UIImage imageNamed:@"winery"]];
    [_wineryNaVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_winery"]];
    
    UserTalkViewController *userTalkVC = [[UserTalkViewController alloc]init];
    self.userTalkNaVC = [[BasicNavigationViewController alloc]initWithRootViewController:userTalkVC];
    _userTalkNaVC.tabBarItem.title = @"用户说";
    [_userTalkNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [_userTalkNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [_userTalkNaVC.tabBarItem setImage:[UIImage imageNamed:@"talk"]];
    [_userTalkNaVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_talk"]];
    ShopingCartViewController *shopCartVC = [[ShopingCartViewController alloc]init];
    self.shopingCartNaVC = [[BasicNavigationViewController alloc]initWithRootViewController:shopCartVC];
    
    
    _shopingCartNaVC.tabBarItem.title = @"购物车";
    if([LogIn isLogIn]){
        NetRequestManeger *manager = [NetRequestManeger shareManager];
        [manager getShopCartWinesReponse:^(id reponseObjcet, NSError *error) {
            NSArray *goodlist = [WinePurchaseModel getShopCartWineListWithData:reponseObjcet];
            if(goodlist.count > 0){
                NSInteger wineCount = 0;
                for(WinePurchaseModel *wine in goodlist){
                    wineCount += [wine.goodsCount integerValue];
                }
                _shopingCartNaVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",wineCount];
            }
        }];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addShopCart:) name:kShopCartNumberChange object:nil];
    [_shopingCartNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [_shopingCartNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [_shopingCartNaVC.tabBarItem setImage:[UIImage imageNamed:@"shoping"]];
    [_shopingCartNaVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_shoping"]];

    UserInfoViewController *userInfoVc = [[UserInfoViewController alloc]init];
    self.userInfoNaVC = [[BasicNavigationViewController alloc]initWithRootViewController:userInfoVc];
    _userInfoNaVC.tabBarItem.title = @"会员";
    [_userInfoNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState: UIControlStateNormal];
    [_userInfoNaVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}  forState: UIControlStateSelected];
    [_userInfoNaVC.tabBarItem setImage:[UIImage imageNamed:@"user"]];
    [_userInfoNaVC.tabBarItem setSelectedImage:[UIImage imageNamed:@"lighted_user"]];

    
    self.viewControllers = @[_mainNavC,_wineryNaVC,_userTalkNaVC,_shopingCartNaVC,_userInfoNaVC];
    // Do any additional setup after loading the view.
}

- (void)addShopCart:(NSNotification *)not{
    NSInteger count = [not.userInfo[@"count"] integerValue];
    NSInteger oldCount = [self.shopingCartNaVC.tabBarItem.badgeValue integerValue];
    NSString *newCount = [NSString stringWithFormat:@"%ld",count + oldCount];
    self.shopingCartNaVC.tabBarItem.badgeValue = newCount;
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

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


@end
