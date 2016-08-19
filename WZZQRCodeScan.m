//
//  WZZQRCodeScan.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/18.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZQRCodeScan.h"


@import CoreMedia;
#import <AVFoundation/AVFoundation.h>

@interface WZZQRCodeScan ()<AVCaptureMetadataOutputObjectsDelegate>
{
    UIView *overLayView;
}
@property (strong,nonatomic) AVCaptureDevice * device;// 代表设备
@property (strong,nonatomic) AVCaptureSession * session;// 会话，用于管理输入输出
@property (strong,nonatomic) AVCaptureDeviceInput * input;// 输入
@property (strong,nonatomic) AVCaptureMetadataOutput * output;// 元数据输出
@property (strong,nonatomic) AVCaptureVideoPreviewLayer * preLayer;// 预览层
@property (weak,nonatomic) UIImageView  * scan;
@end

@implementation WZZQRCodeScan

-(void)setupUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 100, 40);
    btn.center = CGPointMake(self.view.center.x, 500);
    [btn setTitle:@"开始扫描" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)startScan {
    // 开始扫描
    
    //AVCaptureDevice
    //AVCaptureDeviceInput
    //AVCaptureMetadataOutput
    //AVCaptureSession
    //AVCaptureVideoPreviewLayer
    if (self.session) {
        [self.session startRunning];// 开始扫描
        
       [UIView animateWithDuration:3 delay:0 options:(UIViewAnimationOptionRepeat|UIViewAnimationOptionCurveLinear) animations:^{
           
           self.scan.transform = CGAffineTransformMakeTranslation(0, overLayView.bounds.size.height);
           
       } completion:^(BOOL finished) {
           self.scan.transform = CGAffineTransformIdentity;
       }];
    }
    
}
-(void)congfigInputAndOutput {
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];// 获取捕捉设备
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:NULL];
    self.session = [[AVCaptureSession alloc]init];
    
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [self.session canSetSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    // 必须在 添加输出之前将 输入添加进会话
    self.output = [[AVCaptureMetadataOutput alloc]init];
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    // 必须将输出添加之后，再去设置输出的属性
    
    
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    CGFloat W = [UIScreen mainScreen].bounds.size.width;
    CGFloat H = [UIScreen mainScreen].bounds.size.height;
    
    
    self.output.rectOfInterest = CGRectMake(0.25, 0.25, 0.5, 0.5);
    
    self.preLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preLayer.frame = self.view.bounds;
    self.preLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.view.layer addSublayer:self.preLayer];
    
    
    
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0.25*W, 0.25*H, 0.5*W, 0.5*W)];
    //
    //    CAShapeLayer *shape = [CAShapeLayer layer];
    //    shape.path = path.CGPath;
    //    shape.lineWidth = 1;
    //    shape.strokeColor = [UIColor whiteColor].CGColor;
    //    shape.fillColor = [UIColor clearColor].CGColor;
    //    [self.view.layer addSublayer:shape];
    
    overLayView = [[UIView alloc]initWithFrame:CGRectMake(0.25*W, 0.25*H, 0.5*W, 0.3*H)];
    overLayView.backgroundColor = [UIColor clearColor];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0,0.5*W , 0.3*H)];
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    shape.lineWidth = 1;
    shape.strokeColor = [UIColor whiteColor].CGColor;
    shape.fillColor = [UIColor clearColor].CGColor;
    [overLayView.layer addSublayer:shape];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(-1, -1, 15, 15)];
    imgV.image = [UIImage imageNamed:@"ScanQR1"];
    
    UIImageView *imgV2 = [[UIImageView alloc]initWithFrame:CGRectMake(overLayView.bounds.size.width-14, -1, 15, 15)];
    imgV2.image = [UIImage imageNamed:@"ScanQR2"];
    
    UIImageView *imgV3 = [[UIImageView alloc]initWithFrame:CGRectMake(-1, overLayView.bounds.size.height-14, 15, 15)];
    imgV3.image = [UIImage imageNamed:@"ScanQR3"];
    UIImageView *imgV4 = [[UIImageView alloc]initWithFrame:CGRectMake(overLayView.bounds.size.width-14, overLayView.bounds.size.height-14, 15, 15)];
    imgV4.image = [UIImage imageNamed:@"ScanQR4"];
    
    [overLayView addSubview:imgV];
    [overLayView addSubview:imgV2];
    [overLayView addSubview:imgV3];
    [overLayView addSubview:imgV4];
    
    UIImageView *scanLine = [[UIImageView alloc]initWithFrame:CGRectMake(-overLayView.bounds.size.width*0.15, 0, overLayView.bounds.size.width*1.3, 10)];
    scanLine.image = [UIImage imageNamed:@"ff_QRCodeScanLine"];
    scanLine.tag =1;
    [overLayView addSubview:scanLine];
    self.scan = scanLine;
    

    [self.view addSubview:overLayView];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self congfigInputAndOutput];
    [self setupUI];
}

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (metadataObjects && metadataObjects.count) {
        
        AVMetadataMachineReadableCodeObject *metadata = [metadataObjects lastObject];
        // 如果类型是二维码 再结束扫描 并获取二维码代表的值
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            NSLog(@"%@",metadata.stringValue);
            UIImageView *v = [overLayView viewWithTag:1];
            [v removeFromSuperview];
            [self.session stopRunning];
            
        }
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
