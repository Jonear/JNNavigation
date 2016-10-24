//
//  UIViewController+NavationBarTheme.m
//  JNNavigation
//
//  Created by Jonear on 16/4/26.
//  Copyright © 2016年 Jonear. All rights reserved.
//

#import "UIViewController+NavationBarTheme.h"
#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

#define DefaultTitleSize 17
#define IOS10 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0)
#define UIColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#define UIColorFromRGB(rgbValue)              UIColorFromRGBA(rgbValue, 1.0)

@implementation UIViewController (NavationBarTheme)
static char currentTypeKey;
static char customNavBarKey;
static char customTintColorKey;
static char towNavBarModelKey;

- (FNNavationBarType)currentType {
    NSNumber *typeNum = objc_getAssociatedObject(self, &currentTypeKey);
    return [typeNum integerValue];
}

- (void)setCurrentType:(FNNavationBarType)type {
    objc_setAssociatedObject(self, &currentTypeKey, @(type), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UINavigationBar *)customNavBar {
    UINavigationBar *navBar = objc_getAssociatedObject(self, &customNavBarKey);
    return navBar;
}

- (void)setCustomNavBar:(UINavigationBar *)navBar {
    objc_setAssociatedObject(self, &customNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)removeCustomNavBar {
    if (self.customNavBar && [self.customNavBar superview]) {
        [self updateNavigationBarType:self.currentType];
        [self.customNavBar removeFromSuperview];
    }
}

- (UIColor *)customTintColor {
    UIColor *color = objc_getAssociatedObject(self, &customTintColorKey);
    return color;
}

- (void)setCustomTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &customTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)towNavBarModel {
    NSNumber *model = objc_getAssociatedObject(self, &towNavBarModelKey);
    return [model boolValue];
}

- (void)setTowNavBarModel:(BOOL)towNavBarModel {
    objc_setAssociatedObject(self, &towNavBarModelKey, @(towNavBarModel), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 上面是自定义分类属性

- (void)setNavigationBarWithType:(FNNavationBarType)type {
    [self setNavigationBarWithType:type animated:YES];
}

- (void)setNavigationBarWithType:(FNNavationBarType)type animated:(BOOL)animated {
    if (!animated) {
        [self updateNavigationBarType:type];
    } else if (([[self.navigationController childViewControllers] firstObject] == self && [self isMovingToParentViewController])) {
        [self updateNavigationBarType:type];
    } else {
        UIViewController * vc = [[self transitionCoordinator] viewControllerForKey:UITransitionContextFromViewControllerKey];
        if ((IOS10 && vc && vc.currentType!=type && type!=FNNavationBarType_Clear) || self.towNavBarModel) {
            // 单独添加navBar处理
            [self updateNavigationBarType:type];
            [self.navigationController.navigationBar jn_setBackgroundAlpha:0];
            [self.navigationController.navigationBar jn_setBottomLineHidden:YES];
            
            [vc addNavigationBarWithType:vc.currentType];
            [self addNavigationBarWithType:type];
            return;
        }
        
        BOOL isAnimate = [[self transitionCoordinator] animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
                                                                            [self updateNavigationBarType:type];
                                                                    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                                                                        if (![context isCancelled]) {
                                                                            [self updateNavigationBarType:type];
                                                                        }
                                                                    }];
        if (isAnimate == NO) {
            [self updateNavigationBarType:type];
        }
    }
}

- (void)updateNavigationBarType:(FNNavationBarType)type {
    UINavigationBar *navBar = nil;
    if ([self isKindOfClass:[UINavigationController class]]) {
        navBar = [(UINavigationController *)self navigationBar];
    } else {
        navBar = self.navigationController.navigationBar;
    }
    [self setCurrentType:type];
    [self updateNavigationBar:navBar withType:type];
}

- (void)updateNavigationBar:(UINavigationBar *)navBar withType:(FNNavationBarType)type {
    [navBar setUserInteractionEnabled:YES];
    if (type == FNNavationBarType_Green) {
        // alpha
        [navBar jn_setBackgroundAlpha:1.];
        // backgroundColor
        [navBar jn_setBackgroundColor:[self barColorTransitionWithColor:[UIColor greenColor]]];
        // botoomLine Hide
        [self setBarBottomLine:navBar hidden:YES];
        // tintColor
        [self setBarTintColor:navBar color:[UIColor whiteColor]];
    } else if (type == FNNavationBarType_Clear) {
        [navBar jn_setBackgroundAlpha:0.];
        [navBar jn_setBackgroundColor:[UIColor whiteColor]];
        [self setBarBottomLine:navBar hidden:YES];
        [self setBarTintColor:navBar color:[UIColor whiteColor]];
    } else if (type == FNNavationBarType_Black) {
        [navBar jn_setBackgroundAlpha:0.95];
        [navBar jn_setBackgroundColor:[self barColorTransitionWithColor:UIColorFromRGB(0x424242)]];
        [self setBarBottomLine:navBar hidden:YES];
        [self setBarTintColor:navBar color:[UIColor whiteColor]];
    } else {
        [navBar jn_setBackgroundAlpha:0.95];
        [navBar jn_reset];
        [self setBarTintColor:navBar color:UIColorFromRGB(0x666666) titleColor:UIColorFromRGB(0x111111)];
        [self setBarBottomLine:navBar hidden:NO];
    }
    
    if (self.customTintColor) {
        [self setBarTintColor:navBar color:self.customTintColor];
    }
}

// 添加自定义导航栏用于ios10的过度
- (void)addNavigationBarWithType:(FNNavationBarType)type
{
    if (!self.customNavBar) {
        self.customNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, ([UIScreen mainScreen].bounds.size.width), 64)];
    }
    
    // 10上白色透明导航栏后面出现黑色的问题 16-11-19 yuchenghai
    if (IOS10 && type==FNNavationBarType_Normal) {
        self.customNavBar.translucent = NO;
    }
    [self updateNavigationBar:self.customNavBar withType:type];

    [self.view addSubview:self.customNavBar];
}


- (void)setBarTintColor:(UINavigationBar *)navBar color:(UIColor *)color {
    [self setBarTintColor:navBar color:color titleColor:color];
}

- (void)setBarTintColor:(UINavigationBar *)navBar color:(UIColor *)color titleColor:(UIColor *)titleColor {
    [navBar setTintColor:color];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:titleColor, NSForegroundColorAttributeName, [UIFont boldSystemFontOfSize:DefaultTitleSize], NSFontAttributeName, nil];
    [navBar setTitleTextAttributes:attributes];
}

- (void)setBarBottomLine:(UINavigationBar *)navBar hidden:(BOOL)isHidden {
    [navBar jn_setBottomLineHidden:isHidden];
}

- (UIColor *)barColorTransitionWithColor:(UIColor *)color {
    
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    CGFloat opacity = 0.4;
    
    CGFloat minVal = MIN(MIN(red, green), blue);
    
    if ([self convertValue:minVal withOpacity:opacity] < 0) {
        opacity = [self minOpacityForValue:minVal];
    }
    
    red = [self convertValue:red withOpacity:opacity];
    green = [self convertValue:green withOpacity:opacity];
    blue = [self convertValue:blue withOpacity:opacity];
    
    red = MAX(MIN(1.0, red), 0);
    green = MAX(MIN(1.0, green), 0);
    blue = MAX(MIN(1.0, blue), 0);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.];
}

- (CGFloat)minOpacityForValue:(CGFloat)value
{
    return (0.4 - 0.4 * value) / (0.6 * value + 0.4);
}

- (CGFloat)convertValue:(CGFloat)value withOpacity:(CGFloat)opacity
{
    return 0.4 * value / opacity + 0.6 * value - 0.4 / opacity + 0.4;
}

@end
