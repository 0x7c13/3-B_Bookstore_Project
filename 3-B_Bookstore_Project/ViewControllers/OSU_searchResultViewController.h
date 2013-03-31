//
//  OSU_searchResultViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "OSU_3BBook.h"
#import "OSU_3BBooks.h"
#import "OSU_3BBookCell.h"

@interface OSU_searchResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, OSU_3BBookCellDelegate>

@property (strong, nonatomic) IBOutlet UILabel *shoppingCartInfo;
@property (strong, nonatomic) OSU_3BBooks *resultBooks;
@property (strong, nonatomic) IBOutlet UITableView *resultTable;
@property (strong, nonatomic) IBOutlet UIView *labelBG;

@end
