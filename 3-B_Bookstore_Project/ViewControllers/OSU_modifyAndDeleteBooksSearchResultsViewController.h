//
//  OSU_modifyAndDeleteBooksSearchResultsViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-6.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "OSU_3BModifyAndDeleteBookCell.h"
#import "OSU_3BBooks.h"

@interface OSU_modifyAndDeleteBooksSearchResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MBProgressHUDDelegate, OSU_3BModifyAndDeleteBookCellDelegate>

@property (strong, nonatomic) OSU_3BBooks *resultBooks;
@property (weak, nonatomic) IBOutlet UITableView *resultTable;


@end
