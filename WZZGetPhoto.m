//
//  WZZGetPhoto.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/17.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZGetPhoto.h"

@interface WZZGetPhoto ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong,nonatomic) UIImageView * imgV;
@end

@implementation WZZGetPhoto

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

-(void)setupUI {
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"照片",@"相簿",@"相机"]];
    seg.frame = CGRectMake(0, 0, 150, 40);
    seg.center = self.view.center;
    
    [seg addTarget:self action:@selector(segEvent:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:seg];

    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, 300, 200)];
    [self.view addSubview:self.imgV];
    
}

-(void)segEvent :(UISegmentedControl *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    
    //======================================================//
    switch (sender.selectedSegmentIndex) {
        case 0:
            // 照片
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            break;
        case 1:
            // 相簿
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)]) {
                picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            break;
        case 2:
            // 相机
            if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.cameraViewTransform = CGAffineTransformMakeScale(1, 0.5);
                //picker.showsCameraControls = NO;
            }
            break;
        default:
            break;
    }
    //======================================================//
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - delagate  methods


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // 获取照片
    //NSLog(@"%@",info);
    
    UIImage *img = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.imgV.image = img;
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
