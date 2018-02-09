//
//  RDCommon.h
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//


#define RDCommon_h
//版本号
#define IOS_VERSION         [[[UIDevice currentDevice] systemVersion] floatValue]

#define isPhone5       SCREEN_WIDTH == 320 ? YES:NO 

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//获取控制器view 宽度、高度
#define VIEW_WIDTH  self.view.frame.size.width
#define VIEW_HEIGHT self.view.frame.size.height


//亮灰
#define LIGHTGRAYCOLOR [UIColor colorWithRed:234.0/255.0 green:235.0/255.0 blue:236.0/255.0 alpha:1]

//获取view 宽高
#define viewWidth         self.frame.size.width
#define viewHeight        self.frame.size.height

//背景灰
#define BACKGROUNDCOLOR [UIColor colorWithRed:235.0/255.0 green:239.0/255.0 blue:240.0/255.0 alpha:1]
//字体灰
#define GRAYCOLOR [UIColor colorWithRed:98.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1]

#define GRAYCOLOR2 [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1]

#define GRAYKUANGCOLOR [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1]
//蓝色
#define BLUECOLOR [UIColor colorWithRed:63.0/255.0 green:158.0/255.0 blue:242.0/255.0 alpha:1]
/**
 *  字号宏定义
 */
#define eighteenFontSize 18
#define sixteenFontSize 16
#define fifteenFontSize 15
#define fourteenFontSize 14
#define thirteenFontSize 13
#define twelveFontSize 12
#define elevenFontSize 11;

#define navtitlecolor hll_color(0xea, 0x3f, 0x23, 1)
#define navtitletextcolor [UIColor whiteColor]


#define getLeft(v)          (v.frame.size.width + v.frame.origin.x)
#define getTop(v)           (v.frame.size.height + v.frame.origin.y)

#define WS(weakself)   __weak __typeof(&*self) weakSelf = self;

#define NavigationBarHeight 64

#define showMassage(msg) [MBProgressHUD showSuccess:msg];

#define hiddenHUD        [MBProgressHUD hideHUD];

#define loading(msg)     [MBProgressHUD showMessage:msg];


#define RGB(r, g, b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define TITLE_COLOR [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1.0]

#define SUB_TITLE_COLOR [UIColor colorWithRed:159.0/255.0 green:159.0/255.0 blue:159.0/255.0 alpha:1.0]

#define THREE_TITLE_COLOR [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1.0]

#define DEFAULT_COLOR RGB(255, 165, 33)

#define DEFAULT_BG_COLOR [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]

#define Baidu_Map_Key               @"vjg3Gssmy8zIm768y326eQaUNu03MKr7"

//#define HostUrlBak              @"http://112.74.57.22:8080/rdfuture"//正式

#define HostUrlBak              @"http://120.76.184.75:8081/rdfuture"

#define promptString        @"网络正在开小差"

