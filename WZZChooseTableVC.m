//
//  WZZChooseTableVC.m
//  WZZAVFoundationDemo
//
//  Created by 王召洲 on 16/8/15.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "WZZChooseTableVC.h"

#import "WZZPlaySoundEffect.h"
#import "WZZPlayMusic.h"
#import "WZZSoundRecorder.h"
#import "WZZMoviePlayer.h"
#import "WZZGetPhoto.h"
#import "WZZGetPhotoTest.h"
#import "WZMakeVideo.h"
#import "WZZQRCodeScan.h"
#import "WZZQRGenerator.h"
@interface WZZChooseTableVC ()
@property (strong,nonatomic) NSMutableArray * VCArr;
@end

@implementation WZZChooseTableVC

-(NSMutableArray *)VCArr {
    if (_VCArr == nil) {
        _VCArr = [NSMutableArray arrayWithObjects:@"WZZPlaySoundEffect",@"WZZPlayMusic",@"WZZSoundRecorder",@"WZZMoviePlayer",@"WZZGetPhoto",@"WZZGetPhotoTest",@"WZMakeVideo",@"WZZQRCodeScan",@"WZZQRGenerator", nil];
    }
    return _VCArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CC"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.VCArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CC" forIndexPath:indexPath];
    cell.textLabel.text = self.VCArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Class cls = NSClassFromString(self.VCArr[indexPath.row]);
    UIViewController *vc = [[cls alloc]init];
    
    vc.view.backgroundColor = [UIColor colorWithRed: arc4random_uniform(256)/255.0  green:arc4random_uniform(256)/255.0 blue: arc4random_uniform(256)/255.0 alpha:1 ];
    vc.navigationItem.title = self.VCArr[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
