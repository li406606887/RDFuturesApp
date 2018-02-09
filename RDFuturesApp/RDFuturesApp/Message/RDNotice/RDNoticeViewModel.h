//
//  RDNoticeViewModel.h
//  RDFuturesApp
//
//  Created by user on 2017/5/12.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "BaseViewModel.h"

@interface RDNoticeViewModel : BaseViewModel
@property(nonatomic,assign)int page;

@property(nonatomic,strong)RACCommand * reloadDataCommand;

@property(nonatomic,strong)NSMutableArray *dateArray;

@property(nonatomic,strong)RACSubject *refreshUI;

@property(nonatomic,strong)RACSubject *cellClickSubject;


@end
