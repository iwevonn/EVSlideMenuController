//
//  TableViewWithBlock.m
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//

#import "TableViewWithBlock.h"

@implementation TableViewWithBlock

+ (instancetype)tableViewWithFrame:(CGRect)frame
                             style:(UITableViewStyle)style
             setNumOfSectionsBlock:(UITableViewNumberOfSectionsInTableViewBlock)numOfSectionsBlock
                 setNumOfRowsBlock:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock
          setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock
              setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock
              setHeightForRowBlock:(UITableViewHeightForRowAtIndexPathBlock)heightForRowBlock {
    
    TableViewWithBlock *tableView = [[self alloc] initWithFrame:frame style:style];
    tableView.dataSource=tableView;
    tableView.delegate=tableView;
    tableView.numberOfSectionsInTableViewBlock=numOfSectionsBlock;
    tableView.numberOfRowsInSectionBlock=numOfRowsBlock;
    tableView.cellForRowAtIndexPath=cellForIndexPathBlock;
    tableView.didDeselectRowAtIndexPathBlock=didSelectRowBlock;
    tableView.heightForRowAtIndexPathBlock=heightForRowBlock;
    return tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSectionsInTableViewBlock(tableView);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfRowsInSectionBlock(tableView,section);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellForRowAtIndexPath(tableView,indexPath);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.didDeselectRowAtIndexPathBlock(tableView,indexPath);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.heightForRowAtIndexPathBlock?self.heightForRowAtIndexPathBlock(tableView,indexPath):0;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section  {
    return self.heightForHeaderInSectionBlock?self.heightForHeaderInSectionBlock(tableView,section):0;
}

@end
