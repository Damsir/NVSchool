//
//  MainCollectionReusableView.m
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MainCollectionReusableView.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "HeadBannerData.h"

@interface MainCollectionReusableView()<UIScrollViewDelegate>
{
    UIPageControl *page;
    int count;
    HeadBannerData *headData;
}
@end
@implementation MainCollectionReusableView

- (void)awakeFromNib {
    // Initialization code
    
    [self loadNetData];
    
//    scroll 自动滑动
    count =1;
//    scroll timer函数
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timerGo) userInfo:nil repeats:YES];
    
}
-(void)loadNetData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict =@{@"command":@"get_idle_hot_goods_banner",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"channel":@"5001.1007.1001"};
    [manager POST:MAIN_BANNER parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        headData = [[HeadBannerData alloc]initWithString:operation.responseString error:nil];
        [self setUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}
-(void)setUI
{
    self.userInteractionEnabled = YES;
    self.scroll.contentSize = CGSizeMake(self.frame.size.width*5, self.frame.size.height);
    self.scroll.showsHorizontalScrollIndicator= NO;
    self.scroll.showsVerticalScrollIndicator = NO;
    self.scroll.bounces = NO;
    self.scroll.pagingEnabled = YES;

    page =  [[UIPageControl alloc] initWithFrame:CGRectMake(0, 170, self.frame.size.width, 30)];
    page.userInteractionEnabled = NO;
    page.numberOfPages = 5;
    page.currentPage = 0;
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:page];
    
    bannerData *banData = [[bannerData alloc] init];
    if(headData.bannerList.count)
    {
    banData =headData.bannerList[0];
    }

    for (int i = 0; i<5; i++) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.scroll.frame.size.width*i, 0, self.scroll.frame.size.width, self.scroll.frame.size.height)];
        imageV.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
        [imageV addGestureRecognizer:tap];
        [self.scroll addSubview:imageV];
//        banData.bannerImages.thumb_url
//        banData.shareInfo.image.url;
//        banData.shareInfo.image.thumb_url;
        if (headData.bannerList.count) {
            
        if (i==0) {
        [imageV setImageWithURL:[NSURL URLWithString:banData.bannerImages.url]];
        }
        if (i==1) {
        [imageV setImageWithURL:[NSURL URLWithString:banData.bannerImages.thumb_url]];
        }
        if (i==2) {
        [imageV setImageWithURL:[NSURL URLWithString:banData.shareInfo.image.url]];
        }
        if (i==3) {
        [imageV setImageWithURL:[NSURL URLWithString:banData.bannerImages.url]];
        }
        else
        {
        [imageV setImageWithURL:[NSURL URLWithString:banData.bannerImages.url]];
        }
        }
        else
        {
            [imageV setImage:[UIImage imageNamed:@"NearBy_refued_location"]];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    page.currentPage = self.scroll.contentOffset.x/self.frame.size.width;
    count = (int)page.currentPage;
}
-(void)timerGo
{
    self.scroll.contentOffset= CGPointMake(self.frame.size.width*count, 0);
    count++;
    if (count==5) {
        count=0;
    }
}
-(void)tapImage
{
//    bannerData *banData =headData.bannerList[count];
//    bannerData *banData =headData.bannerList[0];
//    HeadDetailViewController *vc = [[HeadDetailViewController alloc] init];
//    vc.strUrl = banData.shareInfo.url;
//    
//    [self.delegate pushToViewControll:vc];
    
//    NSLog(@"url:%@",banData.shareInfo.url);
}
@end
