//
//  WitnessCityViewController.m
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/10.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "WitnessCityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "CommitInfoViewController.h"
#import "ZMBAddressSelectionView.h"
#import "ZMBAddressItem.h"
#import "MBProgressHUD+NJ.h"

@interface WitnessCityViewController ()<CLLocationManagerDelegate,ZMBAddressSelectionViewDelegate>
{
    CLLocationManager * locationManager;
    ZMBAddressSelectionView * addressView;
    NSString * city_id;
    

}

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (nonatomic,strong) NSString * sheng;
@property (nonatomic,strong) NSString * city;
@end

@implementation WitnessCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"见证信息";
    
    [self initializeLocationService];
    
    city_id = [NSString stringWithFormat:@"%@",@"-1"];//表示城市是定位的无id
    
}
#pragma mark - 更换城市
- (IBAction)changeBtnClick:(id)sender {
    
    addressView = [[ZMBAddressSelectionView alloc]init];
    [addressView showInView:self.view];
    addressView.delegate = self;

//    __weak typeof(self) weakSelf = self;
    WS(weakself)
    addressView.addressSelectionFinished = ^(NSString* id ,NSString *name){
        
        weakSelf.cityLabel.text = [NSString stringWithFormat:@"%@%@%@",weakSelf.sheng,weakSelf.city,name];
        
        city_id = id;
    };
    addressView.addressShengFinished=^(NSString* id ,NSString *name){
        NSLog(@"%@",name);
        _sheng = [NSString stringWithFormat:@"%@",name];
    };
    
    addressView.addressCityFinished =^(NSString* id ,NSString *name){
        NSLog(@"%@",name);
        _city = [NSString stringWithFormat:@"%@",name];
    };

    //******************
    loading(@"正在加载");

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error ;
        NSString *message;

        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:@"0" forKey:@"region_id"];
        
        NSArray * sheng = [RDRequest postRegionsListWithWithParam:dic Error:&error andMessage:message];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            hiddenHUD;
            [addressView reloadProvinceTable:sheng];
    
        });
        
    });
    
}
#pragma mark - 城市选择代理方法
- (void)addressSelectionView:(ZMBAddressSelectionView *)selectionView willSelectedProvince:(NSString *)provinceId{
    
    loading(@"正在加载");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error ;
        NSString *message;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:provinceId forKey:@"region_id"];
        
        NSArray * sheng = [RDRequest postRegionsListWithWithParam:dic Error:&error andMessage:message];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            hiddenHUD;
            [addressView reloadCityTable:sheng];
            
        });
        
    });
}
- (void)addressSelectionView:(ZMBAddressSelectionView *)selectionView willSelectedCity:(NSString *)cityId{
    
    loading(@"正在加载");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSError *error ;
        NSString *message;
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:cityId forKey:@"region_id"];
        
        NSArray * sheng = [RDRequest postRegionsListWithWithParam:dic Error:&error andMessage:message];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            
            [addressView reloadDistrictTable:sheng];
            
        });
        
    });
}

#pragma mark — 定位管理器
- (void)initializeLocationService {
    // 初始化定位管理器
    locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    locationManager.delegate = self;
    // 设置定位精确度到米
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    // 设置过滤器为无
    locationManager.distanceFilter = kCLDistanceFilterNone;
    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
    [locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
    // 开始定位
    [locationManager startUpdatingLocation];
    
    showMassage(@"正在定位");
}
#pragma mark CoreLocation delegate
//定位失败则执行此代理方法
//定位失败弹出提示框,点击"打开定位"按钮,会打开系统的设置,提示打开定位服务
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        [[UIApplication sharedApplication] openURL:settingsURL options:@{UIApplicationOpenURLOptionsSourceApplicationKey : @YES} completionHandler:^(BOOL success) {
                if (!success) {
                    //失败
                    showMassage(@"定位失败，请手动选择");
                }
        }];
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:ok];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}
//定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
//            self.cityLabel.text = placemark.name;
            //获取城市
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
            }
            NSString *administrativeArea = placemark.administrativeArea!=nil?[NSString stringWithFormat:@"%@",placemark.administrativeArea]:@"";
            NSString *subLocality = placemark.subLocality!=nil? [NSString stringWithFormat:@"%@",placemark.subLocality]:@"";
            administrativeArea= administrativeArea.length>0 ? [administrativeArea stringByReplacingOccurrencesOfString:@"省" withString:@""]: administrativeArea;
            city = city.length>0 ? [city stringByReplacingOccurrencesOfString:@"市" withString:@""]: city;
            showMassage(@"定位成功");
            self.cityLabel.text = [NSString stringWithFormat:@"%@%@%@",administrativeArea,city,subLocality];
            
        }
        else if (error == nil && [array count] == 0){
            
        self.cityLabel.text = @"定位失败";
            showMassage(@"定位失败");
        }
        else if (error != nil){
            
            self.cityLabel.text = @"定位失败";
            showMassage(@"定位失败");
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}

#pragma mark - 下一步
/*
 请求参数*
 1、witness_city_name				见证城市
 2、witness_city_id				见证城市id（手动选择的才有）
 */
- (IBAction)nextBtnClick:(id)sender {
    
    loading(@"正在提交数据");
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if(![city_id isEqualToString:@"-1"]){
        //需传id
        [dic setObject:city_id forKey:@"witness_city_id"];
    }
    [dic setObject:[RDUserInformation transString:self.cityLabel.text] forKey:@"witness_city_name"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError *error ;
        
        RDRequestModel * model = [RDRequest setWithApi:@"/api/account/setWitnessCityInfo.api" andParam:dic error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (error==nil) {
                showMassage(model.Message);                
                if ([model.Message isEqualToString:@"成功"]) {
                    //成功
                    CommitInfoViewController * CVC = [[CommitInfoViewController alloc]init];
                    [self.navigationController pushViewController:CVC animated:YES];
                }
                
            }else{
                [MBProgressHUD showError:@"请求失败"];
            }
        });

    });
        
    
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
