//
//  OtherInforClauseView.m
//  RDFuturesApp
//
//  Created by user on 2017/5/22.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OtherInforClauseView.h"

@interface OtherInforClauseView()
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)UIScrollView *scroll;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *title;


@end

@implementation OtherInforClauseView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.bgview];
        [self addSubview:self.scroll];
        [self.scroll addSubview:self.title];
        [self.scroll addSubview:self.label];
        
    }
    return self;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIScrollView *)scroll{
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*0.5-150, self.bounds.size.height*0.5-200, 300, 400)];
        _scroll.backgroundColor = [UIColor whiteColor];
        _scroll.layer.masksToBounds = YES;
        _scroll.layer.cornerRadius = 5;
    }
    return _scroll;
}
-(UIView *)bgview{
    if (!_bgview) {
        _bgview = [[UIView alloc] initWithFrame:self.bounds];
        [_bgview setBackgroundColor:[UIColor blackColor]];
        [_bgview setAlpha:0.8];
    }
    return _bgview;
}
-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        [_title setText:@"客户声明、确认及协议"];
        [_title setTextAlignment:NSTextAlignmentCenter];
        [_title setFont:[UIFont rdSystemFontOfSize:18]];
    }
    return _title;
}
-(UILabel *)label{
    if (!_label) {
        NSString *string = [NSString stringWithFormat:@"1、客户同意遵守开户表格、《期货合约交易条款及条件》及附录(如适用)以及其他由瑞达国际金融控股有限公司不时发出之守则及指引内之所有条款及条件(统称“该等条款”)开立此开户表格A2章节所列出的帐户(“帐户”)。该等条款亦已刊载于瑞达国际金融控股有限公司网址:http://www.ruida-int.com/上。瑞达国际金融控股有限公司已经建议客户对上述之该等条款寻求独立法律意见。客户同意瑞达国际金融控股有限公司有权要求客户签署相关文件就上述有关条款的要求。 客户于开立帐户前已经细阅及完全明白所有该等条款之内容，客户并同意、接受及确认该等条款内所有条款及条件，并同意及接纳受该等条款的约束。\n2、客户必须使用瑞达国际金融控股有限公司不时提供的指定电话号码(\"指定电话号码\")进行任何指示。为清楚起见，如客户(i)透过电话但并非使用指定电话号码给予的任何指示;或（ii）在瑞达国际金融控股有限公司的其他电话号码，或瑞达国际金融控股有限公司的雇员或代理人的个人手提电话号码或留言信箱留下口讯的方式给予的任何指示(统称\"非指定电话号码指示\")，瑞达国际金融控股有限公司均不接受。即使有以上之规限，瑞达国际金融控股有限公司有绝对酌情权决定是否接纳非指定电话号码指示，有关接纳与否而导致之后果，瑞达国际金融控股有限公司亦无须就此而负上任何责任。\n3、瑞达国际金融控股有限公司有绝对之权利不时更改、修订、删除或取替上述该等条款内的任何条款及细则并于瑞达国际金融控股有限公司网址http://www.ruida-int.com/之《公司公告》专栏内刊载，而客户可详细查阅所有有关的修订条款。瑞达国际金融控股有限公司会通知客户新的修订。所有有关更改、修订、删除或取替将被视作于上述网址刊载当日生效，并被视为列入该等条款内。客户有责任定期浏览上述网址，以确保获得及时的通知。客户可于上述网址刊载当日后十四天内以书面向瑞达国际金融控股有限公司提出反对，否则就被视为接受上述的改动。\n4、瑞达国际金融控股有限公司不时于其网址http://www.ruida-int.com/刊载有关期货合约之规格及资料，该等规格及资料对客户有约束力。瑞达国际金融控股有限公司不须对该等规格及资料的错误、遗漏或延误通知令客户蒙受的任何损失、开支、赔偿或失去任何利润，向客户负责或承担任何法律责任。客户现确认已详细阅读按照客户选择的语言而提供之该等规格及资料。客户亦确认已获邀请透过书面途径提出问题及寻求独立意见。\n5、客户声称，所有填写于本开户表格的资料均属真实，完全及正确，并授权瑞达国际金融控股有限公司可向任何方面查证。客户承诺，如客户提供给瑞达国际金融控股有限公司用于开户的资料有任何的更改及必须通知瑞达国际金融控股有限公司有关所有提供资料之变更。\n6、本公司已根据客户所选择的语言向其提供及解释下列事项：随附的包括但不限于《期货合约交易条款及条件》第3章的风险披露声明。客户已完全明白及接受所有内容和细则，并已寻求独立法律意见。客户明白任何在刊物上提及有关于某种工具或服务的风险未必是及不应被看作成关于某种工具或服务的全面风险，客户同意在投资前寻求专业财务意见。\n7、客户同意建立任何交易的保证金要求由瑞达国际金融控股有限公司不时定立，客户应不时留意于http://www.ruida-int.com/网址内刊载有关之公告。\n8、客户必须在进行期货合约买卖前存入瑞达国际金融控股有限公司要求的基本保证金。当客户的帐户有期货合约，惟帐户内的资产分滴茨艽锏狡诨鹾显嫉奈持保证金要求，客户必须自行安排增补保证金金额至基本保证金水平，瑞达国际金融控股有限公司将并不一定向个别客户发出保证金通知或警告。在瑞达国际金融控股有限公司取消保证金警告前，该帐户不能建立任何新仓，瑞达国际金融控股有限公司有浸对酌情权在不事先知会客户或未经客户同意下，将客户户口内部分或全部合约进行强制平仓。若平仓所得之金额不足以抵偿全部欠款，客户仍须就所欠款项负责。瑞达国际金融控股有限公司保留不时修订的保证金要求之权利。客户接受并同意遵守上述之保证金的要求。\n9、客户理解瑞达国际金融控股有限公司确切需要一整个工作天以处理客户资金。为使客户的资金能快捷地得到受理，客户应不时参阅于瑞达国际金融控股有限公司网址http://www.ruida-int.com/列明关于资金的规定及文件需求。若客户是由国际电汇存入资金，客户同意瑞达国际金融控股有限公司处理结算可能需时3至5个工作天。\n10、该等条款之中文版本及英文版本如有任何歧义，概以英文版本为准。英文版本已经于瑞达国际金融控股有限公司网址http://www.ruida-int.com/完整地列出及予以下载。\n11、本人(客户)兹声明，当本人(客户)于下列签署栏内签署后，即表示本人(客户)已完全细阅、确认、同意、接受及明白该等条款(包括本合约内各项之所有内容)所有内容和细则。关于上述各项所有内容和细则，本人(客户)已寻求独立法律意见，并明白所有其内容和细则及没有任何疑问。"];
        CGSize size = [UILabel textForFont:fourteenFontSize andMAXSize:CGSizeMake(280, MAXFLOAT) andText:string];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, getTop(self.title), 280, size.height)];
        _label.numberOfLines = 0;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2];
        NSDictionary *attributedDic = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:fourteenFontSize]};
                       NSAttributedString *attributed = [[NSAttributedString alloc] initWithString:string attributes:attributedDic];
        
        _label.attributedText = attributed;
        [self.scroll setContentSize:CGSizeMake(0, getTop(_label)+10)];
    }
    return _label;
}
@end
