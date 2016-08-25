//
//  TableViewWithBlock.h
//  ComboBox
//
//  Created by Eric Che on 7/17/13.
//  Copyright (c) 2013 Eric Che. All rights reserved.
//

#import "UITableView+DataSourceBlocks.h"
#import "UITableView+DelegateBlocks.h"

@interface TableViewWithBlock : UITableView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)UITableViewNumberOfSectionsInTableViewBlock numberOfSectionsInTableViewBlock;
@property(nonatomic,copy)UITableViewNumberOfRowsInSectionBlock numberOfRowsInSectionBlock;
@property(nonatomic,copy)UITableViewCellForRowAtIndexPathBlock cellForRowAtIndexPath;
@property(nonatomic,copy)UITableViewDidDeselectRowAtIndexPathBlock didDeselectRowAtIndexPathBlock;
@property(nonatomic,copy)UITableViewHeightForRowAtIndexPathBlock heightForRowAtIndexPathBlock;
@property(nonatomic,copy)UITableViewHeightForHeaderInSectionBlock heightForHeaderInSectionBlock;





+ (instancetype)tableViewWithFrame:(CGRect)frame
                             style:(UITableViewStyle)style
             setNumOfSectionsBlock:(UITableViewNumberOfSectionsInTableViewBlock)numOfSectionsBlock
                 setNumOfRowsBlock:(UITableViewNumberOfRowsInSectionBlock)numOfRowsBlock
          setCellForIndexPathBlock:(UITableViewCellForRowAtIndexPathBlock)cellForIndexPathBlock
              setDidSelectRowBlock:(UITableViewDidSelectRowAtIndexPathBlock)didSelectRowBlock
              setHeightForRowBlock:(UITableViewHeightForRowAtIndexPathBlock)heightForRowBlock;

@end
