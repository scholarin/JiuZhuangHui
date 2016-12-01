//
//  MNAutoScrollView.m
//  JiuZhuangHui
//
//  Created by MosinNagant on 2016/11/29.
//  Copyright © 2016年 Mosin Nagant. All rights reserved.
//
#import "JiuZhuangHui.h"
#import "MNAutoScrollView.h"
@interface MNAutoScrollView ()<UIScrollViewDelegate>
@property (strong, nonatomic)UIScrollView *scrollView;
@property (strong, nonatomic)UIPageControl *pagecontroll;
@property (strong, nonatomic)NSTimer *timer;
@property (assign, nonatomic)NSInteger imageCount;

@end
@implementation MNAutoScrollView



- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray *)urlArray controllPage:(PageControllStyle)style{
    return  [self initWithFrame:frame array:urlArray isURL:YES controllPage:style];
}

- (instancetype)initWithFrame:(CGRect)frame imageNames:(NSArray *)imageNameArray controllPage:(PageControllStyle)style{
    
    return  [self initWithFrame:frame array:imageNameArray isURL:NO controllPage:style];
}



- (void)setControllIndictatorColor:(nullable UIColor *)pageIndictatorColor currentIndicatorColor:(nullable UIColor *)currentPageIndicatorColor{
    self.pagecontroll.pageIndicatorTintColor = pageIndictatorColor;
    self.pagecontroll.currentPageIndicatorTintColor = currentPageIndicatorColor;
}

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array isURL:(BOOL)isurl controllPage:(PageControllStyle)style{
    self.imageCount = array.count;
    if(self = [super initWithFrame:frame]){
        _scrollView = ({
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:frame];
            for (int i = 0; i < array.count; i++){
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
                if(isurl){
                    [imageView sd_setImageWithURL:[NSURL URLWithString:array[i]]];
                }else{
                    imageView.image = [UIImage imageNamed:array[i]];
                }
                
                [scrollView addSubview:imageView];
            }
            scrollView.contentSize = CGSizeMake(frame.size.width * array.count, frame.size.height);
            scrollView.pagingEnabled = YES;
            scrollView.showsHorizontalScrollIndicator = NO;
            scrollView.showsVerticalScrollIndicator = NO;
            scrollView.delegate = self;
            [self addSubview:scrollView];
            scrollView;
        });
        
        _pagecontroll = ({
            UIPageControl *pageControll = [[UIPageControl alloc]init];
            pageControll.numberOfPages = array.count;
            pageControll.currentPage = 1;
            pageControll.currentPageIndicatorTintColor = [UIColor redColor];
            CGSize size = [pageControll sizeForNumberOfPages:array.count];
            switch (style) {
                case PageControllStyleLeft:
                    pageControll.center = CGPointMake(kPaddingWith + size.width/2, frame.size.height * 3/4);
                    break;
                case PageControllStyleCenter:
                    pageControll.center = CGPointMake(frame.size.width/2, frame.size.height *3/4);
                    break;
                case PageControllStyleRight:
                    pageControll.center = CGPointMake(frame.size.width - kPaddingWith - size.width/2, frame.size.height *3/4);
                    break;
                default:
                    break;
            }
            [self addSubview:pageControll];
            pageControll;
        });
    }
    return  self;
}

- (void)timerOpen{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)timerClose{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)autoScroll{
    if(self.scrollView.contentOffset.x >= (self.imageCount - 1) * self.bounds.size.width){
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.pagecontroll.currentPage = 0;
    }else{
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.bounds.size.width, 0) animated:YES];
        self.pagecontroll.currentPage++;
    }
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    self.pagecontroll.currentPage =  scrollView.contentOffset.x/self.bounds.size.width;
    if(self.pagecontroll.currentPage == self.imageCount - 1){
        self.pagecontroll.hidden = YES;
        [self.delegate scrollViewDidScrollAtLast:self];
    }else{
        self.pagecontroll.hidden = NO;
        [self.delegate scrollViewDidScrollLeaveLast:self];

    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(self.isAutoScroll){
        [self timerClose];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.isAutoScroll){
        [self timerOpen];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
