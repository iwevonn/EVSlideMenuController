//
//  EVSlideMenuController.m
//  EVSlideMenuController
//
//  Created by iwevon on 16/7/23.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import "EVSlideMenuController.h"
#import "EVCustomItem.h"

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


CGFloat const kSlideMenuControllerMenuButtonWidth = 80.0f;
CGFloat const kSlideMenuControllerMenuScrollViewHeight = 40.0f;
CGFloat const kSlideMenuControllerMenuBgViewHeight = 2.0f;
CGFloat const kSlideMenuControllerMenuBgViewMargin = 30.0f;

@interface EVSlideMenuController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;

/** menu视图 */
@property (weak, nonatomic) UIScrollView *menuScrollView;
/** 内容视图 */
@property (weak, nonatomic) UIScrollView *scrollView;
/** menu背景视图 */
@property (weak, nonatomic) UIView *menuBgView;

@end

@implementation EVSlideMenuController

#pragma mark public

+ (instancetype)slideMenuControllerWithMenuArray:(NSArray *)menuArray
                                       menuWidth:(CGFloat)menuWidth
                                normalTitleColor:(UIColor *)normalColor
                                selectTitleColor:(UIColor *)selectColor {
    
    EVSlideMenuController *slideMenuController = [[self alloc] init];
    slideMenuController.menuWidth = menuWidth?:kSlideMenuControllerMenuButtonWidth;
    slideMenuController.normalColor = normalColor?:[UIColor grayColor];
    slideMenuController.selectColor = selectColor?:[UIColor redColor];
    [slideMenuController setMenuArray:menuArray];
    [slideMenuController menuBgView]; //显示menu背景视图
    slideMenuController.scrollsToTop = YES;
    return slideMenuController;
}

- (void)setMenuArray:(NSArray *)menuArray {
    if (_menuArray == menuArray) return;
    
    if (_menuArray.count) { //移除enum中原来的item
        for (int i = 0; i < self.itemArray.count; i++) {
            UIView *view = self.itemArray[i];
            [view removeFromSuperview];
        }
        self.itemArray = nil;
    }
    
    _menuArray = menuArray;
    NSMutableArray *tempButtonArr = [NSMutableArray array];
    for (int i = 0; i < _menuArray.count; i ++) {
        EVCustomItem *menu = [[EVCustomItem alloc] init];
        [menu setFrame:CGRectMake(self.menuWidth * i, 0, self.menuWidth, self.menuScrollView.frame.size.height)];
        menu.title = menuArray[i];
        menu.titleColor = self.normalColor?:[UIColor darkGrayColor];
        menu.titleLabel.font = [UIFont systemFontOfSize:14.0];
        menu.tag = i;
        [menu addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        [self.menuScrollView addSubview:menu];
        [tempButtonArr addObject:menu];
    }
    self.itemArray = [NSArray arrayWithArray:tempButtonArr];
    
    [self.menuScrollView setContentSize:CGSizeMake(self.menuWidth * _menuArray.count, self.menuScrollView.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _menuArray.count, self.scrollView.frame.size.height);
}

- (void)setTableViewArray:(NSArray *)tableViewArray {
    if (_tableViewArray == tableViewArray) return;
    
    if (_tableViewArray.count) { //移除enum中原来的item
        for (int i = 0; i < _tableViewArray.count; i++) {
            UIView *view = _tableViewArray[i];
            [view removeFromSuperview];
        }
    }
    _tableViewArray = tableViewArray;
    
    for (int i = 0; i < _tableViewArray.count; i ++) {
        UITableView *tableView = _tableViewArray[i];
        tableView.frame = CGRectMake(SCREEN_WIDTH * i, 0 , SCREEN_WIDTH, SCREEN_HEIGHT - self.menuScrollView.frame.size.height - 64);
        [self.scrollView addSubview:tableView];
    }
}

- (void)setScrollsToTop:(BOOL)scrollsToTop {
    _scrollsToTop = scrollsToTop;
    self.scrollView.scrollsToTop = self.menuScrollView.scrollsToTop = !scrollsToTop;
}

#pragma mark Getter

//menu视图
- (UIScrollView *)menuScrollView {
    if (!_menuScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kSlideMenuControllerMenuScrollViewHeight)];
        [self.view addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        _menuScrollView = scrollView;
    }
    return _menuScrollView;
}

//内容视图
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat scrollViewH = SCREEN_HEIGHT - kSlideMenuControllerMenuScrollViewHeight;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kSlideMenuControllerMenuScrollViewHeight, SCREEN_WIDTH, scrollViewH)];
        [self.view addSubview:scrollView];
        scrollView.delegate = self;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        _scrollView = scrollView;
    }
    return _scrollView;
}

//menu背景视图
- (UIView *)menuBgView {
    if (!_menuBgView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.menuScrollView.frame.size.height - kSlideMenuControllerMenuBgViewHeight, self.menuWidth, kSlideMenuControllerMenuBgViewHeight)];
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(kSlideMenuControllerMenuBgViewMargin*0.5, 0, view.frame.size.width-kSlideMenuControllerMenuBgViewMargin, view.frame.size.height)];
        [subView setBackgroundColor:self.selectColor];
        [view addSubview:subView];
        [self.menuScrollView addSubview:view];
        _menuBgView = view;
    }
    return _menuBgView;
}


#pragma mark viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}


#pragma mark private

- (void)selectMenu:(UIButton *)sender {
    NSInteger index = sender.tag;
    [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0) animated:YES];
    CGFloat xx = SCREEN_WIDTH * (index - 1) * (self.menuWidth / SCREEN_WIDTH) - self.menuWidth;
    [self.menuScrollView scrollRectToVisible:CGRectMake(xx, 0, SCREEN_WIDTH, self.menuScrollView.frame.size.height) animated:YES];
    [self setSelectedIndex:index];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if ( selectedIndex >= self.itemArray.count ||
        self.itemArray.count == 0 ||
        selectedIndex < 0) {
        return;
    }
    //设置点击状态栏回到顶部
    for (int i=0; i<self.tableViewArray.count; i++) {
        UITableView *tableView = self.tableViewArray[i];
        tableView.scrollsToTop = (selectedIndex==i)?self.scrollsToTop:NO;
    }
    
    //替换颜色
    EVCustomItem *oldItem = self.itemArray[_selectedIndex];
    oldItem.titleColor = self.normalColor;
    EVCustomItem *newItem = self.itemArray[selectedIndex];
    newItem.titleColor = self.selectColor;
    
    _selectedIndex = selectedIndex;
    NSAssert(_selectedIndex<=self.tableViewArray.count, @"Data does not match");
    self.refreshTableView = self.tableViewArray[_selectedIndex];
    CGPoint offsetPoint = CGPointMake(SCREEN_WIDTH * _selectedIndex, 0);
    [self.scrollView setContentOffset:offsetPoint animated:YES];
    self.menuTittle = self.menuArray[_selectedIndex];
    self.title = self.menuTittle;
    [self.refreshTableView reloadData];
}

- (void)changeView:(CGFloat)x {
    CGFloat xx = x * (self.menuWidth / SCREEN_WIDTH);
    [self.menuBgView setFrame:CGRectMake(xx, self.menuBgView.frame.origin.y, self.menuBgView.frame.size.width, self.menuBgView.frame.size.height)];
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //只要滚动了就会触发
    if (self.scrollView != scrollView) return;
    [self changeView:scrollView.contentOffset.x];
    
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scrollViewWidth = scrollView.frame.size.width;
    if (offsetX < 0) return;
    if (offsetX > scrollView.contentSize.width - scrollViewWidth) return;
    
    NSInteger leftIndex = offsetX / scrollViewWidth;
    NSInteger rightIndex = leftIndex + 1;
    EVCustomItem *leftItem = self.itemArray[leftIndex];
    EVCustomItem *rightItem = nil;
    if (rightIndex < self.itemArray.count) {
        rightItem = self.itemArray[rightIndex];
    }
    
    // 计算右边按钮偏移量
    CGFloat rightScale = offsetX / scrollViewWidth;
    // 只想要 0~1
    rightScale = rightScale - leftIndex;
    CGFloat leftScale = 1 - rightScale;
    
    if (scrollView.isDragging || scrollView.isDecelerating) {
    
        CGFloat normalRed, normalGreen, normalBlue;
        CGFloat selectedRed, selectedGreen, selectedBlue;
        
        [self.normalColor getRed:&normalRed green:&normalGreen blue:&normalBlue alpha:nil];
        [self.selectColor getRed:&selectedRed green:&selectedGreen blue:&selectedBlue alpha:nil];
        // 获取选中和未选中状态的颜色差值
        CGFloat redDiff = selectedRed - normalRed;
        CGFloat greenDiff = selectedGreen - normalGreen;
        CGFloat blueDiff = selectedBlue - normalBlue;
        // 根据颜色值的差值和偏移量，设置tabItem的标题颜色
        UIColor *leftColor = [UIColor colorWithRed:leftScale * redDiff + normalRed
                                                        green:leftScale * greenDiff + normalGreen
                                                         blue:leftScale * blueDiff + normalBlue
                                                        alpha:1];
        leftItem.titleColor = leftColor;
    
        UIColor *rightColor = [UIColor colorWithRed:rightScale * redDiff + normalRed
                                                         green:rightScale * greenDiff + normalGreen
                                                          blue:rightScale * blueDiff + normalBlue
                                                         alpha:1];
        rightItem.titleColor = rightColor;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //减速停止了时执行，手触摸时执行执行
    if (self.scrollView != scrollView) return;
    CGFloat xx = scrollView.contentOffset.x * (self.menuWidth / SCREEN_WIDTH) - self.menuWidth;
    [self.menuScrollView scrollRectToVisible:CGRectMake(xx, 0, SCREEN_WIDTH, self.menuScrollView.frame.size.height) animated:YES];
    [self setSelectedIndex:scrollView.contentOffset.x / SCREEN_WIDTH];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
