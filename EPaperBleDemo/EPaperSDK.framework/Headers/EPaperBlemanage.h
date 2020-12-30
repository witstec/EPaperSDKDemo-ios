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
typedef NS_ENUM(NSInteger , DeviceType){
    DEVICE_015 = 0,
    DEVICE_021,
    DEVICE_029,
    DEVICE_042,
    DEVICE_075
};

typedef NS_ENUM (NSInteger , Model){
    Model_one = 0,
    Model_two,
    Model_three
};

@interface EPaperBlemanage : NSObject
@property(nonatomic,strong)CBCentralManager *centralManager;
/**
 Log Switch
 */
@property(nonatomic,assign)BOOL IsOpenLog;

+ (instancetype)shareInstance;

/**
实例化SDK
 init SDK
*/
-(void)EPaperinit;


/**销毁
 close SDK
 */
-(void)destroy;
/**
开始扫描外设
 Start scan
 
@param updatePeripheral 扫描外设回调
 Scan Result Callback
*/
-(void)startScanNow:(void(^)(NSArray*peripheralArr))updatePeripheral;


/**
 停止扫描
 Stop scan
 */
-(void)stopCycleScan;

/**
 连接设备
 Connection Device
 */
-(void)Connection:(CBPeripheral *)peripheral  ConnectionChange:(void(^)(NSString*status))statusCode  ConnectionError:(void(^)(NSString*errorCode))errorCode  ConnectionSuccess :(void(^)(Deviceinfo*mag))msg;

/**
 断开连接
 Disconnect Device connection
 */

-(void)disconnect;

/**
 重新连接
 Reconnect device
 */

-(void)ConnectionAg:(CBPeripheral*)peripheral;

/**
 判断连接状态
 Get device connection state
 */
-(BOOL)isConnection;

/**
 渲染图片
 RenderingImage
 */

-(UIImage*)RenderingImage:(UIImage*)renderImg  ImageModel:(Model)model;


/**图片发送
 Send Image to device interface
 */
-(void)SendImageToDevice:(CBPeripheral *)peripheral  Type:(DeviceType)type  ShowImage:(UIImage*)sendImage Success:(void(^)(NSString*successCode))success Fail:(void(^)(NSString*errorCode))fail;



-(void)writeCharacteristic:(CBPeripheral *)peripheral characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value Success:(void(^)(NSString*Sendsuccess))success;

   
@end

NS_ASSUME_NONNULL_END
