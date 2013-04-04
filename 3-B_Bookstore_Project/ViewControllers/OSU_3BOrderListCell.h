//
//  OSU_3BOrderListCell.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-3.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSU_3BBook.h"

@interface OSU_3BOrderListCell : UITableViewCell

@property (strong, nonatomic) OSU_3BBook *book;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookPrice;
@property (weak, nonatomic) IBOutlet UILabel *bookQuantity;
@property (weak, nonatomic) IBOutlet UILabel *bookTotalPrice;


@end
