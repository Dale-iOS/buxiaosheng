//
//  LLNetWorkTools.m
//  ReactiveCocoaStudy
//
//  Created by 周尊贤 on 2017/11/13.
//  Copyright © 2017年 周尊贤. All rights reserved.
//

#import "LLNetWorkTools.h"

@interface LLNetWorkTools()
@property (nonatomic,copy) NSDictionary * tempParam;

@property (nonatomic,copy) NSString * tempUrlString;
@end
@implementation LLNetWorkTools


+(instancetype)shareTools {
    static dispatch_once_t onceToken;
    static LLNetWorkTools *tools;
    dispatch_once(&onceToken, ^{
        tools = [[self alloc]init];
    });
    return tools;
}

-(void )POSTWithSucces:(success)successResult error:(error)errorResult {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    //请求序列化器
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //解析序列化器
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //配置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
   [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
        [manager POST:self.tempUrlString parameters:self.tempParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successResult(responseObject);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorResult(error);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        }];
}
//上传图片
-(void )POSTPhotosWithArray:(NSArray *)photosArray Succes:(success)successResult error:(error)errorResult {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    //请求序列化器
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //解析序列化器
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //配置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    NSString * requsetURL = [NSString stringWithFormat:@"%@%@?",BXSBaseURL,@"file/imageUpload.do"];
    
    [manager POST:requsetURL parameters:self.tempParam constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        if (photosArray.count) {
            UIImage *image = photosArray.firstObject;
            
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            NSInteger tMB = (imageData.length/1024)/1024;
            
            //这里取到imageData，判断lin长度大于
            //继续切割
            if (tMB > 2.0 && tMB <= 4.0) {
                imageData = UIImageJPEGRepresentation(image, 0.2);
            }
            
            if (tMB > 4.0) {
                imageData = UIImageJPEGRepresentation(image, 0.1);
            }
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
        }
//        // 这里的_photoArr是你存放图片的数组
//        for (int i = 0; i < photosArray.count; i++) {
//            
//            UIImage *image = photosArray[i];
//            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
//            
//            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//            // 要解决此问题，
//            // 可以在上传时使用当前的系统事件作为文件名
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
//            /*
//             *该方法的参数
//             1. appendPartWithFileData：要上传的照片[二进制流]
//             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//             3. fileName：要保存在服务器上的文件名
//             4. mimeType：上传的文件的类型
//             */
//            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"]; //
//        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"progress is %@",uploadProgress);
            
        });
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successResult(responseObject);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorResult(error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;

    }];
}

-(void )GETWithSucces:(success)successResult error:(error)errorResult {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf8" forHTTPHeaderField:@"Content-Type"];
    //请求序列化器
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    //解析序列化器
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //配置超时时长
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 15.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
    //创建一个信号量
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    });
    
        [manager GET:self.tempUrlString parameters:self.tempParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            successResult(responseObject);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorResult(error);
             [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        }];
    
}

-(void)setDownloadWithTaskUrl:(NSString *)downURL saveName:(NSString *)filePathName downLoadBlock:(DownLoadBlock) block {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:downURL]];
    //默认配置
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURLSessionDownloadTask * downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        ;
        dispatch_async(dispatch_get_main_queue(), ^{
           // [MBProgressHUD getHUDProgress].progress = downloadProgress.fractionCompleted;
            //[SVProgressHUD showProgress:downloadProgress.fractionCompleted status:@"下载中..."];
        });
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        NSString *cachesPath  = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        //NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        cachesPath = [cachesPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",filePathName]];
        return [NSURL fileURLWithPath:cachesPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           // [SVProgressHUD dismiss];
        });
        block([filePath path]);
    }];
    //启动下载
    [downloadTask resume];

}

-(void)getNetWorkStatus{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy= [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch(status)
        {
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWWAN------");
                
              self.status = AFNetworkReachabilityStatusReachableViaWWAN;
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                
                NSLog(@"-------AFNetworkReachabilityStatusReachableViaWIFI------");
                
                 self.status = AFNetworkReachabilityStatusReachableViaWiFi;
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
               self.status = AFNetworkReachabilityStatusNotReachable;
                
                break;
            case AFNetworkReachabilityStatusUnknown:
                
                NSLog(@"-------AFNetworkReachabilityStatusNotReachable------");
                 self.status = AFNetworkReachabilityStatusUnknown;
                break;
                
            default:
                
                break;
                
        }
    }];
    [manager.reachabilityManager  startMonitoring];
    
}


-(LLNetWorkTools *(^)(NSDictionary *))param {
    
    return ^id (NSDictionary * param) {
        self.tempParam  = param;
        return self;
    };
}
-(LLNetWorkTools *(^)(NSString *))urlStr {
    
    return ^id (NSString * urlString) {
        self.tempUrlString = urlString;
        return self;
    };
}
@end
