//
//  OSU_3BBookCell.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSU_3BBook.h"

@protocol OSU_3BBookCellDelegate;

@interface OSU_3BBookCell : UITableViewCell

@property (strong, nonatomic) OSU_3BBook *book;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookPublisher;
@property (weak, nonatomic) IBOutlet UILabel *bookISBN;
@property (weak, nonatomic) IBOutlet UILabel *bookPrice;

@property (weak, nonatomic) IBOutlet UIButton *addToCartButton;
@property (weak, nonatomic) IBOutlet UIButton *reviewsButton;
@property (weak, nonatomic) IBOutlet UIImageView *checkMark;

@property (weak, nonatomic) id<OSU_3BBookCellDelegate> delegate;

@end


@protocol OSU_3BBookCellDelegate <NSObject>

- (void)userDidPressAddToCartButton:(OSU_3BBookCell *)cell;
- (void)userDidPressReviewsButton:(OSU_3BBookCell *)cell;

@end