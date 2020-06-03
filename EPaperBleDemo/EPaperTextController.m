//
//  EPaperTextController.m
//  EPaperBleDemo
//
//  Created by Mocun on 2020/6/1.
//  Copyright © 2020 Mocun. All rights reserved.
//

#import "EPaperTextController.h"
#import <EPaperSDK/EPaperBlemanage.h>
#import <CoreBluetooth/CoreBluetooth.h>


@interface EPaperTextController ()
//@property (nonatomic,weak) NSTimer *codeTimer;
@property (nonatomic,strong) NSArray *scanArr;
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (weak, nonatomic) IBOutlet UIImageView *TempImg;

@end

@implementation EPaperTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"EPaperBleDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view from its nib.
   
}

-(NSArray *)scanArr
{
    if (!_scanArr) {
        self.scanArr = [NSArray array];
    }
    return _scanArr;
}


- (IBAction)ScanBtn:(UIButton *)sender {
   
        [[EPaperBlemanage shareInstance]startScanNow:^(NSArray * _Nonnull peripheralArr) {
         
           self.scanArr = peripheralArr;
          
       }];
}


- (IBAction)Connect:(UIButton *)sender {
   
    
    for (NSDictionary *dic in self.scanArr) {
        //
        if ([dic[@"mac"] isEqualToString:@"57:54:05:2D:00:02"]) {
            self.peripheral = [dic objectForKey:@"peripheral"];
            [[EPaperBlemanage shareInstance]Connection:self.peripheral ConnectionChange:^(NSString * _Nonnull status) {
                
            } ConnectionError:^(NSString * _Nonnull errorCode) {
                
            } ConnectionSuccess:^(Deviceinfo * _Nonnull mag) {
                NSLog(@"%@",mag);
            }];
        }
    }
    
}


- (IBAction)GetInformation:(UIButton *)sender {
    [[EPaperBlemanage shareInstance]refreshTemplate:@{@"id":@"001",@"data":@[@{@"type":@"qrcode",@"content":@"123456"},@{@"type":@"text",@"content":@"You are currently at table"},@{@"type":@"text",@"content":@"Welcome to digital restaurant"},@{@"type":@"text",@"content":@"Our Happy Hour begins at 22:00"},@{@"type":@"text",@"content":@"Average Watiing time is 20 min"}]} CallBackMsg:^(UIImage * _Nonnull templateImg) {
        self.TempImg.image = templateImg;
    }];
}


- (IBAction)SendImage:(UIButton *)sender {
    [[EPaperBlemanage shareInstance]templateSend:self.peripheral InputJson:@{@"id":@"001",@"data":@[@{@"type":@"qrcode",@"content":@"123456"},@{@"type":@"text",@"content":@"You are currently at table"},@{@"type":@"text",@"content":@"Welcome to digital restaurant"},@{@"type":@"text",@"content":@"Our Happy Hour begins at 22:00"},@{@"type":@"text",@"content":@"Average Watiing time is 20 min"}]} StatusChange:^(NSString * _Nonnull status) {
        
    } SendError:^(NSString * _Nonnull errorCode) {
        
    } SendSuccess:^(NSDictionary * _Nonnull jsons) {
        
    }];
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
