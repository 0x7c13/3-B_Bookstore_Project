//
//  OSU_searchResultViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "OSU_3BBook.h"
#import "OSU_3BBooks.h"
#import "OSU_3BBookCell.h"
#import "PopoverView.h"

@interface OSU_searchResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, OSU_3BBookCellDelegate> 

@property (weak, nonatomic) IBOutlet UILabel *shoppingCartInfo;
@property (strong, nonatomic) OSU_3BBooks *resultBooks;
@property (weak, nonatomic) IBOutlet UITableView *resultTable;
@property (weak, nonatomic) IBOutlet UIView *labelBG;

@end
