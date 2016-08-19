//
//  WZZGetPhotoTest.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/17.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZGetPhotoTest.h"

@interface WZZGetPhotoTest ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong,nonatomic) UIImageView * imgV;
@end

@implementation WZZGetPhotoTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.imgV.backgroundColor = [UIColor blackColor];
    self.imgV.center =self.view.center;
    self.imgV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.imgV addGestureRecognizer:tap];
    [self.view addSubview:self.imgV];
    
    
}
-(void)tap:(UITapGestureRecognizer *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"隔壁老王友情提醒" message:@"请选择图片" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"从相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
        
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *act3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        // 啥都不干
    }];
    
    [alert addAction:act1];
    [alert addAction:act2];
    [alert addAction:act3];
    
    
    [self presentViewController:alert animated:YES completion:nil];

    
    
    
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    
    self.imgV.image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
