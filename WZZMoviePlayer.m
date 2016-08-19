//
//  WZZMoviePlayer.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/16.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#define PATH1 @"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"
#define PATH2 @"http://115.159.1.248:56666/zhang/wyzc.mp4"

#import "WZZMoviePlayer.h"

#import <AVFoundation/AVFoundation.h>
@interface WZZMoviePlayer ()
@property (strong,nonatomic) AVPlayer * player;
@property (strong,nonatomic) AVPlayerLayer * movieView;
@property (strong,nonatomic) AVPlayerItem * item;
@end

@implementation WZZMoviePlayer

-(AVPlayerItem *)item {
    if (_item == nil) {
        _item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:PATH1]];
    }
    return _item;
}
-(AVPlayer *)player {
    if (_player == nil) {
        //NSURL *URL = [NSURL URLWithString:PATH1];
        _player = [AVPlayer playerWithPlayerItem:self.item];
    }
    return _player;
}
-(AVPlayerLayer *)movieView {
    if (_movieView == nil) {
        _movieView = [AVPlayerLayer playerLayerWithPlayer:self.player];
        _movieView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 300);
        _movieView.videoGravity = AVLayerVideoGravityResizeAspect;
    }
    return _movieView;
}
- (void)viewDidLoad {
    
   // ijkPlayer
   // ffmpeg
    //MobileVLC
    [super viewDidLoad];
    [self.view.layer addSublayer:self.movieView];
    [self setupUI];
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 60) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
     //CGFloat f= (CGFloat)self.player.currentTime.value/self.player.currentTime.timescale;
       // NSLog(@"%g",f);
    }];
    
    //KVO
    [self.player addObserver:self forKeyPath:@"rate" options:(NSKeyValueObservingOptionNew) context:nil];
}

-(void)setupUI {
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:@[@"播放",@"暂停"]];
    seg.frame = CGRectMake(0, 0, 150, 40);
    seg.center = CGPointMake(self.view.center.x, 400);
    
    [seg addTarget:self action:@selector(segEvent:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
}

-(void)segEvent:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.player play];
            break;
        case 1:
            [self.player pause];
            break;
        default:
            break;
    }
    
//    if (sender.selectedSegmentIndex == 0) {
//        [self.player play];
//    }
//    else if (sender.selectedSegmentIndex == 1) {
//        [self.player pause];
//    }
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGFloat f = (CGFloat)self.item.duration.value/self.item.duration.timescale;
    NSLog(@"%g",f);
}
-(void)dealloc {
    NSLog(@"xiaoshile ");
    [self.player removeObserver:self forKeyPath:@"rate"];
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
