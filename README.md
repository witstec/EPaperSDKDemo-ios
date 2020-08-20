# I. Import SDK
## Copy the EaperSdk.framework to your project directory
Set Deployment Target to 9.0 in TARGETS

Configuration SDK path

# II.Application Authority

## Add the following two permissions info.plist the project file

Before calling the SDK, you need to check if the Bluetooth switch is on, if there is no need to guide the user to 

# III. SDK interface calls

## Initialization SDK

```
2.[EPaperBlemanage shareInstance]startScanNow：^(NSArray *_Nonnull peripheralArr){
3.// Result Return
4.peripheralArr;
5.}];
```
## Object parameter description peripheralArr returned data

Parameters         | Type          | Note     |
--------------------|------------------|-----------------------|
mac | String   | Bluetooth mac address  |
name       | String  | Bluetooth Device Name   |
rssi  | string      | Equipment signal values     |
peripheral      | CBPeripheral  | Bluetooth Connection Object    |

## Stop scanning equipment

Note: Stop searching for nearby devices and no longer return scan results

```
1.// Stop scanning
2.[EPaperBlemanage shareInstance]stopCycleScan];]
```

Method returns without result

## Connection Device Interface Call

Description: Connect the device, get the device details, disconnect, check if connected, reconnect.

## Connection equipment

Incoming parameter: Bluetooth connection object returned peripheral( scanning the device)

```
[EPaperBlemanage shareInstance]Connection：self.peripheral ConnectionChange：^(NSString *_Nonnull status){

// Connection Status Return

} ConnectionError：^(NSString *_Nonnull errorCode){

// Error Code Return

} ConnectionSuccess：^(Deviceinfo *_Nonnull mag){

// Successful Connection Device Information Return

}];
```
ConnectionChange ： device connection state returns status returned state

State code        | Note         |
--------------------|------------------|-----------------------|
CONNECTION_START | Connection equipment  |
CONNECTION_SUCCESS      | Device connection successfully  | 
CONNECTION_GET_MSG_START  | Equipment information is being obtained     | 
CONNECTION_GET_MSG_SUCCESS     | Access to device information  |


ConnectionError ： connection failed error code errorCode returned error code

State code        | Note         |
--------------------|------------------|-----------------------|
ERROR_BLE_CONNECTION_TIMEOUT | Connection Device Timeout  |
ERROR_CONNECTION_GET_DEVICE_MSG_TIMEOUT     | Failed to obtain device information  | 

ConnectionSuccess ： device information returned mag returned after successful connection

Parameters         | Type          | Note     |
--------------------|------------------|-----------------------|
name | NSString  | Bluetooth Device Name  |
version      | NSString | Device Firmware Version  |
power | Int     | Percentage of surplus equipment     |
DeviceType     | NSString  | Type of equipment size  |

## Disconnect

Description: Disconnect device connection no return, need to reconnect after disconnection.

```
1.// Disconnect
2.[EPaperBlemanage shareInstance]disconnect];]
```

## Reconnect

Description: The Bluetooth connection object returned when the peripheral( scans the device), reconnects to the device.

```
3.// Reconnect
4.[EPaperBlemanage shareInstance]connect Ag：peripheral]];
```

## Gets the device connection state
```
5.// Connection Status BOOL isConnection =[ EPaperBlemanage shareInstance]isConnection];]
```

## Send template images to device interface calls

Description: Because it is custom version SDK, so built-in template files, no need to import template files. For ease of understanding, the following is an example diagram of the display effect of a built-in template file, with five input boxes, for one QR code, four text. All you need to do is pass in the values in the input box as Json.

<img src="http://api.witstec.com/Public/img/2020052601.jpg" width = 200 height = 400 />

## Json Format Description
###Json field description: red font is immutable value, green font is changeable value. and the values inside are sequential, data the first data corresponds to the QR code data, the second input corresponds to the first text input box,... from top to bottom, and so on.

Json data examples

```
{
"id"："001",

"data"：[{
"type"："qrcode",
"content"：" the first input box for the value of the QR code"
},{
"type"："text",
"content"：" the value of the first text in the second input box"
},{
"type"："text",
"content"：" the value of the second text in the third input box"
},{
"type"："text",
"content"：" the value of the third text in the fourth input box"
},{
"type"："text",
"content"：" the value of the fourth text in the fifth input box"
}]
}
```

Json parameters         | Type          | Note     |
--------------------|------------------|-----------------------|
Id | String   | Fixed to 001  |
Mac       | String  | Equipment mac address   |
type  | string      | Type of input box (" qrcode "," textqrcode ")    |
context      | String | Value of input box   |


## Device Send Template Picture

Description: send the template to the electronic price tag, after the template is sent, the electronic price tag shows the template content, please make sure the battery power is more than 30% before sending.

**Interface calls incoming parameters: peripheral ,json data**

```
1.[EPaperBlemanage shareInstance]templateSend：self.peripheral InputJson：json StatusChange：^(NSString *_Nonnull status){
2.// Send Status Return
3.} SendError：^(NSString *_Nonnull errorCode){
4.// Send error code back
5.} SendSuccess：^(NSDictionary *_Nonnull jsons){
6.// json sent successfully
7.}];
```

### StatusChange ： sent procedure state returns status return value

State code        | Note         |
--------------------|------------------|-----------------------|
TEMPLATE_START_SEND | start sending template images to the device  |
TEMPLATE_SEND_LOADING     | Is sending a template image to the device  | 
TEMPLATE_SEND_SUCCESS  | Send template pictures to device successfully     | 
TEMPLATE_REFRESH_DEVICE  | Refresh electronic price tag screen content  |
TEMPLATE_REFRESH_DEVICE_SUCCESS     | Electronic price tag  |

### SendError ： send failed error code
State code        | Note         |
--------------------|------------------|-----------------------|
ERROR_TEMPLATE_SEND_TIMEOUT | Send template picture timeout |

## Preview Template Picture

Description: This interface is called when the value entering the sending template interface or the input box changes (json the value changes) and previews the template display effect

**Incoming parameter: json generated by input box values**

```
1.[EPaperBlemanage shareInstance]refreshTemplate：json CallBackMsg：^(UIImage *_Nonnull templateImg){
2.// Return the result picture and load it with UIimageview when you need to display the preview effect
3.self.TempImg.image =templateImg;
4.}];
```

## Status Code and Error Code
### StatusCode status tables

State value       | Note       |
--------------------|------------------|-----------------------|
 CONNECTION_START | Connection equipment |
CONNECTION_SUCCESS | Connection device successfully |
CONNECTION_GET_MSG_START | Equipment information is being obtained |
 CONNECTION_GET_MSG_SUCCESS | Access to device information |
 TEMPLATE_START_SEND | Start sending templates to electronic price tag devices |
  TEMPLATE_SEND_LOADING | A template is being sent to an electronic price tag device |
  TEMPLATE_SEND_SUCCESS | Send template to electronic price tag device successfully |
   TEMPLATE_REFRESH_DEVICE|Refresh the electronic tag template image' |
   TEMPLATE_REFRESH_DEVICE_SUCCESS|Refresh the electronic tag template picture |
   
   
## E rrorCode Error Error Code Matching Table


State value       | Note       |
--------------------|------------------|-----------------------|

 ERROR_BLE_CONNECTION_TIMEOUT | Connection Device Timeout |
 
ERROR_CONNECTION_GET_DEVICE_MSG_TIMEOUT | Gets device information timeout |

ERROR_TEMPLATE_SEND_TIMEOUT | Send template images to electronic price tag device timeout |

## newly added:

### Send custom picture API

### Description: Send a  picture you want to the device

**Incoming parameters**

1. peripheral 
2. Type:Model of  your device , If it is 2.9-inch model, it is BEB029B  ,If it is 4.2-inch model, it is BER042B 
3. sendimg: If the model is BEB029B, choose 296x128 size picture,If the model is BEB042B, choose a 400x300 size picture
1. ImageModel:
 Define the parameters of the picture display effect, currently 3 types are defined
 
 modelone: ​​The color scale of the picture is biased towards black and white, and the red area is less displayed
 
 modeltwo: a display effect between modelone and modelthree
 
 modelthree: The display effect is brighter, the red area is displayed more, and the skin color can be displayed more naturally


```
[[EPaperBlemanage shareInstance]SendImageToDevice:self.peripheral  Type:@"BER042B" ImageModel:"modelone" ShowImage:self.SendImg  Success:^(NSString * _Nonnull successCode) {
           //SendSuccess
        
       } Fail:^(NSString * _Nonnull errorCode) {
           
         
           if ([errorCode isEqualToString:@"FORMAT_ERROR"]) {
           }
           
       }];
```
### Error Code 

State value       | Note       |
--------------------|------------------|-----------------------|
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