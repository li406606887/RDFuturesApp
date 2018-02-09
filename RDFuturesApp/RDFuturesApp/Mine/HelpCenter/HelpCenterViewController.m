//
//  HelpCenterViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/18.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "HelpCenterViewController.h"
#import "OnlineServiceViewController.h"
#import "AnswerViewController.h"
@interface HelpCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (nonatomic, strong)NSArray * titleArray;
@property (nonatomic, strong)NSArray * contentArray;
@end

@implementation HelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"帮助中心";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self setTextColorWithBlue];
    
    [self titleArray];
    [self contentArray];

}
-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"瑞达国际可以做哪些品种？",@"瑞达国际的客户保证金如何得到安全保障？", @"瑞达国际的交易方式是怎样的？",@"外盘期货品种有无涨跌停板？",@"瑞达国际开户条件？对资金有没有要求？",@"瑞达国际企业户开户所必须提供资料？",@"开户合同签署几份？",@"香港银行卡怎样办理？",@"在国内办理香港银行账户需要提供住址证明，住址证明须满足哪些要求？",@"国内银行的换汇额度？",@"客户亲临瑞达国际开立期货账户需要携带什么证件和资料？",@"多长时间可以开好户？",@"客户开户后如需变更相关资料，如何办理？",@"客户开户后怎样出入金？",@"香港银行卡每天网银转帐限额？",@"外盘有无银期转账？",@"入金的币种要求，怎样换汇？",@"交易不同交易所品种，交易台怎样转换币种？",@"外盘研究报告怎样获取？",@"外盘能否锁仓？",@"外盘保证金的收取方式？",@"外盘的交易时间？何为场内交易和电子交易？",@"基本保证金和维持保证金的区别？",@"瑞达国际什么时候电话通知追加保证金和实行强制平仓？",nil];
    }
    return _titleArray;
}
-(NSArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSArray arrayWithObjects:@"瑞达国际依法持有香港证监会颁发的期货牌照，可以代理几乎全球所有期货交易所的期货及期权品种，期货品种包括：美国的农产品类、能源类、贵金属类、指数类、外汇类；伦敦金属交易所的基本金属；日本橡胶；马来西亚棕榈油；香港恒指期货和国企指数期货等。",
                         @"瑞达国际受香港证监会监管。客户保证金帐户和公司日常帐户严格分开，专户专用。",
                         @"交易方式包括：网上交易及电话交易。可以网上交易几乎所有期货品种，包括LME基本金属（期权等衍生品除外）。同时，瑞达国际交易台配有人工下单团队，交易员全天24小时值班，以满足客户全方位的交易需求。",
                         @"大部分品种无涨跌停板限制。如：纽约黄金、白银；伦敦金属等。",
                         @"个人户：要求客户具有一定期货投资经验；具备香港银行账户、护照或者港澳通行证。个人户第一次入金额度不少于2万美金或者15万港币。企业户：以海外公司的名义在瑞达国际开户。企业户也需满足相应的资金要求。",
                         @"企业户开户的条件是必须以海外公司的名义在瑞达国际开户。同时提供以下材料：a.  公司董事会通过在瑞达国际投资控股(香港)有限公司开立期货帐户的会议记录原件。b.  公司大股东（股权比例大于等于10%者）的身份证明（如果是个人则为身份证复印件，如果是企业则为商业登记证或营业执照副本复印件）。c.  公司董事的身份证明。d.  被授权人（开户人、资金调拨人及指令下单人）的身份证明。e.  公司章程一份。f.  企业银行账户的证明文件。",
                         @"无论是个人户还是企业户，合同只签署一份，完成开户后，瑞达国际将合同复印件交给客户存档。合同复印件具有与原件同等的法律效力。",
                         @"两种方式可以办理。第一种：可以亲临香港银行柜台办理。第二种：目前国内银行的部分网点在国内已开设代办香港银行卡的鉴证业务，也就是说客户本人无需去香港就可以办到香港银行账户。依照银行业务办理的效率及便利性依次列举如下：建行（陆港通龙卡）、招行（香港一卡通）、工行（349账户）、中行（南洋商业银行鉴证开户）等。",
                         @"住址证明文件的收信人地址为住宅地址，而非公司地址。住址证明文件的收信人姓名与开户证件名同名。发出日期为三个月内。建议使用公用事业收费单，如：水、电、煤气的收费单或者银行的信用卡、借记卡月结单。",
                         @"中国外管局规定中国居民每人每年的换汇额度为（或者等值为）5万美金。（银行允许该人士直系亲属携带相关证件（如：结婚证、户口本）换汇后汇入该人士香港银行账户。）",
                         @"客户只需携带本人身份证、港澳通行证或者护照即可办理好香港银行账户和外盘期货账户。",
                         @"正常情况下合同签订完成一周内可以完成开户。",
                         @"公司网站上，“客服中心”中的“常用表格”栏目下，有“客户增加或撤销授权第三者交易通知”、“客户更改银行账户通知”“客户增加银行账户通知”、“客户更新户口资料通知”等。",
                         @"客户入金时需通过香港银行的同名帐户向瑞达国际客户保证金帐户划转资金。资金划转后，客户应及时通知公司人员并将资金划转的凭证发送至公司邮箱（cs@ruida-int.com）或传真至00852-2563 2368。客户出金时，客户需致电瑞达国际交易台，瑞达国际将按照客户指令，将资金划转至客户协议银行帐户，并通知客户。",
                         @"大部分银行（包括招行香港、中银香港、工银亚洲、建银亚洲、汇丰银行等）每天的网银转帐限额为50万港币，如果客户需要一次性大金额入账，则可以亲临香港或者以支票形式入金。",
                         @"无银期转账。",
                         @"瑞达国际主要入金币种为美元和港币，也可以接受欧元、英磅、日币等入金。客户可以通过银行购汇，并汇到其香港账户。",
                         @"只要客户总的权益足够，就可以交易不同结算货币的品种，第二天结算后我们会要求客户换汇至其他货币，以弥补相应货币的短缺。",
                         @"瑞达国际每天会向客户发送外盘研究报告，如果客户有特殊要求，可向我们提出，瑞达国际研究院可以根据客户需求提供有针对性的研究报告。",
                         @"外盘品种不能实现同交易所同品种同合约的相反方向的锁仓。此操作后果默认为平仓。",
                         @"外盘绝大部分品种的保证金收取不同于国内的按比例收取，而是交易所根据标准组合风险分析程式（SPAN）系统的提示来收取。根据相关期货价格及期货价格的波动性来调整保证金水平。",
                         @"外盘除了亚洲如：日本、香港、马来西亚等几个市场交易时间非24小时制外，其它欧美主要市场都为24小时制（中间有短暂休息除外）。场内交易常常指的是欧美市场白天交易时间段，也就是亚洲的晚上时间段。此阶段场内开始交易，电子盘同样运行。可以说电子盘是全天候的，其中包括了场内时间段。",
                         @"基本保证金高于维持保证金，客户资金必须高于或等于基本保证金才可以开仓，如果客户的总权益低于维持保证金，将会被通知追加资金或减仓。",
                         @"当客户总权益低于维持保证金后，交易台将电话通知客户追加保证金或减仓。一旦客户的总权益低于维持保证金，瑞达国际风险控制部就有权对客户的持仓进行强平，瑞达国际风险控制部将视市场的变动情况和与客户的沟通情况决定是否要进行强行平仓。",nil];
    }
    return _contentArray;

}
-(void)setTextColorWithBlue{

    NSMutableAttributedString* string = [[NSMutableAttributedString alloc]initWithString:_phoneLabel.text];
    //您也可以通过电话联系我们:400-000-1234
    //(00852)2534 2000
    NSRange range;
    
    range = NSMakeRange(13, 16);
    
    [string addAttribute:NSForegroundColorAttributeName value:BLUECOLOR range:range];
    
    [_phoneLabel setAttributedText:string];
    
    _phoneLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(phoneClick)];
    [_phoneLabel addGestureRecognizer:tap];
}

-(void)phoneClick{

//    NSString * str = [_phoneLabel.text substringFromIndex:_phoneLabel.text.length-16];
    NSString * str1 = @"0085225342000";
    NSMutableString* str2=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",str1];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str2]];

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    bgView.backgroundColor = BACKGROUNDCOLOR;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15, 7.5, 200, 20)];
    label.textColor = [UIColor colorWithRed:106.0/255.0 green:106.0/255.0 blue:106.0/255.0 alpha:1.0f];
    label.font = [UIFont rdSystemFontOfSize:15.0f];
    [bgView addSubview:label];
    
    switch (section) {
        case 0:
        {
            label.text = @"常见问题";
        }
            break;
        case 1:
        {
            label.text = @"外盘专业知识";
        }
            break;

            
        default:
            break;
    }
    
    
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    //设置多行显示
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont rdSystemFontOfSize:16.f];
    
    if (indexPath.section == 0) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_titleArray[indexPath.row]];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_titleArray[indexPath.row + 19]];
    }

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    AnswerViewController * AVC = [[AnswerViewController alloc]init];
    NSInteger index = indexPath.row;
    
    switch (indexPath.section) {
        case 0:
        {
            AVC.titleStr = [NSString stringWithFormat:@"%@",_titleArray[index]];
            AVC.contentStr = [NSString stringWithFormat:@"%@",_contentArray[index]];
           
        }
            break;
        case 1:
        {
            AVC.titleStr = [NSString stringWithFormat:@"%@",_titleArray[index + 19]];
            AVC.contentStr = [NSString stringWithFormat:@"%@",_contentArray[index+19]];
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:AVC animated:YES];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return 19;
            break;
        case 1:
            return 5;
            break;
        
            
        default:
            break;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *str = [itemName [indexPath.row]stringByAppendingString:strList[indexPath.row]]; //你想显示的字符串
    
//    CGSize size = [str sizeWithFont:[UIFont rdSystemFontOfSize:16.0f] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
//    
//    NSLog(@"%f",size.height);
//    
//    return size.height + 10;
    return 60;
}

#pragma mark - 我的客服
- (IBAction)btnClick:(id)sender {
    
    OnlineServiceViewController * CVC = [[OnlineServiceViewController alloc]init];
    [self.navigationController pushViewController:CVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
