//
//  AllWineViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "AllWineViewController.h"
#import "JiuZhuangHui.h"
#import "NetRequestManeger.h"
#import "MJRefresh.h"


#import "SingleWineCollectionViewCell.h"
#import "ShopingBarButtonItme.h"
#import "WinePurchaseModel.h"
#import "WineBuyViewController.h"
#import "ShopingBarButtonItme.h"
#import "LogIn.h"
#import "ShopingCartViewController.h"

@interface AllWineViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,SingleWineCollectionViewCellDelagate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, copy)NSMutableArray *allOfWines;
@property (nonatomic, assign)NSInteger page;

@end

static NSString * const kSingleWineCell = @"singlewineCell";
@implementation AllWineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部葡萄庄园酒";
    
    self.page = 1;
    
    [self setRightButtonItem];
    [self showCollection];
    [self requestAllOfWineWithPage:self.page];
    // Do any additional setup after loading the view.
}

- (void)setRightButtonItem{
    
    if([LogIn isLogIn]){
        NetRequestManeger *manager = [NetRequestManeger shareManager];
        [manager getShopCartWinesReponse:^(id reponseObjcet, NSError *error) {
            NSArray *goodlist = [WinePurchaseModel getShopCartWineListWithData:reponseObjcet];
            NSInteger cartWinesCount = 0;
            if(goodlist.count > 0){
                for(WinePurchaseModel *wine in goodlist){
                    cartWinesCount += [wine.goodsCount integerValue];
                }
            }
            ShopingBarButtonItme *item = [[ShopingBarButtonItme alloc]initWithShopCartCount:cartWinesCount];
            [item addTarget:self action:@selector(goShopCart) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:item];
        }];
    }
}

- (void)showCollection{
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake( (kScreen_Width - 20)/2, (kScreen_Width - 20)/2 +80);
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(updateWines)];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SingleWineCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kSingleWineCell];
    self.collectionView.backgroundColor = kHeaderViewColor;
    [self.view addSubview:self.collectionView];
}


- (void)goShopCart{
    ShopingCartViewController *shopCartVC = [[ShopingCartViewController alloc]init];
    shopCartVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shopCartVC animated:YES];
}
- (void)loadMore{
    self.page++;
    [self requestAllOfWineWithPage:self.page];
    [self.collectionView.mj_footer endRefreshing];
}
- (void)updateWines{
    self.page = 1;
    [self.allOfWines removeAllObjects];
    [self requestAllOfWineWithPage:self.page];
    [self.collectionView.mj_header endRefreshing];
}

- (NSMutableArray *)allOfWines{
    if(!_allOfWines){
        _allOfWines = [NSMutableArray new];
    }
    return _allOfWines;
}

- (void)requestAllOfWineWithPage:(NSInteger)page{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getAllOfWineWithPage:page reponse:^(id reponseObject, NSError *error) {
        NSArray *wines = [WinePurchaseModel getAllOfGoodlistWithData:reponseObject];
        if(wines.count < 9){
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.allOfWines addObjectsFromArray:wines];
        [self.collectionView reloadData];
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allOfWines.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SingleWineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSingleWineCell forIndexPath:indexPath];
    cell.delegate = self;
    WinePurchaseModel *wine = self.allOfWines.count > 0 ? self.allOfWines[indexPath.item] : nil;
    [cell setWineCellWithName:wine.goodsName wineID:wine.goodsID price:wine.goodsShopPrice image:wine.goodsImage];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WinePurchaseModel *wine = self.allOfWines[indexPath.item];
    WineBuyViewController *wineBuyVC = [[WineBuyViewController alloc]init];
    wineBuyVC.wineID = wine.goodsID;
    [self.navigationController pushViewController:wineBuyVC animated:YES];
}

#pragma  mark - singleDelegate

- (void)singleWineCollectionViewCell:(SingleWineCollectionViewCell *)cell didSelectedWineID:(NSString *)wineID{
    [[NSNotificationCenter defaultCenter]postNotificationName:kShopCartNumberChange object:nil userInfo:@{@"count" : @1}];
    [self postWineBuyInfoWithWineID:wineID];
}

- (void)postWineBuyInfoWithWineID:(NSString *)wineID {
    NetRequestManeger *manger = [NetRequestManeger shareManager];
    [manger postWineBuyInfoWithWineID:wineID count:1 reponse:^(id reponseObject, NSError *error) {
        if(error){
            NSLog(@"加入购物车失败,%@",error);
        }else{
            NSLog(@"已经加入购物车");
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
