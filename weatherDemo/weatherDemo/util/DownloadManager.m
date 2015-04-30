//
//  DownloadManager.m
//  weatherDemo
//
//  Created by xiaolang on 15/4/30.
//  Copyright (c) 2015年 xiaolang. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager
-(instancetype)init
{
    if (self = [super init]) {
        _receiveData = [NSMutableData data];
    }
    return self;
}

- (void)downloadWithUrlString:(NSString *)urlString
{
    self.urlString = urlString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _myConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receiveData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    if (self.delegate) {
        [self.delegate downloadFinish:self];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.delegate) {
        [self.delegate downloadError:error];
    }
}

-(void)dealloc
{
    [self stop];
}

- (void)stop
{
    [_myConnection cancel];
    _myConnection = nil;
}

@end
