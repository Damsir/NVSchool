//
//  RegisterViewController.m
//  NVSchool
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "RegisterViewController.h"
#import "TsetTool.h"
#import "AFNetworking.h"
@interface RegisterViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    __weak IBOutlet UITextField *textFie;
    __weak IBOutlet UIButton *buttonNext;
    __weak IBOutlet UILabel *textLab;
    __weak IBOutlet UILabel *lineLab;
    __weak IBOutlet UILabel *timeLab;
    
    NSTimer *timer;
    UILabel *secondLab;
    UITextField *vaildTextField;
    UIButton *logInBtn;
    UIView *testView;
}
@end

@implementation RegisterViewController


-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBar.translucent =NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    lineLab.backgroundColor = [UIColor blackColor];
    lineLab.alpha = 0.2;
    textFie.delegate = self;
    [buttonNext addTarget:self action:@selector(phoneLogIn) forControlEvents:UIControlEventTouchUpInside];
//    [self creatTestView];
}
-(void)phoneLogIn
{
    // 用工具类验证输入的手机号是否合法
    if(![TsetTool isValidateMobile:textFie.text]){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
        NSDictionary *dic=@{@"command":@"request_sms_verify",@"source":@"android",@"version":@"3.3.2",@"client_id":@"864260027683510_68:df:dd:99:f6:29_com.yunmall.ymctoc",@"phone_num":textFie.text,@"version_code":@"332",@"type":@"1",@"channel":@"5001.1007.1001"};
        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        
        [manager POST:PHONE_LOG parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {

            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:nil];
      
            NSNumber *responseCode=dic[@"errorCode"];
            
            if([responseCode isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                [textFie resignFirstResponder];
                [self creatTestView];
            }
        else {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:[responseCode  stringValue] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
-(void)creatTestView
{
    testView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(textLab.frame)+50, self.view.frame.size.width, 200)];
    testView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];

    [self.view addSubview:testView];
    
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20,20, self.view.frame.size.width-40, 30)];
    lab.text = [NSString stringWithFormat:@"验证码已经发送到手机:%@",textFie.text];
    lab.textColor = [UIColor redColor];
    [testView addSubview:lab];
    
    vaildTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, 230, 40)];
    vaildTextField.backgroundColor = [UIColor whiteColor];
    vaildTextField.borderStyle = UITextBorderStyleRoundedRect;
    vaildTextField.delegate = self;
    [testView addSubview:vaildTextField];
    
    secondLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(vaildTextField.frame)+20, 60,60, 40)];
    secondLab.backgroundColor = [UIColor darkGrayColor];
    [testView addSubview:secondLab];
    
    logInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logInBtn.frame = CGRectMake(120, CGRectGetMaxY(vaildTextField.frame)+10, 60, 40);
    logInBtn.backgroundColor = [UIColor redColor];
    [logInBtn setTitle:@"登录" forState:UIControlStateNormal];
    [logInBtn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    
    [testView addSubview:logInBtn];
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(daojishi) userInfo:nil repeats:YES];
}
- (void)daojishi{
    static int second=120;
    
    if (second >= 0) {
        second--;
        secondLab.text=[NSString stringWithFormat:@"%d秒",second];
    }else{
        secondLab.text=@"超时";
        // 停掉定时器
        [timer invalidate];
        [testView removeFromSuperview];
        timer=nil;
    }
}
-(void)logIn
{
    if(vaildTextField.text.length !=4){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码无效" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else
    {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请设置密码" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        
    alert.alertViewStyle =UIAlertViewStyleSecureTextInput;

    [alert show];
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    UITextField *field=(UITextField *)[alertView textFieldAtIndex:0];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];

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
