//
//  OpenAccountViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/2.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "OpenAccountViewController.h"
#import "IdPhotoViewController.h"
#import "OpenAccountFileGroup.h"
#import "OpenAccountFileCell.h"
#import "ChooseIDViewController.h"

@interface OpenAccountViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    NSMutableArray *dataArray;//数据源数组
    int clickCount;
    int sectionBtnCount;
    NSArray * titleArray;
    UIWebView * webView;
    NSArray * contentArray;
    NSMutableArray *dataArray1;//conten
}

@property(nonatomic, strong) UITableView * tableView;
@property (weak, nonatomic) IBOutlet UIButton *readButton;
@property (nonatomic,assign) int lastTapSection;

@end

@implementation OpenAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lastTapSection = -1;
    self.navigationItem.title = @"开户文件列表";
    clickCount = 1;
    
    [_readButton setImage:[UIImage imageNamed:@"unselected_icon"] forState:UIControlStateNormal];
    sectionBtnCount = 1;
    
    titleArray = @[@"1.经纪资料",@"2.期货合约交易服务之一般条款及条件",@"3.互联网期货合约交易服务条款及条件",@"4.风险披露声明",@"5.关于买卖恒生指数期货及期权的免责声明"];
    

    [self loadContentStr];
    
    [self loadTableView];
    
    //绑定数据源
    [self loadDataModel];
    [self loadContentModel];

}
#pragma mark -
- (NSArray *)loadContentStr{
    if (!contentArray) {
        contentArray = @[[NSString turnTxtStringWithJianStr:@"1.经纪资料"],
                         [NSString turnTxtStringWithJianStr:@"2.期货合约交易服务之一般条款及条件"],
                         [NSString turnTxtStringWithJianStr:@"3.互联网期货合约交易服务条款及条件"],
                         [NSString turnTxtStringWithJianStr:@"4.风险披露声明"],
                         [NSString turnTxtStringWithJianStr:@"5.关于买卖恒生指数期货及期权的免责声明"]];
    }
    return contentArray;

}



#pragma mark -- Load 表示图
- (void) loadTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 15, SCREEN_WIDTH-20, SCREEN_HEIGHT-264) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView.hidden = YES;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    //去除留白
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SectionCell" bundle:nil] forCellReuseIdentifier:@"SectionCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:kOpenAccountFileCell bundle:nil] forCellReuseIdentifier:kOpenAccountFileCell];

    
}
- (void)loadContentModel{
    
    if (!dataArray1) {
        dataArray1 = [NSMutableArray array];
    }
    
    dataArray1 = [NSMutableArray array];
    for (NSString *string in contentArray) {
        OpenAccountFileGroup *group = [[OpenAccountFileGroup alloc] initWithContent:string];
        [dataArray1 addObject:group];
    }
    
}

- (void) loadDataModel {
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    // Todo: 加载数据模型
    NSArray *groupNames = @[@[@""],@[@""],@[@""],@[@""],@[@""]];
    //这是模型类
    
    //这是一个分组的模型类
    for (NSMutableArray *name in groupNames) {
        OpenAccountFileGroup *group1 = [[OpenAccountFileGroup alloc] initWithItem:name];
        [dataArray addObject:group1];
    }
    
    
}
#pragma mark - tableView 代理方法
//这是tabview创建多少组的回调
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OpenAccountFileGroup *group;
    NSLog(@"上次点击的senction=%ld",(long)self.lastTapSection);

//    for (int i = 0; i<dataArray.count; i++) {
//        if (i == self.lastTapSection) {
//            group = dataArray[i];
//            group.folded = !group.isFolded;
////            return group.isFolded? 0: group.size;
//        }
//        OpenAccountFileGroup *group1;
//        group1 = dataArray[i];
//        group1.folded = group.isFolded;
////        return group1.isFolded? 0: group.size;
//    }
    
//    for (OpenAccountFileGroup *group in dataArray) {
//        group = dataArray[self.lastTapSection];
//        group.folded = !group.isFolded;
//    }
    
    group = dataArray[section];
    return group.isFolded? 0: group.size;
    
}
//button的响应点击事件
- (void) buttonClicked:(UIButton *)sender {
    //改变模型数据里面的展开收起状态
    OpenAccountFileGroup *group;
    if (self.lastTapSection == -1) {
        group = dataArray[sender.tag - 200];
        group.folded = NO;
        self.lastTapSection = (int)sender.tag -200;
        [self.tableView reloadData];
        return;
    }
    if (self.lastTapSection == (sender.tag -200)) {
        NSLog(@"和上次点击的是相同section");
        group = dataArray[sender.tag - 200];
        group.folded = !group.isFolded;
        
    }else {
        group = dataArray[self.lastTapSection];
        group.folded = YES;
       OpenAccountFileGroup *newGroup = dataArray[sender.tag-200];
        newGroup.folded = NO;
    }
    
    self.lastTapSection = (int)sender.tag -200;
    [_tableView reloadData];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (CGSize)textForFont:(int)font andMAXSize:(CGSize)size andText:(NSString*)text {
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont rdSystemFontOfSize:font]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}


#pragma mark - 自适应高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //动态
    OpenAccountFileGroup *group = dataArray1[indexPath.section];
    
    CGSize ret1;

    CGFloat height;

    ret1 = [self textForFont:12 andMAXSize:CGSizeMake(SCREEN_WIDTH - 60, MAXFLOAT) andText:group.contentStr];

    height = ret1.height;
    
    return height;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    OpenAccountFileCell * cell = [tableView dequeueReusableCellWithIdentifier:kOpenAccountFileCell];
    OpenAccountFileGroup *group = dataArray1[indexPath.section];
    cell.contentText = group.contentStr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

// 定义头标题的视图，添加点击事件
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 50)];
    bgView.image = [UIImage imageNamed:@"sectionBG"];
    bgView.userInteractionEnabled = YES;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(18, 15, SCREEN_WIDTH-60, 20)];
    label.text = titleArray[section];
    [bgView addSubview:label];
    
    //添加一个button用于响应点击事件（展开还是收起）
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [bgView addSubview:button];
    button.tag = 200 + section;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //将显示展开还是收起的状态通过三角符号显示出来
    UIImageView *fuhao=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH- 55, 13, 25, 20)];
    fuhao.tag=section;
    [bgView addSubview:fuhao];
    //根据模型里面的展开还是收起变换图片
    OpenAccountFileGroup *group = dataArray[section];
    if (group.isFolded==YES) {
        fuhao.image=[UIImage imageNamed:@"down_icon"];
    }else{
        fuhao.image=[UIImage imageNamed:@"up_icon"];
    }

    return bgView;
}


#pragma mark -已读
- (IBAction)alreadyBtnClick:(id)sender {
    if (clickCount == 1) {
         [_readButton setImage:[UIImage imageNamed:@"sel_kuang"] forState:UIControlStateNormal];

        clickCount =2;
        return;
    }
    if (clickCount ==2) {
         [_readButton setImage:[UIImage imageNamed:@"unselected_icon"] forState:UIControlStateNormal];
        
        clickCount = 1;
        return;
    }

   
}
#pragma mark -下一步
- (IBAction)nextClick:(id)sender {
    
    if (clickCount==1) {
        //未点击同意开户协议
        [self setAlertView];
    }else{
        ChooseIDViewController *CVC = [[ChooseIDViewController alloc]init];
        [self.navigationController pushViewController:CVC animated:YES];
        
    }
}
//提示框
-(void)setAlertView {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请勾选同意开户协议" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    //弹出
    [self presentViewController:alert animated:true completion:nil];
    
}

#pragma mark - webview显示本地文件
-(void)loadWebView{
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 600)];
    webView.delegate = self;
    webView.scrollView.scrollEnabled = NO;
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [webView setUserInteractionEnabled:YES];
    [webView setScalesPageToFit:YES];
    
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"常设授权.pdf" ofType:nil];
    //以二进制的形式加载数据
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSURL *url = [NSURL fileURLWithPath:path];
    [webView loadData:data MIMEType:@"application/pdf" textEncodingName:@"UTF-8" baseURL:url];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
