//
//  ContactInfoModel.h
//  RDFuturesApp
//
//  Created by 吴桂钊 on 2017/3/31.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInfoModel : NSObject
@property(copy,nonatomic) NSString * email;
@property(copy,nonatomic) NSString * postal_address;
@property(copy,nonatomic) NSString * occupational_status_id;
@property(copy,nonatomic) NSString * company_name;
@property(copy,nonatomic) NSString * professional_position;
@property(copy,nonatomic) NSString * business_type_id;
@property (nonatomic,strong) NSString *company_address;
@property (nonatomic,strong) NSString *service_age;
/*
	1、email						邮箱
	2、postal_address			通讯地址
	3、occupational_status_id	职业状态id
	4、company_name				公司名称
 5、company_address		    公司地址
	6、professional_position		职业职位
	7、business_type_id			业务性质id
	8、service_age				服务年限

 */
@end
