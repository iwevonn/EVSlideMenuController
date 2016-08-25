//
//  ViewController.m
//  EVEVSlideMenuController
//
//  Created by iwevon on 16/8/10.
//  Copyright © 2016年 iwevon. All rights reserved.
//

#import "ViewController.h"
#import "TableViewWithBlock.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - public
//刷新数据
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    TableViewWithBlock *tableView = self.tableViewArray[selectedIndex];
    [tableView reloadData];
}


//设置显示列表
- (void)setMenuArray:(NSArray *)menuArray {//MenuArray:(NSArray *)menuArray {
    [super setMenuArray:menuArray];
    //设置tableView数据
    self.tableViewArray = [self tableViewArrayWithTitleArray:menuArray];
}


/**
 *  设置tableView
 */
- (NSArray *)tableViewArrayWithTitleArray:(NSArray *)titleArray {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    //设置tableview
    for (int i=0; i<titleArray.count; i++) {
        TableViewWithBlock *tableView = [TableViewWithBlock tableViewWithFrame:CGRectZero style:UITableViewStylePlain setNumOfSectionsBlock:^NSInteger(UITableView *tableView) {
            return 1;
        } setNumOfRowsBlock:^NSInteger(UITableView *tableView, NSInteger section) {
            return 100;
        } setCellForIndexPathBlock:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            static NSString *identifierCell  = @"identifierCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %ld", titleArray[i], indexPath.row];
            return cell;
        } setDidSelectRowBlock:^(UITableView *tableView, NSIndexPath *indexPath) {
            NSString *strPrint = [NSString stringWithFormat:@"%@ - %ld", titleArray[i], indexPath.row];
            NSLog(@"%@", strPrint);
        } setHeightForRowBlock:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            return 60;
        }];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tempArray addObject:tableView];
    }
    return tempArray;
}



@end
