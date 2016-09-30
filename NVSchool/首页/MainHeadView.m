//
//  MainHeadView.m
//  NVSchool
//
//  Created by qianfeng on 15/10/7.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MainHeadView.h"
#import "UIImageView+AFNetworking.h"

#import "HeadDetailViewController.h"
#import "sellerData.h"
@interface  MainHeadView()<UIScrollViewDelegate>
{
    UIPageControl *page;
    NSString *userUrl;
    GoodDetaiData *productData;
    UIScrollView *imageScroll ;
}
@end
@implementation MainHeadView

-(void)setUIWith:(GoodDetaiData*)product
{
    productData = product;
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.1];
//    第一栏
    self.title.text = product.name;
    
    self.price.text = [NSString stringWithFormat:@"￥%@",product.price];
    
    self.price.textColor = [UIColor redColor];
    self.oldPrice.text = [NSString stringWithFormat:@"原价:%@",product.oriPrice];
    self.oldPrice.textColor = [UIColor lightGrayColor];
    self.oldPrice.font = [UIFont systemFontOfSize:15];
    
    self.place.text = product.location;
    
    self.time.text = [NSString stringWithFormat:@"浏览数 %@",product.fav];
    
    [self.share setTitle:@" ❤️  收藏" forState:UIControlStateNormal];
    self.share.titleLabel.numberOfLines = 2;
    
//    第二栏 seller
    
    sellerData *sellerDtail = product.seller;
    [self.imageVi setImageWithURL:[NSURL URLWithString:sellerDtail.avatar.url]];
    self.imageVi.layer.cornerRadius = 20 ;
    self.imageVi.clipsToBounds = YES;
    self.imageVi.userInteractionEnabled =YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushToSeller)];
    [self.imageVi addGestureRecognizer:tap];
    userUrl = product.url;
    
    self.name.text = sellerDtail.nickname;
    
    NSArray *imagesArray = product.images;
   
    self.userInteractionEnabled = YES;
    self.scrollVi.contentSize = CGSizeMake(self.scrollVi.frame.size.width*imagesArray.count, self.scrollVi.frame.size.height);
    self.scrollVi.delegate  = self;
    self.scrollVi.showsHorizontalScrollIndicator= NO;
    self.scrollVi.showsVerticalScrollIndicator = NO;
    self.scrollVi.bounces = NO;
    self.scrollVi.pagingEnabled = YES;
    
    page =  [[UIPageControl alloc] initWithFrame:CGRectMake(0, 300, self.frame.size.width, 30)];
    page.userInteractionEnabled = NO;
    page.numberOfPages = imagesArray.count;
    page.currentPage = 0;
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:page];

    for (int i = 0; i<imagesArray.count; i++) {
        GoodProductDetail *images = imagesArray[i];
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollVi.frame.size.width*i, 0, self.scrollVi.frame.size.width, self.scrollVi.frame.size.height)];
        imageV.userInteractionEnabled = YES;
        [imageV setImageWithURL:[NSURL URLWithString:images.url]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)];
        [imageV addGestureRecognizer:tap];
        [self.scrollVi addSubview:imageV];
    }
}
-(void)tapImage
{
     NSArray *imagesArray = productData.images;
    imageScroll = [[UIScrollView alloc]  initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageScroll.backgroundColor = [UIColor lightGrayColor];
    imageScroll.contentSize = CGSizeMake(imageScroll.frame.size.width*imagesArray.count, imageScroll.frame.size.height);
    imageScroll.showsHorizontalScrollIndicator = NO;
    imageScroll.pagingEnabled = YES;
    imageScroll.delegate = self;

    [self addSubview:imageScroll];
    
    [self bringSubviewToFront:imageScroll];
   
    for (int i = 0; i<imagesArray.count; i++) {
        GoodProductDetail *images = imagesArray[i];

        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(imageScroll.frame.size.width*i, 0, imageScroll.frame.size.width, imageScroll.frame.size.height)];
        imageV.userInteractionEnabled = YES;
        [imageV setImageWithURL:[NSURL URLWithString:images.ori_url]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBigImage)];
        [imageV addGestureRecognizer:tap];
        
        [imageScroll addSubview:imageV];
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView ==self.scrollVi) {
    page.currentPage = self.scrollVi.contentOffset.x/self.scrollVi. frame.size.width;
    }
}
-(void)pushToSeller
{
    HeadDetailViewController *vc = [[HeadDetailViewController alloc]init];
    vc.strUrl =userUrl;
    [self.delegate pushToViewControll:vc];
}
-(void)tapBigImage
{
    [imageScroll removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
