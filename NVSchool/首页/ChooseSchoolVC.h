//
//  ChooseSchoolVC.h
//  NVSchool
//
//  Created by qianfeng on 15/9/30.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "BaseViewController.h"
#import "CityModel.h"
@protocol SchoolVCChangeDelegate <NSObject>
-(void)changeCityWith:(CityModel *)city;;
@end
@interface ChooseSchoolVC : BaseViewController
@property(nonatomic,assign)id<SchoolVCChangeDelegate>delegate;
@end
