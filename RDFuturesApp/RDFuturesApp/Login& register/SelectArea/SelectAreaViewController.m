//
//  SelectAreaViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/23.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "SelectAreaViewController.h"
#import "ChineseString.h"
#import "AreaTableViewCell.h"
@interface SelectAreaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSArray *numberArray;
@end

@implementation SelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所属地区";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:kAreaTableViewCell bundle:nil] forCellReuseIdentifier:kAreaTableViewCell];

    
    NSArray * stringsToSort = [NSArray arrayWithObjects:@"中国China",@"台湾Taiwan",@"香港Hong Kong (SAR)",@"澳门Macao",nil];
    
    self.indexArray = [ChineseString IndexArray:stringsToSort];
    self.letterResultArr = [ChineseString LetterSortArray:stringsToSort];
    
  
    
    NSLog(@"one=%@second=%@",_indexArray,_letterResultArr);
 
}

- (IBAction)daluClick:(id)sender {
    self.backblock(@"中国大陆",@"+86");
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)HKClick:(id)sender {
    self.backblock(@"中国香港",@"+852");
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)macaoClick:(id)sender {
    self.backblock(@"中国澳门",@"+853");
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)TWCilck:(id)sender {
    self.backblock(@"中国台湾",@"+886");
    [self.navigationController popViewControllerAnimated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 20.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.1f;
}
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{

    return self.indexArray;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    NSString * key = [self.indexArray objectAtIndex:section];
    return key;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSLog(@"section=%lu",(unsigned long)[[self.letterResultArr objectAtIndex:section] count]);
    
    
    return [[self.letterResultArr objectAtIndex:section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [self.indexArray count];
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    AreaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAreaTableViewCell];
    cell.leftLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    showMassage(title)
    return index;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [UILabel new];
    lab.backgroundColor = BACKGROUNDCOLOR;
    lab.text = [NSString stringWithFormat:@"  %@",[self.indexArray objectAtIndex:section]];
    lab.textColor = GRAYCOLOR2;
    return lab;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
