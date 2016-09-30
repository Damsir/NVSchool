//
//  SHeadView.h
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface HeadView : UIView
@property(nonatomic,weak) IBOutlet UIButton *logInButton;
@property(nonatomic,weak) IBOutlet UILabel *name;
@property(nonatomic,weak) IBOutlet UILabel *sucessLab;
@property(nonatomic,weak) IBOutlet UILabel *goodCommentLab;
@property(nonatomic,weak) IBOutlet UILabel *goodLab;
@property(nonatomic,weak) IBOutlet UIImageView *imageVi;
@property(nonatomic,weak) IBOutlet UILabel *normalLab;
@property(nonatomic,weak) IBOutlet UILabel *badLab;
-(void)setPlaceHolderUI;
-(void)setUIWith:(User*)user;
@end
