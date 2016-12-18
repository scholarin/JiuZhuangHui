//
//  TopImageTableViewCell.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/12/13.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//

#import "TopImageTableViewCell.h"
#import "JiuZhuangHui.h"

@interface  TopImageTableViewCell()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UILabel *pageLabel, *nameLabel, *englishiNameLabel;
@property (nonatomic, assign)NSInteger count;

@end
@implementation TopImageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.scrollView = ({
            UIScrollView *scrollerView = [[UIScrollView alloc]init];
            scrollerView.pagingEnabled = YES;
            scrollerView.showsVerticalScrollIndicator = NO;
            scrollerView.showsHorizontalScrollIndicator = NO;
            scrollerView.delegate = self;
            [self addSubview:scrollerView];
            [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.bottom.equalTo(self);
            }];
            scrollerView;
        });
        
        self.pageLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.textColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:12];
            label.backgroundColor = [UIColor blackColor];
            label.layer.cornerRadius = 15;
            label.textAlignment = NSTextAlignmentCenter;
            label.clipsToBounds =YES;
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-20);
                make.top.equalTo(self).offset(20);
                make.height.width.equalTo(@30);
            }];
            label;
        });
        
        self.englishiNameLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor whiteColor];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
                make.bottom.equalTo(self).offset(-20);
            }];
            label;
        });
        
        self.nameLabel = ({
            UILabel *label = [[UILabel alloc]init];
            label.font = [UIFont systemFontOfSize:17 weight:2];
            label.textColor = [UIColor whiteColor];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
                make.bottom.equalTo(self.englishiNameLabel.mas_top);
            }];
            label;
        });
    }
    return self;
}

- (void)setImages:(NSArray *)imagesURL name:(NSString *)name englishName:(NSString *)englishName{
    
    for(int i = 0; i < imagesURL.count; i++){
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width * i, 0, kScreen_Width, [[self class] height])];
        [self.scrollView addSubview:imageView];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imagesURL[i]]];
    }
    self.count = imagesURL.count;
    self.scrollView.contentSize = CGSizeMake(kScreen_Width * imagesURL.count, [[self class] height]);
    self.pageLabel.text = [NSString stringWithFormat:@"1/%ld",imagesURL.count];
    self.nameLabel.text = name;
    self.englishiNameLabel.text = englishName;
}

+ (CGFloat)height{
    return 180;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSInteger currentPage = (int)(scrollView.contentOffset.x/kScreen_Width);
    self.pageLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentPage + 1,self.count];
}
@end
