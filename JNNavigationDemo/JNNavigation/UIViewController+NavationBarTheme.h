//
//  UIViewController+NavationBarTheme.h
//  FengNiao
//
//  Created by Jonear on 16/4/26.
//  Copyright © 2016年 Jonear. All rights reserved.
//

#import <UIKit/UIKit.h>

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

// 重新自定义导航栏字体颜色
@property (assign, nonatomic) UIColor *customTintColor;

/**
 *  用于增加到透明导航栏拖动的时候显示导航栏的功能，也可以自己加个view，这里默认添加一个毛玻璃导航栏在上面
 *
 *  @param barStyle style
 *
 *  @return toolbar
 */
- (UIToolbar *)addTopBarWithBarStyle:(UIBarStyle)barStyle;
- (UIView *)addTopBarWithColor:(UIColor *)color;


/**
 *  删除ios10自定义导航栏，在基类的viewDidApple中调用
 */
- (void)removeCustomNavBar;

@end
