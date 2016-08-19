//
//  WZMakeVideo.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/17.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZMakeVideo.h"

@import MobileCoreServices;
#import <AVFoundation/AVFoundation.h>
@interface WZMakeVideo ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong,nonatomic) AVPlayer * player;
@property (strong,nonatomic) UIImagePickerController * picker;
@end

@implementation WZMakeVideo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI {
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"录制",@"播放"]];
    seg.frame = CGRectMake(0, 0, 100, 40);
    seg.center = CGPointMake(self.view.center.x, 500);
    [seg addTarget:self action:@selector(segEvent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
}


-(UIImagePickerController *)picker {
    if (!_picker) {
        _picker = [[UIImagePickerController alloc]init];
        
        if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
            _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _picker.mediaTypes = @[(NSString *)kUTTypeMovie];
            _picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
            _picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
            _picker.delegate = self;
        }
    }
    
    return _picker;
}


-(void)segEvent:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            // 录制
            
            [self presentViewController:self.picker animated:YES completion:nil];
            break;
        case 1:
            // 播放
            if (self.player != nil) {
                [self.player play];
                
            }
            break;
            
        default:
            break;
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);
    
    NSURL *URL = [info valueForKey:UIImagePickerControllerMediaURL];
    
    NSString *path = [URL path];
    
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
        // 保存
        UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didSaveWithError:withContextInfo:), NULL);
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)video:(NSString *)videoPath didSaveWithError:(NSError *)error withContextInfo:(void *)contextInfo {
    
    if (error) {
        NSLog(@"%@",error);
    }
    else {
        self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:videoPath]];
        AVPlayerLayer *pLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        pLayer.frame = CGRectMake(0, 64, self.view.bounds.size.width, 300);
        pLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        [self.view.layer addSublayer:pLayer];
    }
    
    
}










@end
