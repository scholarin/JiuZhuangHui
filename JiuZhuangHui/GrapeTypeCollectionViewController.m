//
//  GrapeTypeCollectionViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/5.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "GrapeTypeCollectionViewController.h"
#import "GrapeTypesCollectionViewCell.h"

#import "JiuZhuangHui.h"
#import "GrapeModel.h"
#import "HeaderCollectionViewCell.h"
#import "GrapeTypeTableViewController.h"

@interface GrapeTypeCollectionViewController ()

@property(nonatomic, strong)NSArray *grapeTypes;

@end

@implementation GrapeTypeCollectionViewController

static NSString * const kGrapeTypeCollectionCell = @"GrapeTypesCollectionVeiwCell";
static NSString * const kHeaderView = @"headerView";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"葡萄品种";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:kGrapeTypeCollectionCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kGrapeTypeCollectionCell];
    [self.collectionView registerClass:[HeaderCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderView];
     [self.collectionView registerClass:[HeaderCollectionViewCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kHeaderView];
    self.collectionView.scrollEnabled = NO;
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
//    layout.itemSize = CGSizeMake((kScreen_Width - 120)/5, (kScreen_Width - 120)/5 + 20);
//    layout.minimumLineSpacing = 20;
    
    
    // Do any additional setup after loading the view.
}

- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((kScreen_Width - 120)/5, (kScreen_Width - 120)/5 + 20); //
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    layout.headerReferenceSize = CGSizeMake(kScreen_Width,10);
    layout.footerReferenceSize = CGSizeMake(kScreen_Width, kScreen_Height);
    
    return [self initWithCollectionViewLayout:layout];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setGrapeTypeArray:(NSArray *)grapeTypes{
    self.grapeTypes = grapeTypes;
}

//- (instancetype)init{
//    if(self = [super init]){
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//        layout.itemSize = CGSizeMake((kScreen_Width - 120)/5, (kScreen_Width - 120)/5 + 20);
//        layout.minimumLineSpacing = 20;
//        self.collectionView.collectionViewLayout = layout;
//    }
//    return self;
//}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.grapeTypes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GrapeTypesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGrapeTypeCollectionCell forIndexPath:indexPath];
    GrapeModel *grape = self.grapeTypes[indexPath.item];
    [cell setGrapeName:grape.grapeName image:grape.grapeImage];
    // Configure the cell
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(nonnull NSString *)kind atIndexPath:(nonnull NSIndexPath *)indexPath{
    if([kind isEqual:UICollectionElementKindSectionHeader]){
        HeaderCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderView forIndexPath:indexPath];
        return cell;
    }
    if([kind isEqual:UICollectionElementKindSectionFooter]){
        HeaderCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kHeaderView forIndexPath:indexPath];
        return cell;
    }
    return nil;
}



#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GrapeTypeTableViewController *grapeTypeVC = [[GrapeTypeTableViewController alloc]init];
    GrapeModel *grape = self.grapeTypes[indexPath.item];
    [grapeTypeVC setGrapeID:grape.grapeID Name:grape.grapeName image:grape.grapeImage detail:grape.grapeDesc];
    
    [self.navigationController pushViewController:grapeTypeVC animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
