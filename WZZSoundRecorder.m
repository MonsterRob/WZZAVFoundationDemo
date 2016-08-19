//
//  WZZSoundRecorder.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZSoundRecorder.h"

#import <AVFoundation/AVFoundation.h>
@interface WZZSoundRecorder ()
@property (strong,nonatomic) AVAudioPlayer * player;// 播放设备
@property (strong,nonatomic) AVAudioRecorder * recorder;// 录音设备
@property (strong,nonatomic) NSURL * URL;// 保存录音文件
@property (strong,nonatomic) NSTimer * timer;



@end

@implementation WZZSoundRecorder

-(NSURL *)URL {
    if (_URL == nil) {
        // 获取文件目录路径
        NSString *dirPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        // 创建文件路径
        NSString *filepath = [dirPath stringByAppendingPathComponent:@"my.caf"];
        _URL = [NSURL fileURLWithPath:filepath];
        NSLog(@"%@",filepath);
    }
    return _URL;
}


-(AVAudioPlayer *)player {
    if (_player == nil) {
        
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:self.URL error:NULL];
        
        
        [_player prepareToPlay];
    }
    return _player;
}

-(AVAudioRecorder *)recorder {
    if (_recorder == nil) {
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:NULL];
        [session setActive:YES error:NULL];
    
        NSMutableDictionary *settings = [NSMutableDictionary dictionary];
        // 设置录音格式
        [settings setValue:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
        // 是否采用浮点取样
        [settings setValue:@(YES) forKey:AVLinearPCMIsFloatKey];
        // 采样深度
        [settings setValue:@(8) forKey:AVLinearPCMBitDepthKey];
        // 采样频率
        [settings setValue:@(44100) forKey:AVSampleRateKey];
        // 双声道
        [settings setValue:@(2) forKey:AVNumberOfChannelsKey];
        _recorder = [[AVAudioRecorder alloc]initWithURL:self.URL settings:settings error:NULL];
        
        _recorder.meteringEnabled = YES;
        
    }
    return _recorder;
}

-(NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateP) userInfo:nil repeats:YES];
        _timer.fireDate = [NSDate distantFuture];
    }
    return _timer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    NSLog(@"%@",self.recorder.channelAssignments);

}

-(void)setupUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 150, 50);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor purpleColor];
    [btn setTitle:@"开始录音" forState:UIControlStateNormal];
    [btn setTitle:@"停止并播放" forState:UIControlStateHighlighted];
    // 手指落下 开始录音
    [btn addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchDown];
    // 手指抬起 开始播放
    [btn addTarget:self action:@selector(stopAndPlay) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}
-(void)startRecord {
    //[self.recorder prepareToRecord];
    [self.recorder record];
    self.timer.fireDate = [NSDate distantPast];
}
-(void)stopAndPlay {
    
    [self.recorder stop];
    self.timer.fireDate = [NSDate distantFuture];
    
    [self.player play];
}
-(void)updateP {
    [self.recorder updateMeters];
    
    CGFloat f = [self.recorder peakPowerForChannel:1];
    NSLog(@"%g",f);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
