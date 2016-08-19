//
//  WZZPlayMusic.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/15.
//  Copyright © 2016年 wyzc. All rights reserved.
/*
 媒体资源路径：本地或者网络
 创建播放器
 创建UI界面来控制播放
 */

#import "WZZPlayMusic.h"

#define PATH @"a.mp3"
@import AVFoundation;
@interface WZZPlayMusic ()
@property (strong,nonatomic) AVAudioPlayer * player;
@property (strong,nonatomic) NSURL * URL;
@property (strong,nonatomic) NSTimer * timer;
@property (strong,nonatomic) AVURLAsset * asset;
@property (weak,nonatomic) UIImageView  * artwork;
@end

@implementation WZZPlayMusic

-(NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
        _timer.fireDate = [NSDate distantFuture];
    }
    return _timer;
}
// 获取音频信息
-(AVURLAsset *)asset {
    if (!_asset) {
        _asset = [AVURLAsset assetWithURL:self.URL];
        
        for (AVMetadataItem *item in _asset.metadata) {
            
            if ([item.commonKey isEqualToString:@"artwork"]) {
                UIImage *img = [UIImage imageWithData:(NSData*)item.value];
                UIImageView *imgV = [[UIImageView alloc]initWithImage:img];
                imgV.center = CGPointMake(self.view.center.x, 200);
                imgV.layer.cornerRadius = img.size.width/2;
                imgV.layer.borderWidth = 2;
                imgV.layer.borderColor = [UIColor blackColor].CGColor;
                imgV.layer.masksToBounds = YES;
                [self.view addSubview:imgV];
                self.artwork = imgV;
            }
        }
        
    }
    return _asset;
}


-(NSURL *)URL {
    if (_URL == nil) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:PATH ofType:nil];
        _URL = [NSURL fileURLWithPath:filepath];
    }
    return _URL;
}
-(AVAudioPlayer *)player {
    if (_player == nil) {
        _player = [[AVAudioPlayer  alloc]initWithContentsOfURL:self.URL error:NULL];
        [_player prepareToPlay];
        _player.meteringEnabled = YES;// 获取实时播放进度必须设置为YES
    }
    return _player;
}

- (void)setupUI {
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"播放",@"暂停",@"停止"]];
    seg.frame = CGRectMake(0, 0, 150, 40);
    seg.center = self.view.center;
    [seg addTarget:self action:@selector(segEvent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    for (int i = 0; i < 3; i++) {
        
        UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width*0.6, 10)];
        
        slider.center = CGPointMake(self.view.center.x, self.view.center.y + 100 + i * 40);
        slider.tag = i+1;
        [slider addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:slider];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        label.center =CGPointMake(70, self.view.center.y + 100 + i * 40);
        [self.view addSubview:label];
        
        switch (i) {
            case 0:
                label.text = @"进度";
                slider.maximumValue = self.player.duration;// 获取音频时长
                break;
            case 1:
                label.text = @"音量";
                slider.value = self.player.volume;
                slider.maximumValue = 2;
                break;
            case 2:
                label.text = @"声道";
                slider.value = self.player.pan;
                slider.minimumValue = -1;
                slider.maximumValue = 1;
                break;
            default:
                break;
        }
        
        
    }
}
-(void)sliderEvent:(UISlider *)sender {
    switch (sender.tag) {
        case 1:
            self.player.currentTime = sender.value;
            break;
        case 2:
            self.player.volume = sender.value;
            break;
        case 3:
            self.player.pan = sender.value;
            break;
        default:
            break;
    }
}
-(void)segEvent:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.player play];
            self.timer.fireDate = [NSDate distantPast];
            break;
        case 1:
            [self.player pause];
            self.timer.fireDate = [NSDate distantFuture];
            break;
        case 2:
            [self.player stop];
            self.player.currentTime = 0;
            self.timer.fireDate = [NSDate distantFuture];
            break;
            
        default:
            break;
    }
}
-(void)update {
    //
    [self.player updateMeters];// 跟新进度
    
    UISlider *slider = [self.view viewWithTag:1];
    slider.value = self.player.currentTime;
    
    self.artwork.transform = CGAffineTransformRotate(self.artwork.transform, 0.3 *M_PI/180);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self asset];
}

-(void)viewWillDisappear:(BOOL)animated {
    self.player = nil;
}

@end
