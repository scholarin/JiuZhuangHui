//
//  lawsCollectionViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "lawsCollectionViewController.h"
#import "lawCollectionViewCell.h"
#import "NetRequestManeger.h"
#import "LawModel.h"
#import "JiuZhuangHui.h"

#import "LawDetailCollectionViewController.h"

static NSString *const klawCollectionViewCell = @"lawCollectionViewCell";

@interface LawsCollectionViewController ()

@property(nonatomic, strong)NSArray *laws;

@end

@implementation LawsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.backgroundColor = kHeaderViewColor;
    [self.collectionView registerClass:[LawCollectionViewCell class] forCellWithReuseIdentifier:klawCollectionViewCell];
    [self requestLaws];
    
    // Do any additional setup after loading the view.
}


- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat width = (kScreen_Width - 30)/2;
    layout.itemSize = CGSizeMake(width, width * 4/3);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    return [self initWithCollectionViewLayout:layout];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestLaws{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    NSString *urlWithString = @"http://www.jiuzhuanghui.com/ecmobile/?url=/2_1_0/articleList&cat_id=142&limit=7&page=1";
    [manager getRequestWithURL:urlWithString reponse:^(id reponseObject, NSError *error) {
        self.laws = [LawModel getlawsWithData:reponseObject];
        [self.collectionView reloadData];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.laws.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LawCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:klawCollectionViewCell forIndexPath:indexPath];
    LawModel *law = self.laws[indexPath.item];
    [cell setlawItemWithName:law.lawTitle image:law.lawSmallImage];
    return cell;
}



#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LawModel *law = self.laws[indexPath.item];
    LawDetailCollectionViewController *lawDetailVC = [[LawDetailCollectionViewController alloc]init];
    lawDetailVC.hidesBottomBarWhenPushed = YES;
    lawDetailVC.title = law.lawTitle;
    lawDetailVC.lawID = law.lawID;
    [self.navigationController pushViewController:lawDetailVC animated:YES];
}
@end
