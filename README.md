# Bridge for SMSSDK
In this document ,I will tell you the  bridge method to import the SMSSDK that was completed by objective-c language. Before this, I think that you have also know  the method to import the SMSSDK, if no, the other document is right for you firstly. It’s link is:[Document of importing the SMSSDK](https://github.com/MobClub/SMSSDK-for-iOS/blob/master/README.md).

##Pre-preparation work：
1. the SDK that had downloaded ([Download the SMSSDK](http://www.mob.com/#/downloadDetail/SMS/ios)) and unzip it,when you unzip it ,it's like this:

![Snip20170525_60.png](http://upload-images.jianshu.io/upload_images/4131265-e6a95e82b977bd69.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  
  As shown in the figure,it's contains three parties:
  
> * SMSSDK. Including static libraries and local files.When used directly to this folder into the project.
> * Required. Dependency of SMSSDK.
> * SMSSDKUI. If you want to use it, drag SMSSDKUI.xcodeproj to your project directly.

2. Had gotten the appKey and appSerect 

> * if you don’t have the appKey and appSerect,please get it from detail document : [ Document for getting appkey and appSerect](http://wiki.mob.com/ui集成/)

# Now ,it's the show time:

## Step1:Drag the Folder named "SDK" to your project directly

### Attention:
when drag the SDK to your project ,you must select “Create groups ” button
 
## Step2: Add libraries
 
Required:
> * libz.dylib
> * libstdc++.dylib

## Step3: setup the header file and then setting the bridge

![](http://ww2.sinaimg.cn/mw690/9fbf66d3gw1f6r04q9i1ij20ke0ed40n.jpg)

![](http://ww2.sinaimg.cn/mw690/9fbf66d3gw1f6r04rizlbj213e0san7r.jpg)

## Step4: Open the bridge file ,and then importing the header files,like this:
> * //  SMSSDK-Bridging-Header.h
> * SMS-SDK(swift)
> * //#ifndef SMS_SDK_swift__SMSSDK_Bridging_Header_h
> * //#define SMS_SDK_swift__SMSSDK_Bridging_Header_h

> * //导入SMS-SDK的头文件
> * // #import <SMS_SDK/SMSSDK.h>
> * //关闭访问通讯录需要导入的头文件
> * //#import <SMS_SDK/SMSSDK+ContactFriends.h>

## Step5:  Initializing the SDK

Initializing the SMSSDK with your appekey and appSecret in your Info.plist

![Snip20170525_67.png](http://upload-images.jianshu.io/upload_images/4131265-a57b525679f8810d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## From now ,you can use the SMSSDK API what you want ,liking this:


```
SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber:phone , zone: area, result: { [weak self](error) in
                
                if let _ = error
                {
                    print("-------> %@",error!)
                }
                else
                {
                    print("-------> 获取短信验证码成功")
                }

```

