//
//  SHeadView.m
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setPlaceHolderUI
{
    
}
-(void)setUIWith:(User*)user
{

    
    [self.imageVi setImage:[UIImage imageWithData:user.imageData]];
    self.sucessLab.text = [NSString stringWithFormat:@"%@笔",user.successTime];
    self.goodCommentLab.text = [NSString stringWithFormat:@"%@",user.successTime];
    
    self.goodLab.text = [NSString stringWithFormat:@" %@ 好",user.goodLab];
    self.goodLab.numberOfLines = 2;
    
    self.normalLab.text = [NSString stringWithFormat:@" %@ 中",user.normalLab];
    self.normalLab.numberOfLines = 2;
    
    self.badLab.text = [NSString stringWithFormat:@" %@ 差",user.badLab];
    self.badLab.numberOfLines = 2;
}
@end
