//
//  WZZPlaySoundEffect.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZPlaySoundEffect.h"

// 30s 支持caf wav
@import AudioToolbox;
@interface WZZPlaySoundEffect ()

@end

@implementation WZZPlaySoundEffect

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filepath = [[NSBundle mainBundle]pathForResource:@"cuckoo.wav" ofType:nil];
    NSURL *URL = [NSURL fileURLWithPath:filepath];
    
    SystemSoundID soundID;// 声明一个变量，用于标记音效
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(URL), &soundID);
    
    //
    // 不带振动
    //AudioServicesPlaySystemSoundWithCompletion(<#SystemSoundID inSystemSoundID#>, <#^(void)inCompletionBlock#>)
   // 带振动
    AudioServicesPlayAlertSoundWithCompletion(soundID, ^{
        NSLog(@"播放完了");
        AudioServicesDisposeSystemSoundID(soundID);// 释放资源
    });

    //AudioServicesPlayAlertSound(soundID);// 带震动
    
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
