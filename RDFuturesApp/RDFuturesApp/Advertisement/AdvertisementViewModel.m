
//
//  AdvertisementViewModel.m
//  RDFuturesApp
//
//  Created by user on 2017/5/24.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "AdvertisementViewModel.h"
#import "AdvertisementModel.h"

@interface AdvertisementViewModel()
@property(nonatomic,strong)NSMutableData *data;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,assign)long totalLength;
@property(nonatomic,strong)NSDictionary *dicData;
@end


@implementation AdvertisementViewModel
-(void)initialize{
    [self.advertisementCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        self.dicData = (NSMutableDictionary *)x;
        NSURL *url = [NSURL URLWithString:self.dicData[@"image"]];
        [self sendRequest:url];
    }];
}

-(RACCommand *)advertisementCommand{
    if (!_advertisementCommand) {
        _advertisementCommand= [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSDictionary *dataDictionary = [[NSDictionary alloc] init];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postOpenAdvListWithParam:dataDictionary error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([model.State isEqualToString:@"1"]) {
                            
                            [subscriber sendNext:model.Data];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
            
        }];
    }
    return _advertisementCommand;
}
#pragma mark 发送数据请求
-(void)sendRequest:(NSURL *)url{
    if (!url) {
        return;
    }
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15.0f];
    //创建连接
    NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    //启动连接
    [connection start];
}
#pragma mark - 连接代理方法
#pragma mark 开始响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.data=[[NSMutableData alloc]init];
    
    //通过响应头中的Content-Length取得整个响应的总长度
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
    self.totalLength = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
    
    
}

#pragma mark 接收响应数据（根据响应内容的大小此方法会被重复调用）
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //连续接收数据
    [self.data appendData:data];

}

#pragma mark 数据接收完成
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if (self.totalLength<10) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Advertisement_logo"];

    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"advertisement.png"];
    UIImage *image = [UIImage imageWithData:self.data];
    NSData* imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:path atomically:YES];

    [[NSUserDefaults standardUserDefaults] setObject:@"first" forKey:@"firstAdvertisement"];
    [[NSUserDefaults standardUserDefaults] setObject:self.dicData forKey:@"Advertisement_data"];

}

#pragma mark 请求失败
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //如果连接超时或者连接地址错误可能就会报错
    NSLog(@"connection error,error detail is:%@",error.localizedDescription);
}

@end
