//
//  IndexBannerView.m
//  IndexBannerView
//
//  Created by mac on 15/5/25.
//  Copyright (c) 2015年 xin. All rights reserved.
//

#import "IndexBannerView.h"

#define banWidh self.bounds.size.width
#define banHeight self.bounds.size.height

static CGFloat const changeImageTime = 3.0;

@interface IndexBannerView()<UIScrollViewDelegate>{
    
    UIPageControl *pageCtrl;
    UIScrollView *bannerScrollView;
    NSTimer *_imageChageTimer;
    
}


@end

@implementation IndexBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        _imageChageTimer = [NSTimer scheduledTimerWithTimeInterval:changeImageTime target:self selector:@selector(chageImage) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setImageItemsArray:(NSArray *)imageItemsArray
{
    if (_imageItemsArray == nil) {
        
        _imageItemsArray = imageItemsArray;
        

        [self layoutSubviews];
    }
    else{
        
        [self reloadData:imageItemsArray];
    }
}



- (void)createBannerViews
{
    
    if (_imageItemsArray.count == 1) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, banWidh, banHeight)];
        imgView.image = [UIImage imageNamed:_imageItemsArray[0]];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        
        UIControl *imgAct = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, banWidh, banHeight)];
        imgAct.tag = 100;
        [imgAct addTarget:self action:@selector(imgAction:) forControlEvents:UIControlEventTouchUpInside];
        [imgView addSubview:imgAct];

        return;
    }
    
    
    bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, banWidh, banHeight)];
    bannerScrollView.contentSize = CGSizeMake(banWidh + 300, banHeight);
    bannerScrollView.showsHorizontalScrollIndicator = NO;
    bannerScrollView.showsVerticalScrollIndicator = NO;
    bannerScrollView.pagingEnabled = YES;
    
    for (int i = 0; i < _imageItemsArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(banWidh * (i+1), 0, banWidh, banHeight)];
        NSString *imgeUrl = [_imageItemsArray objectAtIndex:i];
        if ([imgeUrl hasPrefix:@"http:\\"]) {
#warning -这里加载网络图片
            
        }else{
            [imageView setImage:[UIImage imageNamed:_imageItemsArray[i]]];
        }
        imageView.userInteractionEnabled = YES;
        [bannerScrollView addSubview:imageView];
        
        UIControl *imgAct = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, banWidh, banHeight)];
        imgAct.tag = 100 + i;
        [imgAct addTarget:self action:@selector(imgAction:) forControlEvents:UIControlEventTouchUpInside];
        [imageView addSubview:imgAct];

    }
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self addSubview:bannerScrollView];
   
    
    //设置尾部跳转到第一个
    UIImageView *firImg = [[UIImageView alloc] initWithFrame:CGRectMake(banWidh * (_imageItemsArray.count + 1), 0, banWidh, banHeight)];
    [firImg setImage:[UIImage imageNamed:_imageItemsArray[0]]];
    [bannerScrollView addSubview:firImg];
    
    //设置头部跳转到最后一个
    UIImageView *lastImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, banWidh, banHeight)];
    [lastImg setImage:[UIImage imageNamed:_imageItemsArray[_imageItemsArray.count - 1]]];
    [bannerScrollView addSubview:lastImg];
    
    bannerScrollView.contentSize = CGSizeMake(banWidh * (_imageItemsArray.count + 2), banHeight);
    bannerScrollView.delegate = self;
    
    //创建分页视图
    pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(banWidh - 80, banHeight - 30, 50, 20)];
    
    pageCtrl.numberOfPages = _imageItemsArray.count;
    
    bannerScrollView.contentOffset = CGPointMake(banWidh, 0);

    [self addSubview:pageCtrl];

}


- (void)layoutSubviews
{
    if (_imageItemsArray.count > 0) {
    
        [self createBannerViews];
    }
    else{
        
        [self removeFromSuperview];
    }
}

//重新加载数据
-(void)reloadData:(NSArray *)imageItemsArray
{
    _imageItemsArray = imageItemsArray;
        
    [self layoutSubviews];

}

//时间定时器调用，切换图片
- (void)chageImage
{
    NSInteger index = pageCtrl.currentPage + 2;
    
    if (index == _imageItemsArray.count+1) {
        index = 1;
    }
    pageCtrl.currentPage = index;

    [bannerScrollView setContentOffset:CGPointMake(index * banWidh, 0) animated:YES];
}

//点击图片触发事件
- (void)imgAction:(UIControl *)sender
{
    if ([self.delegate respondsToSelector:@selector(indexBanner:imageSelectedAtIndex:)]) {
    
        [self.delegate indexBanner:self imageSelectedAtIndex:sender.tag - 100];
    }
}

#pragma -scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/banWidh - 1;
    
    if (index < _imageItemsArray.count) {
        
        pageCtrl.currentPage = index;
    }
    else if(index < 0)
    {
        pageCtrl.currentPage = _imageItemsArray.count;
        bannerScrollView.contentOffset = CGPointMake(_imageItemsArray.count * banWidh, 0);
    }
    else
    {
        pageCtrl.currentPage = 0;
        bannerScrollView.contentOffset = CGPointMake(banWidh, 0);
        
    }
    
    [_imageChageTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:changeImageTime]];
    
}

@end
