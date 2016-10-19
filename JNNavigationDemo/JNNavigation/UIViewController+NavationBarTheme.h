//
//  UIViewController+NavationBarTheme.h
//  JNNavigation
//
//  Created by Jonear on 16/4/26.
//  Copyright © 2016年 Jonear. All rights reserved.
//

#import <UIKit/UIKit.h>

// TODO:you can add more
typedef NS_ENUM(NSInteger, FNNavationBarType) {
    FNNavationBarType_Normal,          // 默认的，白色毛玻璃透明 (有线)
    FNNavationBarType_Green,           // 主题绿色 (无线)
    FNNavationBarType_Clear,           // 透明 (无线)
    FNNavationBarType_Black,           // 黑色 (无线)
};

@interface UIViewController (NavationBarTheme)

/**
 *  设置导航栏样式
 *
 *  @param type 样式
 */
- (void)setNavigationBarWithType:(FNNavationBarType)type;

/**
 *  当前导航栏的主题
 */
@property (assign, nonatomic, readonly) FNNavationBarType currentType;

/**
 *  重新自定义导航栏字体颜色
 */
@property (assign, nonatomic) UIColor *customTintColor;

/**
 *  所有系统都使用双导航模式，默认NO
 */
@property (assign, nonatomic) BOOL towNavBarModel;


/**
 *  删除ios10自定义导航栏，在基类的viewDidApple中调用
 */
- (void)removeCustomNavBar;

@end
