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


@interface EPaperTextController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) NSArray *scanArr;
@property (nonatomic,strong) CBPeripheral *peripheral;
@property (weak, nonatomic) IBOutlet UIImageView *TempImg;
@property (nonatomic , strong)UIImage *SendImg;
@property (weak, nonatomic) IBOutlet UIButton *modelone;
@property (weak, nonatomic) IBOutlet UIButton *modeltwo;
@property (weak, nonatomic) IBOutlet UIButton *modelthree;
@property (nonnull ,strong) NSString *ImageModel;


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
                [[EPaperBlemanage shareInstance]stopCycleScan];
            }];
        }
    }
    
}


- (IBAction)GetInformation:(UIButton *)sender {

    UIAlertController* alert = [[UIAlertController alloc]init];
       
       [alert addAction:[UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil]];
      
       [alert addAction:[UIAlertAction actionWithTitle:@"album" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
           UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
           imagePickerController.delegate = self;
           imagePickerController.allowsEditing = YES;
           //imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
           [self presentViewController:imagePickerController animated:YES completion:^{
           }];
       }]];
       [self presentViewController:alert animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.TempImg.image = image;
    self.SendImg = image;
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

//
- (IBAction)SendImage:(UIButton *)sender {
    
    /**
         send image
         Peripher:Blue
         Type:Device type
         ImageModel:
         ShowImage:youimage
                   
    */
    [[EPaperBlemanage shareInstance]SendImageToDevice:self.peripheral  Type:@"BER042B" ImageModel:self.ImageModel ShowImage:self.SendImg  Success:^(NSString * _Nonnull successCode) {
        //SendSuccess
        
    } Fail:^(NSString * _Nonnull errorCode) {
        
        NSLog(@"%@",errorCode);
        if ([errorCode isEqualToString:@"FORMAT_ERROR"]) {
            UIAlertController* alerts = [UIAlertController alertControllerWithTitle:@"" message:@"Please select a picture of 400x300" preferredStyle:UIAlertControllerStyleAlert];
                  
                  [alerts addAction:[UIAlertAction actionWithTitle:@"Cancle" style:UIAlertActionStyleCancel handler:nil]];
                 
                  [self presentViewController:alerts animated:YES completion:nil];
        }
        
    }];
}
- (IBAction)modelClick:(UIButton *)sender {
    if (sender.tag == 1) {
        self.modelone.selected = YES;
        self.modeltwo.selected = NO;
        self.modelthree.selected = NO;
        self.ImageModel = @"modelone";
    }else if (sender.tag == 2){
        self.modelone.selected = NO;
        self.modeltwo.selected = YES;
        self.modelthree.selected = NO;
        self.ImageModel = @"modeltwo";
    }else if (sender.tag == 3){
        self.modelone.selected = NO;
        self.modeltwo.selected = NO;
        self.modelthree.selected = YES;
        self.ImageModel = @"modelthree";
    }
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
