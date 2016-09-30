//
//  SchoolTableCell.m
//  NVSchool
//
//  Created by qianfeng on 15/9/30.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "SchoolTableCell.h"

@implementation SchoolTableCell

- (void)awakeFromNib {
    // Initialization code
}
-(void)setUIWith : (CityModel*)city
{
    [self tapSchoolImage];
    [self.schoolImage setImage:[UIImage imageNamed:@"my_default_avatar"]];
    self.name.text =city.displayName;
    
    float longitude = [city.longitude floatValue];
    float latitude = [city.latitude floatValue];
    
    NSString *str = [NSString stringWithFormat:@"经度:%.f 纬度:%.f",longitude,latitude];
    self.message.text = str;
}
-(void)tapSchoolImage
{
    self.schoolImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellImageDidChoosed :)];
    tapTwo.numberOfTouchesRequired = 1;
    tapTwo.numberOfTapsRequired = 2;
    [self.schoolImage addGestureRecognizer:tapTwo];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// 小分类按钮的选择事件
-(void)cellImageDidChoosed :(UITapGestureRecognizer*)gesture
{
    UIImageView *imageVi = (UIImageView *)gesture.view;
    [self.delegate showBigImage:imageVi.image];
}
@end
