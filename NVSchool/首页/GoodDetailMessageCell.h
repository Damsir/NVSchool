//
//  GoodDetailMessageCell.h
//  NVSchool
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodDetaiData.h"
@interface GoodDetailMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pinpai;
@property (weak, nonatomic) IBOutlet UILabel *pinpaiM;
@property (weak, nonatomic) IBOutlet UILabel *kucun;
@property (weak, nonatomic) IBOutlet UILabel *kucunM;
@property (weak, nonatomic) IBOutlet UILabel *use;
@property (weak, nonatomic) IBOutlet UILabel *useM;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *timeM;
@property (weak, nonatomic) IBOutlet UILabel *descrip;
@property (weak, nonatomic) IBOutlet UILabel *descriptionM;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
-(void)setUIWith :(GoodDetaiData *)detailData;
@end
