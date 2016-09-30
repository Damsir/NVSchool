//
//  MainHeadView.h
//  NVSchool
//
//  Created by qianfeng on 15/10/7.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodDetaiData.h"
@protocol  MainHeadViewDelegate <NSObject>
-(void)pushToViewControll :(UIViewController*)ViewCont;
@end
@interface MainHeadView : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollVi;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *place;
@property (weak, nonatomic) IBOutlet UIImageView *imageVi;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *cheat;
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UILabel *successLab;
@property (weak, nonatomic) IBOutlet UILabel *comLab;
@property (weak, nonatomic) IBOutlet UILabel *goodLab;
@property (weak, nonatomic) IBOutlet UILabel *normalLab;
@property (weak, nonatomic) IBOutlet UILabel *badLab;
-(void)setUIWith:(GoodDetaiData*)product;
@property(nonatomic,assign)id<MainHeadViewDelegate>delegate;
@end
