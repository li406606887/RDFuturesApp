//
//  WithdrawFundsView.m
//  RDFuturesApp
//
//  Created by user on 17/5/9.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "WithdrawFundsView.h"
#import "MATextFieldTableViewCell.h"
#import "MAChooseTableViewCell.h"
#import "WithdrawFundsViewModel.h"
#import "WithdrawFundsTableViewCell.h"
#import "WithdrawFundsModel.h"


@interface WithdrawFundsView()<UITableViewDelegate,UITableViewDataSource>
/*
 *表格
 **/
@property(nonatomic,strong)UITableView *tableView;
/*
 *viewModel
 **/
@property(nonatomic,strong)WithdrawFundsViewModel *viewModel;
/*
 *脚视图
 **/
@property(nonatomic,strong)UIView *footView;
/*
 *cell title数组
 **/
@property(nonatomic,strong)NSArray *titleArray;
/*
 *提示信息
 **/
@property(nonatomic,strong)UILabel *promptInformation;
/*
 *下一步按钮
 **/
@property(nonatomic,strong)UIButton *nextStep;
/*
 *下一步按钮背景图
 **/
@property(nonatomic,strong)UIImageView *btnImage;
/*
 *模型
 **/
@property(nonatomic,strong)WithdrawFundsModel *model;
/*
 *币种
 **/
@property(nonatomic,strong)NSArray *currencyArray;
/*
 *提取方式
 **/
@property(nonatomic,strong)NSArray *methodArray;
/*
 *收款银行
 **/
@property(nonatomic,strong)NSArray *bankArray;

@end

@implementation WithdrawFundsView

-(void)setupViews{
    [self addSubview:self.tableView];
    [self.footView addSubview:self.btnImage];
    [self.footView addSubview:self.nextStep];
    [self.footView addSubview:self.promptInformation];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    WS(weakself)
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
        
    }];
    
    [self.promptInformation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.footView);
        make.centerX.equalTo(weakSelf.tableView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 200));
    }];
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.promptInformation.mas_bottom);
        make.centerX.equalTo(weakSelf.tableView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
    }];
    [self.btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.promptInformation.mas_bottom);
        make.centerX.equalTo(weakSelf.footView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
    }];
    
    
    [super updateConstraints];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WS(weakself)
    
    switch (indexPath.row) {
        case 0:{
            MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
            cell.title = self.titleArray[indexPath.row];
            
            cell.titleArray = self.currencyArray;
            cell.contentText.text = self.currencyArray[0];
            cell.chooseCellBlock = ^(NSString *value) {
                weakSelf.model.currency = value;//币种
            };
            return cell;
            
        }
            break;
        case 1:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.extractingAmount = value;//提取金额
            };
            return cell;
            
        }
            break;
        case 2: {
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.extractingAmountCapital = value;//提取金额
            };
            return cell;
        }
            break;
        case 3:{
            MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
            cell.title = self.titleArray[indexPath.row];
                       cell.titleArray = self.methodArray;
            cell.contentText.text = self.methodArray[0];
            cell.chooseCellBlock = ^(NSString *value) {
                weakSelf.model.holdBankType = value;//银行类型
                NSIndexPath *indexPath_three = [NSIndexPath indexPathForRow:3 inSection:0];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath_three,nil] withRowAnimation:UITableViewRowAnimationNone];
                NSIndexPath *indexPath_six = [NSIndexPath indexPathForRow:6 inSection:0];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath_six,nil] withRowAnimation:UITableViewRowAnimationNone];
                NSIndexPath *indexPath_seven = [NSIndexPath indexPathForRow:7 inSection:0];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath_seven,nil] withRowAnimation:UITableViewRowAnimationNone];
            };
            return cell;
            
        }
            break;
            
        case 4:{
            if([self.model.holdBankType isEqualToString:@"0"]){
                MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
                cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
                cell.titleArray = self.bankArray;
                self.model.receiveBank = self.bankArray[0];
                cell.chooseCellBlock = ^(NSString *value) {
                    weakSelf.model.receiveBank = weakSelf.bankArray[[value intValue]];
                };
                cell.title = self.titleArray[indexPath.row];
                cell.contentText.text = self.bankArray[0];
                return cell;
                
                
            }else{
                MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
                cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
                cell.titleStr = self.titleArray[indexPath.row];
                self.model.receiveBank = @"";
                cell.textfieldPrompt = @"请输入银行名称全称";
                cell.textFieldBlock = ^(NSString *value) {
                    weakSelf.model.receiveBank = value;
                };
                return cell;
            }
        }
            break;
        case 5:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.contentField.keyboardType = UIKeyboardTypeASCIICapable;
            cell.titleStr = self.titleArray[indexPath.row];
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.receiver = value;
            };
            return cell;
            
        }
            break;
        case 6:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.receiveCardNum = value;
            };
            return cell;
            
        }
            break;
        case 7:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            
            cell.textfieldPrompt = [self.model.holdBankType intValue] == 0 ? @"选填":@"必填";
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.bankAddress = value;
            };
            return cell;
            
        }
            break;
        case 8:{
            WithdrawFundsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([WithdrawFundsTableViewCell class])] forIndexPath:indexPath];
            cell.titleStr = self.titleArray[indexPath.row];
            cell.placeholder = [self.model.holdBankType intValue] == 0 ? @"选填":@"必填";
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.interRemittanceCode = value;
            };
            return cell;
            
        }
            break;
            
        default:
            break;
    }
    
    return nil;
}


-(void)nextStepClick{
    
    if (self.model.extractingAmount.length<1) {
        showMassage(@"请填写收款金额")
        return;
    }
    if (self.model.receiveBank.length<1) {
        showMassage(@"请填写银行名称")
        return;
    }
    if (self.model.receiver.length<1) {
        showMassage(@"请填写账户人")
        return;
    }
    if (self.model.receiveCardNum.length<1) {
        showMassage(@"请填写银行账号")
        return;
    }
    if (self.model.extractingAmountCapital.length<1) {
        showMassage(@"请填写大写金额")
        return;
    }
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] init];
    [dataDictionary setObject:[NSString stringWithFormat:@"%d",[self.model.currency intValue]+1] forKey:@"currency"];
    [dataDictionary setObject:self.model.extractingAmount forKey:@"extractingAmount"];
    [dataDictionary setObject:[NSString stringWithFormat:@"%d",[self.model.holdBankType intValue]+1] forKey:@"holdBankType"];
    [dataDictionary setObject:self.bankArray[[self.model.receiveBank intValue]] forKey:@"receiveBank"];
    [dataDictionary setObject:self.model.receiver forKey:@"receiver"];
    [dataDictionary setObject:self.model.receiveCardNum forKey:@"receiveCardNum"];
    [dataDictionary setObject:self.model.extractingAmountCapital forKey:@"extractingAmountCapital"];

    if ([self.model.holdBankType intValue]==1) {
        if (self.model.bankAddress.length<1) {
            showMassage(@"请填写银行地址")
            return;
        }
        if (self.model.interRemittanceCode.length<1) {
            showMassage(@"请填写国际汇款编码")
            return;
        }
        
        [dataDictionary setObject:self.model.bankAddress forKey:@"bankAddress"];
        [dataDictionary setObject:self.model.interRemittanceCode forKey:@"interRemittanceCode"];
    }else{
        if (self.model.bankAddress.length>1) {
            [dataDictionary setObject:self.model.bankAddress forKey:@"bankAddress"];
        }
        if (self.model.interRemittanceCode.length>1) {
            [dataDictionary setObject:self.model.interRemittanceCode forKey:@"interRemittanceCode"];
        }
    }
    
    
    [self.viewModel.sumbitWithdrawFundsCommand execute:dataDictionary];


}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"提款币种",@"提款金额",@"大写金额",@"提取方式",@"银行名称",@"账户人",@"银行账号",@"银行地址",@"国际汇款编码 SWIFT#", nil];
    }
    return _titleArray;
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (WithdrawFundsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    }
    return _footView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = self.footView;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[MAChooseTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])]];
        [_tableView registerClass:[MATextFieldTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])]];
        [_tableView registerClass:[WithdrawFundsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([WithdrawFundsTableViewCell class])]];
        
    }
    return _tableView;
}
-(UIButton *)nextStep{
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextStep setTitle:@"下一步,签字" forState: UIControlStateNormal];
        [_nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextStep addTarget:self action:@selector(nextStepClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextStep;
}
-(UIImageView *)btnImage{
    if (!_btnImage) {
        _btnImage = [[UIImageView alloc] init];
        [_btnImage setImage:[UIImage imageNamed:@"b_btn"]];
    }
    return _btnImage;
}
-(WithdrawFundsModel *)model{
    if (!_model) {
        _model = [[WithdrawFundsModel alloc] init];
        _model.currency = @"0";
        _model.holdBankType = @"0";
        _model.receiveBank = self.bankArray[0];
        
    }
    return _model;
}
-(NSArray *)bankArray{
    if (!_bankArray) {
        _bankArray = [NSArray arrayWithObjects:@"中國銀行(香港)",@"交通銀行(香港)",@"招商银行(香港分行)",@"東亞銀行",@"中國建設銀行(亞洲)",@"集友銀行",@"創興銀行有限公司",@"花旗銀行",@"中信銀行国际",@"星展銀行(香港)",@"恆生銀行",@"匯豐銀行",@"中國工商亞洲銀行",@"南洋商業銀行",@"澳洲銀行",@"上海商業銀行",@"渣打銀行",@"永隆銀行",nil];
    }
    return _bankArray;
}
-(NSArray *)methodArray{
    if (!_methodArray) {
        _methodArray = [NSArray arrayWithObjects:@"香港本地银行",@"海外银行", nil];
    }
    return _methodArray;
}
-(NSArray *)currencyArray{
    if (!_currencyArray) {
        _currencyArray = [NSArray arrayWithObjects:@"港币",@"美元",@"人民币",@"欧元",@"英镑", nil];
    }
    return _currencyArray;
}
-(UILabel *)promptInformation{
    if (!_promptInformation) {
        _promptInformation = [[UILabel alloc] init];
        _promptInformation.font = [UIFont rdSystemFontOfSize:fifteenFontSize];
        _promptInformation.text = @"声明：\n银行费用：从此笔提款中扣除(*)如上述收款银行账户并非开户时指定之银行账户，本人/本公司同意承担任何可能因此提款，而引致之争议、损失、责任及有关风险。\n#本地银行&海外电汇转账收费按各银行标准收取# \n*确保银行账户可接收币种*\n公司截止的时间为每天中午 12:00 正，中午 12:00 正后收到的提款指示将在下个工作日执行。";
        _promptInformation.numberOfLines = 0;
    }
    return _promptInformation;
}
@end
