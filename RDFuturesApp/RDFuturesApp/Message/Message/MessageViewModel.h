//
//  MessageViewModel.h
//  RDFuturesApp
//
//  Created by user on 17/5/11.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface MessageViewModel : BaseViewModel
@property(nonatomic,strong)RACSubject * refreshUI;//刷新UI
@property(nonatomic,strong)RACSubject * refreshTable;//刷新UI
@property(nonatomic,strong)RACSubject * cellClickSubject;
@property(nonatomic,strong)RACCommand * reloadDataCommand;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end
