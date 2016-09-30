//
//  MainCollectionReusableView.h
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadDetailViewController.h"
@protocol  headDetailPushDelegate <NSObject>
-(void)pushToViewControll :(UIViewController*)ViewCont;
@end
@interface MainCollectionReusableView : UICollectionReusableView
@property(nonatomic,weak) IBOutlet UIScrollView *scroll;
@property(nonatomic,assign) id<headDetailPushDelegate>delegate;
@end
