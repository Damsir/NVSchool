//
//  LeftSortsViewController.h
//  LGDeckViewController
//
//  Created by jamie on 15/3/31.
//  Copyright (c) 2015年 Jamie-Ling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
@protocol  leftSortchangDataDelegate
-(void)changeDataWith:(NSString*)categoryId;
@end
@interface LeftSortsViewController : UIViewController
@property (nonatomic,assign) id<leftSortchangDataDelegate>delegate;
@end
