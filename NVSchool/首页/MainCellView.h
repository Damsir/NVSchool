//
//  MainCellView.h
//  NVSchool
//
//  Created by qianfeng on 15/10/8.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol  MainCellPushDelegate
-(void)pushToViewControll :(UIViewController*)ViewCont;
@end

@interface MainCellView : UICollectionViewCell

@property(nonatomic,assign) int index;
@property(nonatomic,assign) id<MainCellPushDelegate>delegare;
@end
