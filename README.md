# IndexBannerView
几句话使用banner，完全解耦，点击事件有代理

 自动滚动，手动滚动都可以

    IndexBannerView *bannerView = [[IndexBannerView alloc] initWithFrame:CGRectMake(0, 20, kScreenWith, 150)];
    NSArray *imgArr = @[@"1.png",@"2.png",@"3.png",@"4.png"];
    bannerView.imageItemsArray = imgArr;
    bannerView.delegate = self;
    [self.view addSubview:bannerView];

 ![image](https://github.com/zuojx1013/IndexBannerView/blob/master/IndexBannerView.gif)
 
