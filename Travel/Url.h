//
//  Url.h
//  Travel
//
//  Created by ZKR on 1/28/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#ifndef Travel_Url_h
#define Travel_Url_h


#define PGY_APP_ID  @"c9980b0fb573e7761349895ad3386eaf"

//  服务器推送地址 http://zhangshangxindai.duapp.com/Travel/ios_app/productionPush/push.php
#define UPDATE_URL @"http://zhangshangxindai.duapp.com/Travel/ios_app/ios_update.php"

// IPA下载地址
#define IPAURL @"itms-services://?action=download-manifest&url=https://zhangshangxindai.duapp.com/Travel/ios_app/Travel.plist"

// 上传device token
#define DEVICE_TOKEN @"http://zhangshangxindai.duapp.com/Travel/ios_app/saveAppleDevice.php"

//版本号
#define kVersion_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define kVersionBuild_Coding [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#endif
