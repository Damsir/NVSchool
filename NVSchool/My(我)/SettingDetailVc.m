//
//  SettingDetailVc.m
//  NVSchool
//
//  Created by qianfeng on 15/10/13.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "SettingDetailVc.h"
#import "PersonMessageView.h"
#import "takePhoto.h"
#import "UserManager.h"
@interface SettingDetailVc ()<UITextFieldDelegate>
{
//    判断是第几个cell
    
    int count ;
    UIImage *imagePhoto;
}
@end

@implementation SettingDetailVc
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.2];
    [self setNavigation];
    [self chooseMainView];
}

-(void)setNavigation
{
    if (self.indexPath.section==0) {
        self.navigationItem.title  = self.titleArray[self.indexPath.row];
        
        count =(int)self.indexPath.row;
    }
    else
    {
    self.navigationItem.title = self.titleArray[self.indexPath.section*3+self.indexPath.row+3];
        count =(int)self.indexPath.section*3+(int)self.indexPath.row+3;
    }
}
-(void)chooseMainView
{
    if (count ==0) {
        PersonMessageView *view = [[[NSBundle mainBundle]loadNibNamed:@"PersonMessageView" owner:self options:nil]firstObject];
        view.tag = 101;
        view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        设置图片
        
        User *user = [[UserManager shareUserManager].usersArray lastObject];
        [view.photoBtn setBackgroundImage:[UIImage imageWithData:user.imageData] forState:UIControlStateNormal];
//        添加选择照片事件
        [view.changePhoto addTarget:self action:@selector(choosePhoto) forControlEvents:UIControlEventTouchUpInside];
     
        view.nameLab.text = user.userName;
        view.descriptionText.text = user.descriptionStr;

        view.nameLab.delegate = self;
        view.descriptionText.delegate = self;
        
        [self.view addSubview:view];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveUserMessage)];
    }
    else
    {
        self.view.backgroundColor = [UIColor whiteColor];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"功能完善中,可设置资料" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
    }
}
-(void)saveUserMessage
{
 
    User *user= [[UserManager shareUserManager].usersArray lastObject];
    PersonMessageView *view =(PersonMessageView *)[self.view viewWithTag:101];
    user.userName = view.nameLab.text ;
    
    NSData *imageData = UIImageJPEGRepresentation(imagePhoto, 0.7);
    user.imageData = imageData;
    user.descriptionStr = view.descriptionText.text;
}
//选择图像
-(void)choosePhoto
{
    PersonMessageView *view =(PersonMessageView*) [self.view viewWithTag:101];
    [takePhoto sharePicture:^(UIImage *HeadImage){
        
    NSData*imageData= UIImageJPEGRepresentation(HeadImage, 0.7);
    UIImage *image = [UIImage imageWithData:imageData];
    [view.photoBtn setBackgroundImage:image forState:UIControlStateNormal];
        if (HeadImage)
        {
        imagePhoto = HeadImage;
        }
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
