//
//  NewsViewModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/4/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import "BaseScrollViewModel.h"

@interface NewsViewModel : BaseScrollViewModel

@property(nonatomic,strong) RACSubject * titleClickSubject;//title点击时

@property(nonatomic,strong) RACSubject * didEndScrollSubject;//滚动结束时

@property (nonatomic,strong) RACSubject *cellClickSubject;//cell点击

@property(nonatomic,strong) RACCommand *getFirstDataCommand;
@property(nonatomic,strong) RACSubject *refreshFirstSubject;
@property(nonatomic,strong) NSMutableArray *firstDataArray;

@property(nonatomic,strong) RACCommand *getSecondDataCommand;
@property(nonatomic,strong) RACSubject *refreshSecondSubject;
@property(nonatomic,strong) NSMutableArray *secondDataArray;

@property(nonatomic,strong) RACCommand *getThirdDataCommand;
@property(nonatomic,strong) RACSubject *refreshThirdSubject;
@property(nonatomic,strong) NSMutableArray *thirdDataArray;

@property(nonatomic,strong) RACCommand *getFourthDataCommand;
@property(nonatomic,strong) RACSubject *refreshFourthSubject;
@property(nonatomic,strong) NSMutableArray *fourthDataArray;

@property(nonatomic,strong) RACCommand *getFifthDataCommand;
@property(nonatomic,strong) RACSubject *refreshFifthSubject;
@property(nonatomic,strong) NSMutableArray *fifthDataArray;

@property(nonatomic,strong) RACCommand *getSixthDataCommand;
@property(nonatomic,strong) RACSubject *refreshSixthSubject;
@property(nonatomic,strong) NSMutableArray *sixthDataArray;

@property(nonatomic,strong) RACCommand *getSeventhDataCommand;
@property(nonatomic,strong) RACSubject *refreshSeventhSubject;
@property(nonatomic,strong) NSMutableArray *seventhDataArray;

@property(nonatomic,strong) RACCommand *getEighthDataCommand;
@property(nonatomic,strong) RACSubject *refreshEighthSubject;
@property(nonatomic,strong) NSMutableArray *eighthDataArray;

@end
