//
//  IndexBannerView.h
//  IndexBannerView
//
//  Created by mac on 15/5/25.
//  Copyright (c) 2015年 xin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexBannerDelegate;

@interface IndexBannerView : UIView

@property (nonatomic,strong)NSArray *imageItemsArray; //存放图片名称的数组

@property (nonatomic, weak) id<IndexBannerDelegate>delegate;

- (void)reloadData:(NSArray *)imageItemsArray; //重新加载数据

@end


@protocol IndexBannerDelegate <NSObject>


//点击图片触发事件，index为当前图片index值
- (void)indexBanner:(IndexBannerView *)banner imageSelectedAtIndex:(NSInteger)index;

@end