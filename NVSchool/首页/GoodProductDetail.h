//
//  GoodProductDetail.h
//  NVSchool
//
//  Created by qianfeng on 15/10/10.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "JSONModel.h"
#import "GoodSellerData.h"
#import "mainImageData.h"
@protocol GoodProductDetail
@end
@interface GoodProductDetail : JSONModel
//brand
@property(nonatomic,copy) NSString *my_id;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *isStorage;
//seller
@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *gender;
@property(nonatomic,copy) NSString *my_description;
@property(nonatomic,copy) NSString *userType;
@property(nonatomic,strong) GoodSellerData *avatar;
@property(nonatomic,copy) NSString *isFollowedByMe;
@property(nonatomic,copy) NSString *isFollowingMe;
@property(nonatomic,strong) GoodSellerData *province;
@property(nonatomic,strong) GoodSellerData *city;
@property(nonatomic,strong) GoodSellerData *district;
@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *bindMobile;
@property(nonatomic,copy) NSString *productCount;
@property(nonatomic,copy) NSString *soldCount;
@property(nonatomic,copy) NSString *evaluatePercent;
@property(nonatomic,strong) GoodSellerData *goodEvaluate;
@property(nonatomic,strong) GoodSellerData *normalEvaluate;
@property(nonatomic,strong) GoodSellerData *badEvaluate;
@property (nonatomic, strong) NSNumber *account;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSNumber *followingMe;
@property (nonatomic, strong) NSNumber *saleOrderCount;
@property (nonatomic, strong) NSNumber *friendNum;
@property (nonatomic, strong) NSNumber *buyCount;
@property (nonatomic, strong) NSNumber *bindWeixin;
@property (nonatomic, strong) NSNumber *my_friend;
@property (nonatomic, strong) NSNumber *shoppingCount;
@property (nonatomic, strong) NSNumber *buyOrderCount;
@property (nonatomic, strong) NSNumber *setPassword;
@property (nonatomic, strong) NSNumber *favCount;
@property (nonatomic, strong) NSNumber *topicCount;
@property (nonatomic, strong) NSNumber *isSyncContacts;
@property (nonatomic, strong) NSNumber *waitSettle;
@property (nonatomic, strong) NSNumber *refundCount;
@property (nonatomic, strong) NSNumber *bindSina;
@property (nonatomic, strong) NSNumber *bindBankAccount;
@property (nonatomic, copy) NSString *fullLocation;
@property (nonatomic, strong) NSNumber *favTopicCount;
@property (nonatomic, strong) NSNumber *syncContacts;
@property (nonatomic, strong) NSNumber *isBindSina;
@property (nonatomic, strong) NSNumber *bindQq;
@property (nonatomic, strong) NSNumber *bindAlipayAccount;
@property (nonatomic, strong) NSNumber *isBindQq;
@property (nonatomic, strong) NSNumber *isBindWeixin;
@property (nonatomic, strong) NSNumber *followedByMe;
//user
//@property(nonatomic,copy) NSString *my_id;
//@property(nonatomic,copy) NSString *name;
//@property(nonatomic,copy) NSString *gender;
//@property(nonatomic,copy) NSString *nickName;
//@property (nonatomic, strong) NSNumber *userType;

//images
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *thumb_url;
@property(nonatomic,copy) NSString *ori_url;
@property(nonatomic,copy) NSString *width;
@property(nonatomic,copy) NSString *height;
@property(nonatomic,copy) NSString *token;
@end
