//
//  LLNetWorkTools.h
//  ReactiveCocoaStudy
//
//  Created by 周尊贤 on 2017/11/13.
//  Copyright © 2017年 周尊贤. All rights reserved.
//
typedef void(^success)(id);
typedef void(^error)(NSError*);
typedef void(^DownLoadBlock)(NSString * filePath);
#import <Foundation/Foundation.h>

#define LLNetWork [LLNetWorkTools shareTools]

@interface LLNetWorkTools : NSObject


+(instancetype)shareTools;

/// 参数
- (LLNetWorkTools *(^)(NSDictionary * param)) param;
/// 链接
- (LLNetWorkTools *(^)(NSString * urlStr)) urlStr;

-(void)POSTWithSucces:(success)successResult error:(error)errorResult;

-(void)GETWithSucces:(success)successResult error:(error)errorResult;

//上传图片
-(void)POSTPhotosWithArray:(NSArray *)photosArray Succes:(success)successResult error:(error)errorResult;

-(void)setDownloadWithTaskUrl:(NSString *)downURL saveName:(NSString *)filePathName downLoadBlock:(DownLoadBlock) block;

@property (nonatomic,assign) AFNetworkReachabilityStatus  status;

-(void)getNetWorkStatus;


@end
