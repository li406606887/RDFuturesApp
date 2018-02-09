


//
//  MessageViewModel.m
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MessageViewModel.h"
#import "MessageModel.h"

@implementation MessageViewModel
-(void)initialize{
    WS(weakself)
    [self.reloadDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSDictionary *data = x;
        MessageModel *model = weakSelf.dataArray[1];
        NSString *state =[NSString stringWithFormat:@"%@",data[@"is_new_inform"]];
        if ([state intValue]==1)  {
            model.is_new_inform=YES;
        }
        else{
            model.is_new_inform = NO;
        }
        
        [weakSelf.refreshUI sendNext:x];
    }];
    
}


-(RACSubject *)cellClickSubject{
    if (!_cellClickSubject) {
        
        _cellClickSubject = [RACSubject subject];
        
    }
    return _cellClickSubject;
}
-(RACCommand *)reloadDataCommand{
    if (!_reloadDataCommand) {
        _reloadDataCommand= [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                NSDictionary *dataDictionary = [[NSDictionary alloc] init];
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError *error;
                    RDRequestModel * model = [RDRequest postCheckNewInformWithParam:dataDictionary error:&error];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (error ==nil) {
                            if ([model.State isEqualToString:@"1"]) {
                                [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0]; //清除角标
                                [subscriber sendNext:model.Data];
                            }else{
                                showMassage(model.Message)
                            }
                        }else{
                            [MBProgressHUD showError:promptString];
                        }
                        
                        [subscriber sendCompleted];
                        
                    });
                    
                    
                });
                
                return nil;
            }];
            
        }];
    }
    return _reloadDataCommand;
}
-(RACSubject *)refreshUI{
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
-(RACSubject *)refreshTable{
    if(!_refreshTable){
        _refreshTable = [RACSubject subject];
    }
    return _refreshTable;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        MessageModel *onlineService = [[MessageModel alloc] init];
        onlineService.image = @"item_service";
        onlineService.titleText = @"我的客服";
        onlineService.subtitle = @"最新聊天记录";
        onlineService.is_new_inform = NO;
        
        MessageModel *notice = [[MessageModel alloc] init];
        notice.image = @"Message_RDNotice_icon";
        notice.titleText = @"瑞达通知";
        notice.subtitle = @"最新推送消息和标题";
        notice.is_new_inform = NO;
        
        _dataArray = [NSMutableArray arrayWithObjects:onlineService,notice, nil];
        
    }
    return _dataArray;
}
@end
