//
//  MainCollectionViewCell.m
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "MainCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
@implementation MainCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)SetUIWith :(JSData*)goodData
{
    [self.imageVi setImageWithURL:[NSURL URLWithString:goodData.mainImage.url]];
    self.nameLab.text = goodData.name;
//    self.nameLab.textColor =  [UIColor colorWithRed:14/255.0 green:192/255.0 blue:239/255.0 alpha:1.0];
    self.nameLab.textColor =  [UIColor blackColor];
    self.nameLab.numberOfLines = 2;

    self.placeLab.text =[NSString stringWithFormat:@"￥%@",goodData.price];
    self.placeLab.textColor = [UIColor lightGrayColor];
    
    self.placeLab.font = [UIFont systemFontOfSize:16];
    self.placeLab.textColor = [UIColor colorWithRed:195/255.0 green:34/255.0 blue:117/255.0 alpha:1.0];
    
    NSString *price =goodData.location;
    self.pricrLab.text = price;
  
}
@end
