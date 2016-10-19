//
//  UINavigationBar+Awesome.m
//  JNNavigation
//
//  Created by Jonear on 16-2-15.
//  Copyright (c) 2015 Jonear. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

#define IOS10 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 10.0)

@implementation UINavigationBar (Awesome)
static char overlayKey;

- (UIView *)overlay
{
    UIView *view = objc_getAssociatedObject(self, &overlayKey);
    if (!view) {
        NSString *backgroundViewClass = @"_UINavigationBarBackground";
        if (IOS10) {
            backgroundViewClass = @"_UIBarBackground";
        }
        for (UIView * subView in self.subviews) {
            if ([subView isKindOfClass:NSClassFromString(backgroundViewClass)]) {
                [self setOverlay:subView];
                return subView;
            }
        }
    }
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)jn_setBackgroundColor:(UIColor *)backgroundColor
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setBarTintColor:backgroundColor];
}

- (void)jn_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)jn_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
//    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)jn_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self setBarTintColor:[UIColor whiteColor]];
}

- (void)jn_setBackgroundAlpha:(CGFloat)alpha {
    [self.overlay setAlpha:alpha];
}

- (void)jn_setBottomLineHidden:(BOOL)isHidden {
    [self yxhideBottomLine:isHidden];
}


static char UINavigationBarBottomLine;
- (void)yxhideBottomLine:(BOOL)hidden
{
    id existedLine = objc_getAssociatedObject(self, &UINavigationBarBottomLine);
    if (![existedLine isKindOfClass:[UIImageView class]] || ![existedLine superview])
    {
        //判断superView是因为在点公众号搜索的时候，navbar会往上隐藏  当再次出现的时候 bar里的subview就是新的了。。
        UIImageView *imageView = [self yxBottomLine:self];
        if (imageView)
        {
            existedLine = imageView;
            objc_setAssociatedObject(self, &UINavigationBarBottomLine, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        else
        {
            existedLine = nil;
        }
    }
    // 由于要替换默认底部的横线，所以需要吧横线默认设置为隐藏
    [(UIImageView *)existedLine setHidden:YES];
    UIView *bottomView;
    bottomView = [self viewWithTag:100];
    
    if (![bottomView isKindOfClass:[UIImageView class]])
    {
        UIImage     *image           = [UIImage imageNamed:@"icon_nav_Bottom_line"];
        UIImageView *bottomImageView = [[UIImageView alloc] initWithImage:image];
        bottomImageView.tag          = 100;
        bottomImageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        bottomImageView.frame        = CGRectMake(0, self.frame.size.height, ([UIScreen mainScreen].bounds.size.width), image.size.height);
        [self addSubview:bottomImageView];
        bottomView = bottomImageView;
    }
    
    //    bottomView.hidden = hidden;
    bottomView.alpha = hidden?0:1;
    [bottomView setHidden:hidden];
}

- (UIImageView *)yxBottomLine:(UIView *)view
{
    if ([view isKindOfClass:[UIImageView class]] &&
        view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subView in view.subviews)
    {
        UIImageView *imageView = [self yxBottomLine:subView];
        if (imageView)
        {
            return imageView;
        }
    }
    return nil;
}
@end
