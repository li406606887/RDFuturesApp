//
//  PeronalInfoViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/5/8.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "PeronalInfoViewController.h"
#import "PersonalFirstCell.h"
#import "PersonalSecondCell.h"
#import "NickNameViewController.h"

@interface PeronalInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{

    UIImage * headerImage;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray * titleArray;
@property (strong,nonatomic) NSArray * dataArray;

@end

@implementation PeronalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"个人资料";
    
    [self titleArray];
    [self dataArray];
    
    [self loadTableView];
  
    [self.view setBackgroundColor:BACKGROUNDCOLOR];
    
}

-(void)loadTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:kPersonalFirstCell bundle:nil] forCellReuseIdentifier:kPersonalFirstCell];
    [self.tableView registerNib:[UINib nibWithNibName:kPersonalSecondCell bundle:nil] forCellReuseIdentifier:kPersonalSecondCell];
}

#pragma mark - back block
-(UIBarButtonItem *)leftButton{

    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [btn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];;
}

-(void)backBtnClick:(id)sender{

    self.popBlock(_username,_user_img);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 相机相册代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    //获取
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    headerImage = image;

    //存入
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //上传更新
    [self postHeaderImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 上传头像
-(void)postHeaderImage{
    
    loading(@"正在请求数据");
    __weak __typeof(self)weakSelf = self;
    NSString * str = [RDUserInformation transBase64WithImage:headerImage];
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:str forKey:@"new_img"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest getWithApi:@"/api/user/changeUserImg.api" andParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);
                _user_img = model.Data[@"user_img"];
                [weakSelf.tableView reloadData];
         
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });
    });
}

-(NSArray *)dataArray {
    if (_user_img == nil || _username == nil || _customer_id == nil) {
        _user_img = [NSURL URLWithString:@""];
        _username = @"--";
        _customer_id = @"--";
    }
    _dataArray = @[_user_img,_username,_customer_id];
    return _dataArray;
}
-(NSArray *)titleArray{

    if (!_titleArray) {
        _titleArray = @[@"头像",@"昵称",@"客户号"];
    }
    return _titleArray;
}

#pragma mark - tableView代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakself)
    
    switch (indexPath.row) {
        case 0:
        {//头像
        
            [self chooseImage];
        }
            break;
        case 1:
        {
            NickNameViewController * NVC = [[NickNameViewController alloc]init];
            NVC.backblock = ^(NSString * str){
                _username = str;
                [weakSelf dataArray];
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:NVC animated:YES];
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    PersonalFirstCell * cell1 = [tableView dequeueReusableCellWithIdentifier:kPersonalFirstCell];
    PersonalSecondCell * cell2 = [tableView dequeueReusableCellWithIdentifier:kPersonalSecondCell];
    
    if (indexPath.row == 0) {

        [cell1.imgView sd_setImageWithURL:_user_img placeholderImage:[UIImage imageNamed:@"head_icon"]];//ImageLoadingFaile

        return cell1;
    }else{
        cell2.titleLabel.text = _titleArray[indexPath.row];
        cell2.rightLabel.text = _dataArray[indexPath.row];
        return cell2;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        return 75;
    }else
        return 45;
}

#pragma mark - UIAlertController
-(void)chooseImage{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction * picture = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController * pickerImage = [[UIImagePickerController alloc] init];
        pickerImage.delegate = self;
        pickerImage.allowsEditing = NO;
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
        
        
        [self presentViewController:pickerImage animated:YES completion:nil];
    }];
    
    [alert addAction:cancle];
    [alert addAction:camera];
    [alert addAction:picture];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
