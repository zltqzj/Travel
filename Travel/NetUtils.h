//
//  NetUtils.h
//  Travel
//
//  Created by ZKR on 1/28/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^updateBlock)(BOOL update); // 检查更新

// AF
typedef void (^AFCompletionBlock)(id returnData);
typedef void (^AFFailedBlcok)(NSError* error);

// af download
typedef void (^AFDownLoadCompletionBlock)(NSString* localURL);
typedef void (^ADownLoadFailedBlcok)(NSError* error);



@interface NetUtils : NSObject <UIAlertViewDelegate>

@property(nonatomic,weak) AFHTTPRequestOperationManager* manager;


// af
-(void)requestContentWithUrl:(NSString*)urlString para:(NSDictionary*)dict  withSuccessBlock:(AFCompletionBlock) successBlock
            withFailureBlock:(AFFailedBlcok) failureBlock;
//AF： get方法
-(void)GetContentWithUrl:(NSString*)urlString   withSuccessBlock:(AFCompletionBlock) successBlock
        withFailureBlock:(AFFailedBlcok) failureBlock;

// af download方法
-(void)downLoadByaf:(NSString*)url withSuccessBlock:(AFDownLoadCompletionBlock)successBlock withFailureBlock:(ADownLoadFailedBlcok)failureBlock;

-(void)getUpdate:(updateBlock)completonBlock;  // 检查更新


@end
