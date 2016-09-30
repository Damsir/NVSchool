//
//  ScanfQRVC.m
//  NVSchool
//
//  Created by qianfeng on 15/9/30.
//  Copyright (c) 2015年 李辉. All rights reserved.
//

#import "ScanfQRVC.h"

//
#import <AVFoundation/AVFoundation.h>
@interface ScanfQRVC ()<AVCaptureMetadataOutputObjectsDelegate>
// 扫一扫的视频层 和会话对象得用强制引用
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,strong) AVCaptureSession *captureSession;
@end

@implementation ScanfQRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    // 调用扫描功能
    [self scanQR];
}
// 扫一扫功能实现
- (void)scanQR{
    
    //   iOS 7以前二维码扫描用ZXing库

    // 扫一扫功能初始化设备
    // 扫一扫使用视频方式完成图片识别
    AVCaptureDevice *device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error=nil;
    
    // 初始化输入流
    // 传入error 字段判断是否有设备可用
    AVCaptureDeviceInput *input=[AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if(error){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有设备可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    // 初始化输出
    AVCaptureMetadataOutput *output=[[AVCaptureMetadataOutput alloc]init];
    // 一个设置扫描后的代理回调,一个是在主线程上做扫描操作
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 创建一个扫描会话
    AVCaptureSession *session=[[AVCaptureSession alloc]init];
    
    [session addInput:input];
    [session addOutput:output];
    
    // 设置输出流为二维码形式
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    //扫描的视频层
    AVCaptureVideoPreviewLayer *layer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:session];
    
    layer.frame=self.view.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
    [session startRunning];
    
    self.captureSession=session;
    self.previewLayer=layer;
    
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // 得到我的设备扫描结果
    AVMetadataMachineReadableCodeObject *objc=metadataObjects.firstObject;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:objc.stringValue]];
    
    // 停止会话
    if (self.captureSession) {
        [self.captureSession stopRunning];
    }
    // 删除视频层
    if (self.previewLayer) {
        [self.previewLayer removeFromSuperlayer];
    }
    
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
