//
//  EVSlideMenuController.h
//  EVSlideMenuController
//
//  Created by iwevon on 16/7/23.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVSlideMenuController : UIViewController

/** TabItem数组 */
@property (nonatomic, strong) NSArray *itemArray;
/** menu数据 */
@property (strong, nonatomic) NSArray *menuArray;
/** menu宽度 */
@property (nonatomic, assign) NSInteger menuWidth;
/** 当前显示的tableView */
@property (weak, nonatomic) UITableView *refreshTableView;
/** tableView数据 */
@property (strong, nonatomic) NSArray *tableViewArray;
/** 当前选中的文字 */
@property (copy, nonatomic) NSString *menuTittle;
/** 选中的下标 */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 点击状态栏回到顶部 */
@property (nonatomic, assign) BOOL scrollsToTop;  // default is YES.

+ (instancetype)slideMenuControllerWithMenuArray:(NSArray *)menuArray
                                       menuWidth:(CGFloat)menuWidth
                                normalTitleColor:(UIColor *)normalColor
                                selectTitleColor:(UIColor *)selectColor;

@end
