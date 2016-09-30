//
//  GoodDetailMessageCell.m
//  NVSchool
//
//  Created by qianfeng on 15/10/9.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "GoodDetailMessageCell.h"

@implementation GoodDetailMessageCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setUIWith :(GoodDetaiData *)detailData
{
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.1];
    
    self.pinpaiM.text = detailData.category.name;
    self.pinpaiM.textColor = [UIColor redColor];
    
    self.kucunM.text = detailData.stockCount;
    self.useM.text = detailData.recentcyStr;
    
    self.timeM.text = detailData.updataTime;
    

// 评论部分
    
//    可以通过停靠来设置自变高
    
//    CGFloat h_h =   [GoodDetailMessageCell getHight:detailData.desc andFont:[UIFont systemFontOfSize:17] andWidth:self.frame.size.width-20];
//    self.view3.frame = CGRectMake(0, CGRectGetMaxY(self.view2.frame)+1, self.frame.size.width, 21+h_h) ;
//    self.descriptionM.frame =CGRectMake(10, CGRectGetMaxY(self.descrip.frame), self.descriptionM.frame.size.width, h_h);
    self.descriptionM.numberOfLines = 0;
    self.descriptionM.text = detailData.desc;
}
//获得可变高的高
+(CGFloat)getHight :(NSString *)text andFont :(UIFont*)font andWidth :(CGFloat)width
{
    CGRect frame=[text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :font} context:nil];
    CGFloat height=frame.size.height;
    return height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
