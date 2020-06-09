//
//  EPaperBlemanage.h
//  蓝牙开发
//
//  Created by Mocun on 2020/6/2.
//  Copyright © 2020 NIAN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "Deviceinfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface EPaperBlemanage : NSObject
@property(nonatomic,strong)CBCentralManager *centralManager;


+ (instancetype)shareInstance;

/**
实例化SDK
*/
-(void)EPaperinit;
/**
开始扫描外设

@param updatePeripheral 扫描外设回调
*/
-(void)startScanNow:(void(^)(NSArray*peripheralArr))updatePeripheral;


/**
 停止扫描
 */
-(void)stopCycleScan;

/**
 连接设备
 */
-(void)Connection:(CBPeripheral *)peripheral  ConnectionChange:(void(^)(NSString*status))statusCode  ConnectionError:(void(^)(NSString*errorCode))errorCode  ConnectionSuccess :(void(^)(Deviceinfo*mag))msg;

//断开连接

-(void)disconnect;

//重新连接
-(void)ConnectionAg:(CBPeripheral*)peripheral;

//判断连接状态
-(BOOL)isConnection;

//发送命令
-(void)writeCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value;

//预览显示效果
-(void)refreshTemplate:(NSDictionary*)inputStrJson CallBackMsg:(void(^)(UIImage*templateImg))templateImg;

//将图片发送至模版
-(void)templateSend:(CBPeripheral *)peripheral InputJson:(NSDictionary *)json StatusChange:(void(^)(NSString*status))statusCode SendError:(void(^)(NSString*errorCode))errorCode SendSuccess:(void(^)(NSDictionary*jsons))jsons;

//销毁
-(void)destroy;

//图片发送
-(void)SendImageToDevice:(CBPeripheral *)peripheral Type:(NSString*)type ShowImage:(UIImage*)sendImage Success:(void(^)(NSString*successCode))success Fail:(void(^)(NSString*errorCode))fail;
   
@end

NS_ASSUME_NONNULL_END
