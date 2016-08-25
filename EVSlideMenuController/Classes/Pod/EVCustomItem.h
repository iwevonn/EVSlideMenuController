//
//  EVCustomItem.m
//  EVSlideMenuController
//
//  Created by iwevon on 16/7/23.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Badge样式
 */
typedef NS_ENUM(NSInteger, EVCustomItemBadgeStyle) {
    EVCustomItemBadgeStyleNumber = 0, // 数字样式
    EVCustomItemBadgeStyleDot = 1, // 小圆点
};


#pragma mark - 数据模型

@interface EVCustomItemModel : NSObject

/** normal图片名 */
@property (nonatomic, copy) NSString *norImageName;
/** selected图片名 */
@property (nonatomic, copy) NSString *selImageName;
/** title */
@property (nonatomic, copy) NSString *title;

/**
 *  实例化对象
 *
 *  @param norImageName normal图片名
 *  @param selImageName selected图片名
 *  @param title        title
 */
+ (instancetype)EVCustomItemModelWithNorImageName:(NSString *)norImageName
                                   selImageName:(NSString *)selImageName
                                          title:(NSString *)title;
@end


#pragma mark - 控件
//IB_DESIGNABLE
@interface EVCustomItem : UIButton

/**
 *  item在tabBar中的index，此属性不能手动设置
 */
@property (nonatomic, assign) NSInteger index;

/**
 *  用于记录Item在缩放前的frame，
 *  在TopMenuTabBar的属性itemFontChangeFollowContentScroll == YES时会用到
 */
@property (nonatomic, assign, readonly) CGRect frameWithOutTransform;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *titleSelectedColor;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, assign) CGFloat titleAndImageMargin;

/**
 *  当badgeStyle == EVCustomItemBadgeStyleNumber时，可以设置此属性，显示badge数值
 *  badge > 99，显示99+
 *  badge <= 99 && badge > -99，显示具体数值
 *  badge < -99，显示-99+
 */
@property (nonatomic, assign) NSInteger badge;

/**
 *  badge的样式，支持数字样式和小圆点
 */
@property (nonatomic, assign) EVCustomItemBadgeStyle badgeStyle;

/**
 *  badge的背景颜色
 */
@property (nonatomic, strong) UIColor *badgeBackgroundColor;

/**
 *  badge的背景图片
 */
@property (nonatomic, strong) UIImage *badgeBackgroundImage;

/**
 *  badge的标题颜色
 */
@property (nonatomic, strong) UIColor *badgeTitleColor;

/**
 *  badge的标题字体，默认13号
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;

/**
 *  设置Image和Title水平居中
 */
@property (nonatomic, assign, getter = isContentHorizontalCenter) BOOL contentHorizontalCenter;

/**
 *  设置Image和Title水平居中
 *
 *  @param verticalOffset       竖直方向的偏移量
 *  @param titleAndImageMargin  文字和图片之间的间隙
 *  @param spacing              Image与Title的间距
 */
- (void)setContentHorizontalCenterWithVerticalOffset:(CGFloat)verticalOffset
                                 titleAndImageMargin:(CGFloat)titleAndImageMargin
                                             spacing:(CGFloat)spacing;
/**
 *  添加双击事件回调
 */
- (void)setDoubleTapHandler:(void (^)(void))handler;

/**
 *  设置数字Badge的位置
 *
 *  @param marginTop            与Item顶部的距离
 *  @param centerMarginRight    中心与Item右侧的距离
 *  @param titleHorizonalSpace  标题水平方向的空间
 *  @param titleVerticalSpace   标题竖直方向的空间
 */
- (void)setNumberBadgeMarginTop:(CGFloat)marginTop
              centerMarginRight:(CGFloat)centerMarginRight
            titleHorizonalSpace:(CGFloat)titleHorizonalSpace
             titleVerticalSpace:(CGFloat)titleVerticalSpace;
/**
 *  设置小圆点Badge的位置
 *
 *  @param marginTop            与Item顶部的距离
 *  @param centerMarginRight    中心与Item右侧的距离
 *  @param sideLength           小圆点的边长
 */
- (void)setDotBadgeMarginTop:(CGFloat)marginTop
           centerMarginRight:(CGFloat)centerMarginRight
                  sideLength:(CGFloat)sideLength;

@end
