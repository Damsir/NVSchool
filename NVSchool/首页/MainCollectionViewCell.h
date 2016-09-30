//
//  MainCollectionViewCell.h
//  NVSchool
//
//  Created by qianfeng on 15/9/29.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSData.h"

@interface MainCollectionViewCell : UICollectionViewCell
@property(nonatomic,weak) IBOutlet UIImageView *imageVi;
@property(nonatomic,weak) IBOutlet UILabel *nameLab;
@property(nonatomic,weak) IBOutlet UILabel *placeLab;
@property(nonatomic,weak) IBOutlet UILabel *pricrLab;
-(void)SetUIWith :(JSData*)good;
@end
