//
//  Deviceinfo.h
//  EPaperBleDemo
//
//  Created by Mocun on 2020/6/1.
//  Copyright © 2020 Mocun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Deviceinfo : NSObject
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *version;
@property (nonatomic,assign)int power;
@property (nonatomic,strong)NSString *DeviceType;

@end

NS_ASSUME_NONNULL_END
