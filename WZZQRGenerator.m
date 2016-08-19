//
//  WZZQRGenerator.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/18.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZQRGenerator.h"

@interface WZZQRGenerator ()

@end

@implementation WZZQRGenerator

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = @"http://QQ12345678890";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    if (filter) {
        [filter setValue:data forKey:@"inputMessage"];
        [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    }
    
    CIImage *imgCI = [filter outputImage];
   // UIImage *img = [UIImage imageWithCIImage:imgCI scale:0.2 orientation:(UIImageOrientationUp)];
    UIImage *img = [self clearCIImage:imgCI withSize:200];
    
    
     UIGraphicsBeginImageContext(img.size);
    
    
    
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    [img drawInRect:rect];
    UIImage *img1 =[UIImage imageNamed:@"1.jpg"];
    
    [img1 drawAtPoint:CGPointMake((img.size.width - img1.size.width)*0.5, (img.size.height - img1.size.height)*0.5)];
    UIImage *rsImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    
    
    
    
    
    
    
    UIImageView *imgV = [[UIImageView alloc]initWithImage:rsImg];
    imgV.center = self.view.center;
    
    
    [self.view addSubview:imgV];
   
    // 获取KVC 可用的key
//    NSArray *arrKeys = [filter inputKeys];
//   NSLog(@"%@",arrKeys);
    
    // 获取可用的name
//   NSArray *arr =[CIFilter filterNamesInCategory:kCICategoryStillImage];
//    NSLog(@"%@",arr);
}
-(UIImage *)clearCIImage:(CIImage *)img withSize:(CGFloat)size {
    //1 获取img的初始大小
    CGRect originRect = img.extent;
    // 获取缩放倍数
    // 2
    CGFloat scale = MIN(size/CGRectGetWidth(originRect), size/CGRectGetHeight(originRect));
   
    //3 还原大小
    CGFloat w = scale *CGRectGetWidth(originRect);
    CGFloat h = scale *CGRectGetHeight(originRect);
    
    // 颜色空间 4
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    // 创建位图上下文 5
    CGContextRef bitmapRef = CGBitmapContextCreate(NULL, w, h, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    
    // CIContext 将CIImage 的信息抽取出来
    CIContext *context = [CIContext contextWithOptions:nil];
    
    // 6 保存图片的所有颜色信息等
    CGImageRef imgRef=[context createCGImage:img fromRect:originRect];
    // 对位图上下文缩放
    CGContextScaleCTM(bitmapRef, scale, scale);
    
    CGContextDrawImage(bitmapRef, originRect, imgRef);
    
    // 7 获取最终生成的图片
   CGImageRef scaledImg= CGBitmapContextCreateImage(bitmapRef);
   
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(imgRef);
    
    UIImage *rsImg = [UIImage imageWithCGImage:scaledImg];

    CGImageRelease(scaledImg);
    
    return rsImg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
