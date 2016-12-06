//
//  UserTalkTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/6.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "UserTalkTableViewCell.h"
#import "JiuZhuangHui.h"
#import "MJRefresh.h"
#import "UserTalkCollectionViewCell.h"

#import "UserTalkModel.h"
#import "WineTastingModel.h"


static NSString *const kUserTalkColletionViewCell  = @"UserTalkCollectionViewCell";

@interface UserTalkTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic, assign)CollectionViewType collectionType;
@property(nonatomic, copy)NSArray *userTalkList;
@property(nonatomic, copy)NSArray *wineTastingList;

@end

@implementation UserTalkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self addCollectionView];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)addCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 0);
    layout.minimumInteritemSpacing = 20;
   // layout.minimumLineSpacing = 15;
    layout.itemSize = CGSizeMake(kScreen_Width/3, 130);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 160) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource= self;
    [self.collectionView registerClass:[UserTalkCollectionViewCell class] forCellWithReuseIdentifier:kUserTalkColletionViewCell];
    
//    MJRefreshAutoStateFooter *footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(pushAnotherView)];
//    [footer setTitle:@"松开查看更多" forState:MJRefreshStatePulling];
//    self.collectionView.mj_footer  = footer;
}




- (void)setCollectionViewData:(NSArray *)list andType:(CollectionViewType)collectionType{
    self.collectionType = collectionType;
    if(self.collectionType == CollectionViewTypeUserTalk) {
        self.userTalkList = list;
    }else if(self.collectionType == CollectionViewTypeWineTasting){
        self.wineTastingList = list;
    }else{
        NSLog(@"传入的数据种类出现错误");
    }
    
    [self.collectionView reloadData];
}

- (void)pushAnotherView{
    
}


#pragma  mark - collectionView delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UserTalkCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kUserTalkColletionViewCell forIndexPath:indexPath];
    if(self.collectionType == CollectionViewTypeUserTalk){
        UserTalkModel *userTalk = self.userTalkList[indexPath.item];
        [cell setCellWithTitle:userTalk.userTalkTitle Image:userTalk.userTalkImage];
    }else{
        WineTastingModel *wineTasting = self.wineTastingList[indexPath.item];
        [cell setCellWithTitle:wineTasting.wineTastingName Image:wineTasting.wineImage];
    }
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate UserTalkTableViewCell:self didSelectedItem:indexPath.item withType:self.collectionType];
}

@end
