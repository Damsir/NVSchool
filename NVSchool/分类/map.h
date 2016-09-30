//
//  map.h
//  NVSchool
//
//  Created by qianfeng on 15/10/14.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
@protocol ViewMapChangeDelegate <NSObject>
-(void)changeCityWith:(CityModel *)city;;
@end
@interface map : UIView
@property(nonatomic,assign) id<ViewMapChangeDelegate>delegate;
-(void)startPosition;
@end
