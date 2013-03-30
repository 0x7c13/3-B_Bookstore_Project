//
//  OSU_3BBookCell.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSU_3BBook.h"

@protocol OSU_3BBookCellDelegate;

@interface OSU_3BBookCell : UITableViewCell

@property (strong, nonatomic) OSU_3BBook *book;
@property (strong, nonatomic) IBOutlet UILabel *bookTitle;
@property (strong, nonatomic) IBOutlet UILabel *bookAuthor;
@property (strong, nonatomic) IBOutlet UILabel *bookPublisher;
@property (strong, nonatomic) IBOutlet UILabel *bookISBN;
@property (strong, nonatomic) IBOutlet UILabel *bookPrice;

@property (strong, nonatomic) IBOutlet UIButton *addToCartButton;
@property (strong, nonatomic) IBOutlet UIButton *reviewsButton;

@property (weak, nonatomic) id<OSU_3BBookCellDelegate> delegate;

@end


@protocol OSU_3BBookCellDelegate <NSObject>

- (void)userDidPressAddToCartButton:(OSU_3BBookCell *)cell;
- (void)userDidPressReviewsButton:(OSU_3BBookCell *)cell;

@end