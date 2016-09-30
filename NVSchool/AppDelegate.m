//
//  AppDelegate.m
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//
#define USER_INFO @"user.list"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Json.h"
#import "User.h"
#import "UserManager.h"
//分享
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(id)init
{
    if (self = [super init]) {
        self.labArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict=@{@"count":@"30",@"command":@"get_idle_hot_goods_list",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"version_code":@"332",@"last_id":@"0",@"channel":@"5001.1007.1001"};
    [manager POST:MAINURL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Json *jsonData = [[Json alloc] initWithString:operation.responseString error:nil];
        for (int i= 0; i<jsonData.labelList.count; i++) {
            JSData *data = jsonData.labelList[i];
            [self.labArray addObject:data.labelName];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

    [self loadUserList];
    
    //    设置分享的友盟key
    [UMSocialData setAppKey:@"5614e40267e58ed89300425d"];
     return YES;
}
-(void)loadUserList
{
    NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *filePath=[NSString stringWithFormat:@"%@%@",path,USER_INFO];
    
    NSArray *array=[NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    [UserManager shareUserManager].usersArray=[NSMutableArray arrayWithArray:array];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveUserList];
}
-(void)saveUserList
{
    NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *filePath=[NSString stringWithFormat:@"%@%@",path,USER_INFO];
    
    BOOL isSave= [NSKeyedArchiver archiveRootObject:[UserManager shareUserManager].usersArray  toFile:filePath];
    if (isSave) {
        NSLog(@"保存成功");
    }
    else
    {
        NSLog(@"归档失败");
    }
}
@end
