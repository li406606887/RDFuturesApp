//
//  BillViewModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/27.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface BillViewModel : BaseViewModel

@property (nonatomic,strong) RACSubject *cellClick;

@property (nonatomic,strong) RACSubject *refreshUI;

@property (nonatomic,strong) RACSubject *refreshEndSubject;

@property (nonatomic,strong) RACCommand *refreshDataCommand;

@property (nonatomic,strong) RACCommand *nextPageCommand;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end
