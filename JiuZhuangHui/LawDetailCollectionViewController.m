//
//  LawDetailCollectionViewController.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/8.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "LawDetailCollectionViewController.h"
#import "NetRequestManeger.h"
#import "JiuZhuangHui.h"
#import "LawDetailCollectionViewCell.h"
#import "LawModel.h"


static NSString *const kLawDetailCollectionViewCell = @"lawDetailCollectionView";

@interface LawDetailCollectionViewController ()

@property(nonatomic, copy)NSArray *lawImages;

@property(nonatomic, strong)UILabel *pagelabel;
@end

@implementation LawDetailCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[LawDetailCollectionViewCell class] forCellWithReuseIdentifier:kLawDetailCollectionViewCell];
    [self requestLawImages];
    
    
    // Do any additional setup after loading the view.
}


- (UILabel *)pagelabel{
    if(!_pagelabel){
        _pagelabel = ({
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, kScreen_Height - 40, kScreen_Width, 40)];
            label.font = [UIFont systemFontOfSize:13];
            label.textAlignment = NSTextAlignmentCenter;
            
            [self.view addSubview:label];
            NSLog(@"%@",NSStringFromCGRect(label.frame));
            label;
        });
    }
    return _pagelabel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreen_Width, kScreen_Height - 64);
    layout.sectionInset = UIEdgeInsetsZero;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    return [self initWithCollectionViewLayout:layout];
}



- (void)requestLawImages{
    NetRequestManeger *manager = [NetRequestManeger shareManager];
    [manager getLawImagesWithID:self.lawID reponse:^(id reponseObject, NSError *error) {
        self.lawImages = [LawModel getlawContentImagesWithData:reponseObject];
        self.pagelabel.text = [NSString stringWithFormat:@"1/%ld",self.lawImages.count];
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

    return self.lawImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LawDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLawDetailCollectionViewCell forIndexPath:indexPath];
    [cell setImageViewImage:self.lawImages[indexPath.item]];
    return cell;
}

#pragma mark <UICollectionViewDelegate>


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat page =  scrollView.contentOffset.x / kScreen_Width;
    self.pagelabel.text = [NSString stringWithFormat:@"%d/%ld",(int)page + 1,self.lawImages.count];
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
