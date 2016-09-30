//
//  LogViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "LogViewController.h"
#import "UserManager.h"
#import "RegisterViewController.h"
#import "UIImageView+AFNetworking.h"
#import "NormalRegistVC.h"
@interface LogViewController ()<UITextFieldDelegate>
{
    __weak IBOutlet UIScrollView *scrollVi;
    __weak IBOutlet UIImageView *imageVi;
    __weak IBOutlet UITextField *nameText;
    __weak IBOutlet UITextField *secretText;
    __weak IBOutlet UIButton *forgetButton;
    __weak IBOutlet UIButton *registButton;
    __weak IBOutlet UIButton *logInButton;
    __weak IBOutlet UIButton *phoneButton;
    __weak IBOutlet UIButton *weiboButton;
    __weak IBOutlet UIButton *QQBUtton;
    __weak IBOutlet UIButton *weixinButton;
    __weak IBOutlet UIButton *changeButton;
}
@end

@implementation LogViewController

-(void)viewWillLayoutSubviews
{
    scrollVi.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49);
    scrollVi.contentSize = CGSizeMake(self.view.frame.size.width, 667);
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
    nameText.text = [defaults objectForKey:@"newName"];
    secretText.text = [defaults objectForKey:@"newPassWord"];
    secretText.secureTextEntry = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_background"]];
    scrollVi.bounces = NO;
    scrollVi.showsVerticalScrollIndicator = NO;
    scrollVi.showsHorizontalScrollIndicator = NO;
    scrollVi.contentSize = CGSizeMake(self.view.frame.size.width, 667);
    backImage.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    [self.view addSubview:backImage];
    [self.view sendSubviewToBack:backImage];
    
    [imageVi setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/14/27/31/36Y58PICxFK_1024.jpg"]];
    
    nameText.returnKeyType =UIReturnKeyDone;
    secretText.returnKeyType = UIReturnKeyDone;

    [self setPreference];
}
//按钮添加点击事件
-(void)setPreference
{
    imageVi.backgroundColor = [UIColor whiteColor];
    [changeButton addTarget: self action:@selector(changeButton:) forControlEvents:UIControlEventTouchUpInside];
    [logInButton addTarget:self action:@selector(LogInAndSetInformation) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton addTarget:self action:@selector(phoneLogin) forControlEvents:UIControlEventTouchUpInside];
    [registButton addTarget:self action:@selector(normalRegist) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark---/按钮功能实现函数
//切换明文密文
-(void)changeButton:(UIButton *)btn
{
    if (secretText.secureTextEntry) {
    [btn setTitle:@"明文" forState:UIControlStateNormal];
    secretText.secureTextEntry = NO;
    }
    else
    {
        [btn setTitle:@"密文" forState:UIControlStateNormal];
        secretText.secureTextEntry = YES;
    }
}
//登录
-(void)LogInAndSetInformation
{
    UserManager *userManage =[UserManager shareUserManager];
    NSString *returnMessage =  [userManage loginUserName:nameText.text andPassWord:secretText.text];
    
    //    通过返回信息创建提示alertView
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:returnMessage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
    if ([returnMessage isEqualToString:@"登陆成功"]) {
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nameText.text forKey:@"newName"];
        [defaults setObject:secretText.text forKey:@"newPassWord"];
    [defaults setObject:@"YES" forKey:@"isLogIn"];
    [defaults synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)phoneLogin
{
    RegisterViewController *registVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:registVC animated:YES];
}
// 正常注册
-(void)normalRegist
{
    NormalRegistVC *VC = [[NormalRegistVC alloc] init];
    [self .navigationController pushViewController:VC animated:NO];
    
}
#pragma mark---UITextFiledDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController.navigationBar setTranslucent:YES];
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
