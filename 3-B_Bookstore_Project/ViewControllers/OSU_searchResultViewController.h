//
//  OSU_searchResultViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSU_3BBook.h"
#import "OSU_3BBooks.h"

@interface OSU_searchResultViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) OSU_3BBooks *resultBooks;
@property (strong, nonatomic) IBOutlet UITableView *resultTable;

@end
