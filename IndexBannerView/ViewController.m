//
//  ViewController.m
//  IndexBannerView
//
//  Created by mac on 15/5/25.
//  Copyright (c) 2015年 xin. All rights reserved.
//

#import "ViewController.h"

#define kScreenWith [UIScreen mainScreen].bounds.size.width
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    IndexBannerView *bannerView = [[IndexBannerView alloc] initWithFrame:CGRectMake(0, 20, kScreenWith, 150)];
    NSArray *imgArr = @[@"1.png",@"2.png",@"3.png",@"4.png"];

    bannerView.imageItemsArray = imgArr;
    bannerView.delegate = self;
    [self.view addSubview:bannerView];
    
}

- (void)indexBanner:(IndexBannerView *)banner imageSelectedAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
    if (index == 3) {
        
        NSArray *imgArr = @[@"5.png",@"6.png",@"7.png"]; //
        [banner reloadData:imgArr];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
