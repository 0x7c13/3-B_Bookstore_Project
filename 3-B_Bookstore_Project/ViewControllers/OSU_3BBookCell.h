//
//  OSU_3BBookCell.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OSU_3BBookCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *bookTitle;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthor;
@property (strong, nonatomic) IBOutlet UILabel *bookPublisher;
@property (strong, nonatomic) IBOutlet UILabel *bookISBN;
@property (strong, nonatomic) IBOutlet UILabel *bookPrice;

@end
