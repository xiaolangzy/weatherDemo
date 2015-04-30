//
//  DownloadManager.h
//  weatherDemo
//
//  Created by xiaolang on 15/4/30.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DownloadManager;
@protocol DownloadManagerDelegate <NSObject>
//成功
- (void)downloadFinish:(DownloadManager *)downloader;
//失败
- (void)downloadError:(NSError *)error;
@end

@interface DownloadManager : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURLConnection *_myConnection;
    NSMutableData *_receiveData;
}
@property (nonatomic,readonly)NSMutableData *receiveData;
@property (nonatomic,copy)NSString *urlString;
@property (nonatomic,weak)id<DownloadManagerDelegate> delegate;
@property (nonatomic,assign)NSInteger type;
- (void)downloadWithUrlString:(NSString *)urlString;
- (void)stop;
@end
