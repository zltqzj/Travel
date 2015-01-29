//
//  NetUtils.m
//  Travel
//
//  Created by ZKR on 1/28/15.
//  Copyright (c) 2015 ZKR. All rights reserved.
//

#import "NetUtils.h"
#import "Url.h"
#import "BlocksKit+UIKit.h"
#import "UIAlertView+BlocksKit.h"
@implementation NetUtils 

// af post方法
-(void)requestContentWithUrl:(NSString*)urlString para:(NSDictionary*)dict withSuccessBlock:(AFCompletionBlock)successBlock withFailureBlock:(AFFailedBlcok)failureBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];;
    _manager = manager;
    
    NSString* url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    //  NSLog(@"%@",url);
    [_manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        // NSLog(@"%@",operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",operation.responseString);
        NSLog(@"Error: %@", error);
        failureBlock(error);
    }];
    
    
}

//AF： get方法
-(void)GetContentWithUrl:(NSString*)urlString   withSuccessBlock:(AFCompletionBlock) successBlock
        withFailureBlock:(AFFailedBlcok) failureBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];;

    _manager = manager;
    NSString* url = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
}

// af download GIF 方法
-(void)downLoadByaf:(NSString*)url withSuccessBlock:(AFDownLoadCompletionBlock)successBlock withFailureBlock:(ADownLoadFailedBlcok)failureBlock  {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    
//    NSURL *URL = [NSURL URLWithString:url];
//    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//    NSString* base64 = [NSString stringWithFormat:@"%@%@",@"TuliPS14port20",CURRENT_USER_EMAIL];
//    base64 = [NSString encodeBase64String:base64];
//    [_manager.requestSerializer setValue:base64 forHTTPHeaderField:@"Authorization"];
//    
//    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        
//        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        if (error) {
//            failureBlock(error);
//        }
//        NSLog(@"%@",[response suggestedFilename]);
//        NSLog(@"File downloaded to: %@", filePath.path); // 绝对路径
//        successBlock([response suggestedFilename]);
//    }];
//    [downloadTask resume];
}

// 上传图片
-(void)uploadImage:(NSString*)url dict:(NSDictionary*)dict imageData:(NSData*)imageData fileName:(NSString*)fileName type:(NSString*)type{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData  appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:type];
//        NSLog(@"%@",formData);
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
//        FileManager* file_manager = [[FileManager alloc] init];
//        // 原来的绝对路径
//        NSString* originPath = [file_manager createSubPath:@"mine" subPath:@"activity_image"] ;
//        originPath = [NSString stringWithFormat:@"%@/%@",originPath,fileName];
//        
//        //现在的绝对路径
//        NSString* subPath = [file_manager createSubPath:@"mine" subPath:@"display_image"] ;//fileName_ex:path Sub_Path:@"activity_image"];
//        subPath  =[NSString stringWithFormat:@"%@/%@",subPath,fileName];
//        [file_manager removeItemAtPath:subPath error:nil];
//        [file_manager moveItemAtPath:originPath toPath:subPath error:nil];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error);
//    }];
}

-(void)getUpdate:(updateBlock)completonBlock  // 检查更新
{
    __unsafe_unretained NetUtils *netUtil = self;// 防止循环应用
    
    [netUtil GetContentWithUrl:UPDATE_URL withSuccessBlock:^(id returnData) {
       
        if ([returnData[@"verCode"] isEqualToString:kVersion_Coding]) {
            // 不用更新
            
        }
        else{
            // 提示更新
            UIAlertView *testView = [[UIAlertView alloc] bk_initWithTitle:@"有新版本" message:returnData[@"content"]];
            
            [testView bk_addButtonWithTitle:@"取消" handler:^{
            }];
            [testView bk_addButtonWithTitle:@"更新" handler:^{
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:IPAURL]];

            }];
            [testView show];
            
        }
     
    } withFailureBlock:^(NSError *error) {
        //NSLog(@"%@",error);
    }];
}



-(void)dealloc{
    NSLog(@"网络工具释放");
}
@end
