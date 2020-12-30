# I. Import SDK
## Copy the EaperSdk.framework to your project directory
Set Deployment Target to 9.0 in TARGETS

Configuration SDK path

# II.Permission Request

## Add the following two permissions info.plist the project file

Before calling the SDK, you need to check if the Bluetooth switch is on, if there is no need to guide the user to 

# III. SDK interface calls

## init SDK
Note: Add initialization SDK, to the Application onCreate method
```
2.[EPaperBlemanage shareInstance]init];
```
## close SDK
Call the following interface to log out of the application
```
2.[EPaperBlemanage shareInstance]destroy];
```

## Log Switch
The SDK log switch can be turned on in debug mode to see more log information to help locate the problem quickly. it is recommended to turn off the log switch in release mode.
```
2.[EPaperBlemanage shareInstance]setDebugMode];
```

## Log Switch
The SDK log switch can be turned on in debug mode to see more log information to help locate the problem quickly. it is recommended to turn off the log switch in release mode.
```
2.[EPaperBlemanage shareInstance]startScanNow：^(NSArray *_Nonnull peripheralArr){
3.// Result Return
4.peripheralArr;
5.}];
```


## Scan device interface calls
Note: Open Bluetooth, search nearby device name "WITSTEC" Bluetooth device, and get MAC address and signal strength

### Start scan
Directions: Start Bluetooth scanning
```
2.[EPaperBlemanage shareInstance]startScanNow：^(NSArray *_Nonnull peripheralArr){
3.// Result Return
4.peripheralArr;
5.}];
```
### ScanData Object Parameter Description

Parameters         | Type          | Note     |
--------------------|------------------|-----------------------|
mac | String   | Bluetooth mac address  |
name       | String  | Bluetooth Device Name   |
rssi  | string      | Equipment signal values     |
peripheral      | CBPeripheral  | Bluetooth Connection Object    |

Method returns without result


### Stop scan]

Description: Stop searching for nearby devices, no longer return scan results,

```
1.// Stop scanning
2.[EPaperBlemanage shareInstance]stopCycleScan];]
```

## Connection Device Interface Call

Description: Connect the device, get the device details, disconnect, check if connected, reconnect.

### Connection Device

Description: Enter the mac address to connect the device, and the device details will be returned after the connection device is successful.

```
[EPaperBlemanage shareInstance]Connection：self.peripheral ConnectionChange：^(NSString *_Nonnull status){

// Connection Status Return

} ConnectionError：^(NSString *_Nonnull errorCode){

// Error Code Return

} ConnectionSuccess：^(Deviceinfo *_Nonnull mag){

// Successful Connection Device Information Return

}];
```
The state StatusCode callback in the void onConnectionChange (statusCode) method

State code        | Note         |
--------------------|------------------|
CONNECTION_START | Connection equipment  |
CONNECTION_SUCCESS      | Device connection successfully  | 
CONNECTION_GET_MSG_START  | Equipment information is being obtained     | 
CONNECTION_GET_MSG_SUCCESS     | Access to device information  |


The state ErrorCode callback in the void onConnectionError (errorCode) method

State code        | Note         |
--------------------|------------------|
ERROR_BLE_CONNECTION_TIMEOUT | Connection Device Timeout  |
ERROR_CONNECTION_GET_DEVICE_MSG_TIMEOUT     | Failed to obtain device information  | 

void onConnectionSuccess description of object parameters in DeviceInfo callback method

Parameters         | Type          | Note     |
--------------------|------------------|-----------------------|
name | NSString  | Bluetooth Device Name  |
version      | NSString | Device Firmware Version  |
power | Int     | Percentage of surplus equipment     |
DeviceType     | NSString  | Type of equipment size  |

### Disconnect Device connection

Description: Disconnect device connection no return, need to reconnect after disconnection.

```
1.// Disconnect
2.[EPaperBlemanage shareInstance]disconnect];]
```

### Get device connection state
```
5.// Connection Status BOOL isConnection =[ EPaperBlemanage shareInstance]isConnection];]
```

## Reconnect device

Description: The Bluetooth connection object returned when the peripheral( scans the device), reconnects to the device.

```
3.// Reconnect
4.[EPaperBlemanage shareInstance]connect Ag：peripheral]];
```

##

## Send Image to device interface
Description: connect the device to send the Image to the electronic price tag, after the Image is sent, the electronic price tag shows the Image content, please make sure the battery power is more than 30% before sending.

```
[[EPaperBlemanage shareInstance]SendImageToDevice:self.peripheral Type:DEVICE_042  ShowImage:renderImg  Success:^(NSString * _Nonnull successCode) {
         //SendSuccess

} Fail:^(NSString * _Nonnull errorCode) {
         
}];
```

### DeviceType enumeration object description

Parameters | Note         |
--------------------|------------------|
DEVICE_015 | 1.5 inch equipment  |
DEVICE_021 | 2.13 inch equipment | 
DEVICE_029 | 2.9 inch equipment  | 
DEVICE_042     | 4.2 inch equipment  |
DEVICE_075    |  7.5 inch equipment |

### Image sending status callback:





### SendError ： send failed error code
State code        | Note         |
--------------------|------------------|
ERROR_TEMPLATE_SEND_TIMEOUT | Send template picture timeout |



## Status Code and Error Code
### StatusCode status tables

State value       | Note       |
--------------------|------------------|
 CONNECTION_START | Connection equipment |
CONNECTION_SUCCESS | Connection device successfully |
CONNECTION_GET_MSG_START | Equipment information is being obtained |
 CONNECTION_GET_MSG_SUCCESS | Access to device information |
 IMAGE_START_SEND | Start sending templates to electronic price tag devices |
 IMAGE_SEND_LOADING | A template is being sent to an electronic price tag device |
 IMAGE_SEND_SUCCESS | Send template to electronic price tag device successfully |
 IMAGE_REFRESH_DEVICE|Refresh the electronic tag template image' |
 IMAGE_REFRESH_DEVICE_SUCCESS|Refresh the electronic tag template picture |
   
   
## E rrorCode Error Error Code Matching Table


State value       | Note       |
--------------------|------------------|

 ERROR_BLE_CONNECTION_TIMEOUT | Connection Device Timeout |
 
ERROR_CONNECTION_GET_DEVICE_MSG_TIMEOUT | Gets device information timeout |

ERROR_TEMPLATE_SEND_TIMEOUT | Send template images to electronic price tag device timeout |


### Error Code 

State value       | Note       |
--------------------|------------------|
  FORMAT_ERROR| Incorrect picture size |
ERROR_TEMPLATE_SEND_TIMEOUT | Send template images to electronic price tag device timeout |


###  About Device id (It is obtained by scanning the barcode on the back of the device)  to MacAddress 

for example :This is Deviceid “2758007B” Its corresponding MACaddress is
“57:54:27:58:00:7B” 

## New attribute
```
[EPaperBlemanage shareInstance].IsOpenLog = false;

```


### description
1. IsOpenLog = false   
Turn off debug log

2. IsOpenLog = true

Open debug log
