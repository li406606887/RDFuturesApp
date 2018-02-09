//
//  OtherInforViewController.m
//  RDFuturesApp
//
//  Created by user on 17/3/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OtherInforViewController.h"
#import "OtherInforCell.h"
#import "OtherHeadView.h"
#import "OtherClickModel.h"
#import "ChooseBankView.h"
#import "OtherInforClauseView.h"

@interface OtherInforViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *headViewArray;//头部VIEW数组
@property (nonatomic,strong)UIView *footView;
@property (nonatomic,strong)OtherInforClauseView *clauseView;
@property (nonatomic,strong)NSArray *titleArray;//section 标题数组
@property (nonatomic,strong)NSMutableArray *stateArray;//0 开 1关;
@property (nonatomic,strong)NSMutableArray *sectionModelArray;//section模型数组
@property (nonatomic,strong)NSMutableArray *cellTextArray;//cell 文本控件数组
@property (nonatomic,strong)NSArray *cellTitleArray;//cell 标题数组
@property (nonatomic,strong)NSArray *cellStyleArray;//cell 类型数组

@property (nonatomic,strong)NSArray *sectionParameterArray;// 头部参数数组
@property (nonatomic,strong)NSArray *relationshipIsChooseArray;//是否和瑞达国际有关系（0：不是，1：是）
@property (nonatomic,strong)NSArray *participantIsChooseArray;//是否是参与者（0：不是 1：是）
@property (nonatomic,strong)NSArray *membersIsChooseArray;//是否是其他交易所的会员（0：不是 1：是）
@property (nonatomic,strong)NSArray *employeesIsChooseArray;//是否是任何监管机构的雇员（0：不是 1：是）


@property (nonatomic,weak) UIButton *sumbit;
@end

@implementation OtherInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"声明";
    
    [self.view addSubview:self.tableView];
}

#pragma mark -下一步
- (void)sumbitBtnClick {
    
    if (self.sumbit.backgroundColor==[UIColor lightGrayColor]) {
        return;
    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    for (int i=0; i<self.stateArray.count; i++) {
        
        [dic setObject:self.stateArray[i] forKey:self.sectionParameterArray[i]];
        
    }
    //第1个
    if ([self.stateArray[0] isEqualToString:@"1"]){
        NSMutableArray *array = self.cellTextArray[0];
        for (int i=0; i<array.count; i++) {
            UITextField *textField = array[i];

            if (textField.text.length<1) {
                showMassage(@"资料不全,请补齐")
                return;
            }
            [dic setObject:textField.text forKey:self.relationshipIsChooseArray[i]];
            
        }
    }
    //第2个
    if ([self.stateArray[1] isEqualToString:@"1"]){
        NSMutableArray *array = self.cellTextArray[1];
        UITextField *textField = array[0];
        [dic setObject:textField.text forKey:@"participant_data"];
        
    }
    //第3个头部为yes参数
    
    //第4个
    if ([self.stateArray[3] isEqualToString:@"1"]){
        NSMutableArray *array = self.cellTextArray[3];
        UITextField *textField = array[0];
        [dic setObject:textField.text forKey:@"exchange_name"];
        
    }
    //第5个
    
    if ([self.stateArray[4] isEqualToString:@"1"]){
        NSMutableArray *array = self.cellTextArray[3];
        UITextField *textField = array[0];
        [dic setObject:textField.text forKey:@"hired_regulators"];
    }
    //第6个
    
    
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error;
        RDRequestModel * model = [RDRequest postOtherDataInfoWithParam:dic
                                                                 error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                if ([model.State isEqualToString:@"1"]){
                    [self puchWitnessCity];
                }else{
                    showMassage(model.Message);
                }
                
            }else{
                [MBProgressHUD showError:promptString];
            }
            
        });
    });
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    CGSize size =  [UILabel textForFont:14 andMAXSize:CGSizeMake(VIEW_WIDTH-65, MAXFLOAT) andText:self.titleArray[section]];
    CGFloat height  = size.height+15;
    
    OtherHeadView *headView = [[OtherHeadView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, height)];
    headView.title = self.titleArray[section];
    [headView setBackgroundColor:[UIColor whiteColor]];
    headView.tag = section;
    
    OtherClickModel  *sectionModel = self.sectionModelArray[section];
    BOOL  state = sectionModel.on_Off;
    headView.selectButton.selected = state;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(headViewClick:)];
    [headView addGestureRecognizer:tap];
    if (self.headViewArray.count<7) {
        [self.headViewArray addObject:headView];
    }
    return headView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section==6){
        return 60.f;
        
    }else{
        return 0.5f;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGSize size =  [UILabel textForFont:14 andMAXSize:CGSizeMake(VIEW_WIDTH-65, MAXFLOAT) andText:self.titleArray[section]];
    CGFloat height  = size.height+15;
    
    return  height ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    OtherClickModel  *sectionModel =self.sectionModelArray[section];
    
    return sectionModel.on_Off ? 0:sectionModel.cellStyleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",(long)indexPath.section,(long)indexPath.row];
    OtherClickModel  *sectionModel = self.sectionModelArray[indexPath.section];
    OtherCellModel *cellModel = sectionModel.cellStyleArray[indexPath.row];
    
    OtherInforSecondCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell2 == nil) {
        cell2 = [[OtherInforSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell2.title.text = cellModel.cellTitle;
    NSMutableArray *array = self.cellTextArray[indexPath.section];
    [array replaceObjectAtIndex:indexPath.row withObject:cell2.context];
    return cell2;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.section ==0) {
    //        if (indexPath.row==2) {
    //            ChooseBankView * chooseView = [[ChooseBankView alloc] initWithNoBgViewDataArray:@[@"请选择",@"身份证",@"护照或其他"]];
    //            [chooseView show];
    //
    //            chooseView.callBackBlock = ^(NSString * tStr){
    //                //赋值
    //                NSArray *array = [NSArray arrayWithObjects:@"请选择",@"身份证",@"护照或其他", nil];
    //                NSMutableArray *textArray = self.cellTextArray[0];
    //                UILabel *title = textArray[2];
    //                title.text = array[[tStr intValue]];
    //            };
    //        }
    //    }
}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"本人和瑞达国际金融控股有限公司或其联营公司的董事或雇员没有任何关系;",@"本人不是香港交易所之交易所参与者或证监会或瑞达国际金融控股有限公司之董事、雇员或认可人士;",@"本人是是帐户的最终及唯一实益拥有人,并完全负责为该(等)帐户运作所发出的一切指示;",@"本人不属于任何一间商品交易所的会员;",@"本人不是任何监管机构的雇员;",@"本人同意“该等条款”,瑞达国际金融控股有限公司可使用及/或转送本人/吾等的个人资料作出直接促销;", nil ];
    }
    
    return _titleArray;
}

-(NSMutableArray *)sectionModelArray{
    if (!_sectionModelArray){
        _sectionModelArray = [[NSMutableArray alloc] init];
        for (int i=0; i<6; i++) {
            
            OtherClickModel  *sectionModel = [[OtherClickModel alloc] init];
            NSArray *titleArray = self.cellTitleArray[i];
            NSArray *styleArray = self.cellStyleArray[i];
            
            for(int b = 0 ;b < titleArray.count ; b++){
                OtherCellModel *cellModel = [[OtherCellModel alloc] init];
                cellModel.cellTitle = titleArray[b];
                cellModel.cellStyle = styleArray[b];
                [sectionModel.cellStyleArray addObject:cellModel];
            }
            sectionModel.on_Off = YES;
            if (i==0) {
                sectionModel.head_on_Off = NO;
            }
            [_sectionModelArray addObject:sectionModel];
            
        }
        
        
    }
    return _sectionModelArray;
}

-(void)headViewClick:(UITapGestureRecognizer*)tap{
    
    long index  = tap.view.tag;
    
    OtherHeadView *headView =(OtherHeadView *)tap.view;
    
    headView.selectButton.selected = !headView.selectButton.selected;
    OtherClickModel  *sectionModel = self.sectionModelArray[index];
    
    
    self.stateArray[index] = [NSString stringWithFormat:@"%d",!headView.selectButton.selected];
    sectionModel.on_Off = headView.selectButton.selected;
    if (index==2||index==5) {
        if (headView.selectButton.selected==NO) {
            UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"非常抱歉，根据您所披露的资料，瑞达暂不支持为您开通相关账户。如有疑问，请拨打电话(00852) 2534 2000联系客服。" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:index];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self changeViewStyle:index];
    
}
-(void)changeViewStyle:(long)index{
    
    BOOL state = NO;
    for (int i=1; i<self.stateArray.count; i++) {
        if (i==2||i==5) {
            NSString *stateStr = self.stateArray[i];
            if ([stateStr isEqualToString:@"1"]) {
                state = YES;
                break;
            }
        }
       
    }
    if(state==YES){
        
        [self.sumbit setBackgroundColor:[UIColor lightGrayColor]];
    }else{
        [self.sumbit setBackgroundColor:[UIColor clearColor]];
        
        
    }
}



//头部View 数组
-(NSMutableArray *)headViewArray{
    if (!_headViewArray) {
        _headViewArray = [[NSMutableArray alloc] init];
    }
    return _headViewArray;
}
//cell 是否展开状态数组
-(NSMutableArray *)stateArray{
    if (!_stateArray) {
        _stateArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0",@"0", nil];
    }
    return _stateArray;
}
//cell 标题数组
-(NSArray *)cellTitleArray{
    if (!_cellTitleArray) {
        NSArray *groupNames = @[@[@"关系人姓名",@"何种关系"],@[@"有关资料"],@[],@[@"所属交易所"],@[@"受雇的监管机构"],@[]];
        _cellTitleArray = groupNames;
    }
    return _cellTitleArray;
}
//cell 文本控件类型数组
-(NSMutableArray *)cellTextArray{
    if (!_cellTextArray) {
        NSMutableArray *firstArray = [NSMutableArray arrayWithObjects:[UITextField class],[UITextField class], nil];
        NSMutableArray *secondArray = [NSMutableArray arrayWithObjects:[UITextField class], nil];
        NSMutableArray *thirdArray = [NSMutableArray arrayWithObjects:[UITextField class], nil];
        NSMutableArray *fouthArray = [NSMutableArray arrayWithObjects:[UITextField class], nil];
        NSArray *groupNames = @[firstArray,secondArray,@[],thirdArray,fouthArray,@[]];
        _cellTextArray = [NSMutableArray arrayWithArray:groupNames];
    }
    return _cellTextArray;
}
//cell的类型数组
-(NSArray *)cellStyleArray{
    if (!_cellStyleArray) {
        NSArray *groupNames = @[@[@"2",@"2"],@[@"2"],@[],@[@"2"],@[@"2"],@[]];
        _cellStyleArray = groupNames;
    }
    return _cellStyleArray;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView  =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, VIEW_WIDTH, 50)];
        [titleLabel setText:@"  其他资料披露"];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        _tableView.tableHeaderView = titleLabel;
        _tableView.tableFooterView = self.footView;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}
-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 100)];
        
        [_footView setBackgroundColor:[UIColor clearColor]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 60, VIEW_WIDTH-40, 40)];
        [imageView setImage:[UIImage imageNamed:@"b_btn"]];
        [_footView addSubview:imageView];
        UIButton *clauseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        clauseBtn.frame = CGRectMake(20, 0, 140, 40);
        clauseBtn.titleLabel.font = [UIFont rdSystemFontOfSize:14];
        [clauseBtn setTitle:@"阅读“该等条款”内容" forState:UIControlStateNormal];
        [clauseBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [clauseBtn addTarget:self action:@selector(clauseClick) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:clauseBtn];
        UIButton *sumbitBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        sumbitBtn.frame = CGRectMake(20, 60, VIEW_WIDTH-40, 40);
        sumbitBtn.titleLabel.font = [UIFont rdSystemFontOfSize:14];
        [sumbitBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [sumbitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sumbitBtn addTarget:self action:@selector(sumbitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.sumbit = sumbitBtn;
        [_footView addSubview:sumbitBtn];
        [_footView addSubview:sumbitBtn];
    }
    return _footView;
}
-(void)clauseClick{
    [self.view addSubview:self.clauseView];
}
-(OtherInforClauseView *)clauseView{
    if (!_clauseView) {
        _clauseView = [[OtherInforClauseView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    }
    return _clauseView;
}
#pragma 上传参数 数组 懒加载
-(NSArray *)sectionParameterArray{
    if (!_sectionParameterArray) {
        _sectionParameterArray = [NSArray arrayWithObjects:@"relationship_is_choose",@"participant_is_choose",@"profit_is_choose",@"members_is_choose",@"employees_is_choose",@"terms_is_choose", nil];
    }
    return _sectionParameterArray;
}
-(NSArray *)relationshipIsChooseArray{
    if (!_relationshipIsChooseArray) {
        _relationshipIsChooseArray = [NSArray arrayWithObjects:@"relationship_name",@"relationship_type", nil];
    }
    return _relationshipIsChooseArray;
}

-(NSArray *)participantIsChooseArray{
    if (!_participantIsChooseArray) {
        _participantIsChooseArray = [NSArray arrayWithObjects:@"participant_data",nil];
    }
    return _participantIsChooseArray;
}
-(NSArray *)membersIsChooseArray{
    if (!_membersIsChooseArray) {
        _membersIsChooseArray = [NSArray arrayWithObjects:@"exchange_name", nil];
    }
    return _membersIsChooseArray;
}
-(NSArray *)employeesIsChooseArray{
    if (!_employeesIsChooseArray) {
        _employeesIsChooseArray = [NSArray arrayWithObjects:@"hired_regulators", nil];
    }
    return _employeesIsChooseArray;
}

@end
