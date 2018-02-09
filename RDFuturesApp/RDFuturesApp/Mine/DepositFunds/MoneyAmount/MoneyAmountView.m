//
//  MoneyAmountView.m
//  RDFuturesApp
//
//  Created by user on 17/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "MoneyAmountView.h"
#import "MAChooseTableViewCell.h"
#import "MATextFieldTableViewCell.h"
#import "MoneyAmountViewModel.h"

@interface MoneyAmountView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MoneyAmountViewModel *viewModel;

@property(nonatomic,strong)UITableView *table;

@property(nonatomic,strong)UIView *footView;

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)UIButton *nextStep;

@property(nonatomic,strong)UIImageView *btnImage;

@property(nonatomic,strong)NSArray *bankAreaArray;//银行地区

@property(nonatomic,strong)NSArray *bankNameArray;//银行名称


@end


@implementation MoneyAmountView

-(void)setupViews{
    [self addSubview:self.table];
    [self.footView addSubview:self.btnImage];
    [self.footView addSubview:self.nextStep];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MoneyAmountViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)updateConstraints{
    WS(weakself)
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
        
    }];
    [self.footView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    
    [self.nextStep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.footView);
        make.centerX.equalTo(weakSelf.footView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
    }];
    [self.btnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.footView);
        make.centerX.equalTo(weakSelf.footView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
    }];
    
    
    [super updateConstraints];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section; {
    
    return @"选择持有银行卡";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself)
    
    switch (indexPath.row) {
        case 0:{
            MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleArray = self.bankAreaArray;
            cell.chooseCellBlock = ^(NSString *value) {
                weakSelf.model.holdBankType = value;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                self.model.holdBank = @"";
            };
            cell.title = @"银行";
            cell.contentText.text = self.bankAreaArray[0];
            return cell;
            
        }
            break;
        case 1:{
            if([self.model.holdBankType isEqualToString:@"0"]){
                MAChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])] forIndexPath:indexPath];
                cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
                cell.title = self.titleArray[indexPath.row];
                cell.titleArray = self.bankNameArray;
                cell.contentText.text = self.bankNameArray[0];
                self.model.holdBank = self.bankNameArray[0];
                cell.chooseCellBlock = ^(NSString *value) {
                    weakSelf.model.holdBank = self.bankNameArray[[value intValue]];
                };
               
                return cell;
            }else{
                MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
                cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
                cell.titleStr = self.titleArray[indexPath.row];
                cell.textfieldPrompt = @"请输入银行名称全称";
                self.model.holdBank = @"";
                cell.textFieldBlock = ^(NSString *value) {
                    weakSelf.model.holdBank = value;
                };
                return cell;
            }
            
        }
            break;
            
        case 2:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.textfieldPrompt = @"请输入银行账号";
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.holdCardNum = value;
            };
            return cell;
            
        }
            break;
        case 3:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.textfieldPrompt = @"请输入存入金额";
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.depositAmount = value;
            };
            return cell;
            
        }
            break;
        case 4:{
            MATextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])] forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
            cell.titleStr = self.titleArray[indexPath.row];
            cell.textfieldPrompt = @"请输入大写金额";
            cell.textFieldBlock = ^(NSString *value) {
                weakSelf.model.depositAmountCapital = value;
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
    
    if(self.model.holdBank.length<1){
        showMassage(@"请核对您的银行名称");
        return;
    }else if (self.model.holdCardNum.length<1){
        showMassage(@"请输入您持有的银行卡号");
        return;
    }else if (self.model.depositAmount.length<1){
        showMassage(@"请输入您要存入的金额");
        return;
    }else if (self.model.depositAmountCapital.length<1){
        showMassage(@"请输入您要存入的大写金额");
        return;
    }
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:self.model.currency forKey:@"currency"];
    [dic setObject:self.model.depositWays forKey:@"depositWays"];
    [dic setObject:[NSString stringWithFormat:@"%d",[self.model.holdBankType intValue]+1] forKey:@"holdBankType"];
    [dic setObject:self.model.holdBank forKey:@"holdBank"];
    [dic setObject:self.model.holdCardNum forKey:@"holdCardNum"];
    [dic setObject:self.model.depositAmount forKey:@"depositAmount"];
    [dic setObject:self.model.depositAmountCapital forKey:@"depositAmountCapital"];
    [self.viewModel.sumbitMoneyAmountCommand execute:dic];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
-(NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"银行",@"银行名称",@"银行账号",@"存入金额",@"大写金额", nil];
    }
    return _titleArray;
}
-(UITableView *)table{
    if(!_table){
        _table = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _table.dataSource = self;
        _table.delegate = self;
        _table.tableFooterView = self.footView;
        [_table registerClass:[MAChooseTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MAChooseTableViewCell class])]];
        [_table registerClass:[MATextFieldTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MATextFieldTableViewCell class])]];
    }
    return _table;
}
-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] init];
    }
    return _footView;
}
-(UIButton *)nextStep{
    if (!_nextStep) {
        _nextStep = [UIButton buttonWithType:UIButtonTypeSystem];
        [_nextStep setTitle:@"下一步,选择存入银行" forState: UIControlStateNormal];
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

-(NSArray *)bankAreaArray{
    if(!_bankAreaArray){
        _bankAreaArray = [NSArray arrayWithObjects:@"香港本地银行",@"大陆银行",@"海外银行", nil];
    }
    return _bankAreaArray;
}
-(NSArray *)bankNameArray{
    if (!_bankNameArray) {
        _bankNameArray = [NSArray arrayWithObjects:@"中國銀行(香港)",@"交通銀行(香港)",@"招商银行(香港分行)",@"東亞銀行",@"中國建設銀行(亞洲)",@"集友銀行",@"創興銀行有限公司",@"花旗銀行",@"中信銀行国际",@"星展銀行(香港)",@"匯豐銀行",@"中國工商亞洲銀行",@"南洋商業銀行",@"澳洲銀行",@"上海商業銀行",@"渣打銀行",@"永隆銀行", nil];
    }
    return _bankNameArray;
}
-(MAChooseModel *)model{
    if (!_model) {
        _model = [[MAChooseModel alloc] init];
        _model.holdBankType = @"0";
        _model.holdBank = @"中國銀行(香港)";
        
    }
    return _model;
}
@end
