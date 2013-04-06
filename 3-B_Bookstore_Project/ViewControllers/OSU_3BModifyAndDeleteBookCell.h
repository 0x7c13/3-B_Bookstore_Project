//
//  OSU_3BModifyAndDeleteBookCell.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-6.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSU_3BBook.h"


@protocol OSU_3BModifyAndDeleteBookCellDelegate;

@interface OSU_3BModifyAndDeleteBookCell : UITableViewCell

@property (strong, nonatomic) OSU_3BBook *book;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UILabel *bookPublisher;
@property (weak, nonatomic) IBOutlet UILabel *bookPrice;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UILabel *deletedLabel;


@property (weak, nonatomic) id<OSU_3BModifyAndDeleteBookCellDelegate> delegate;

@end


@protocol OSU_3BModifyAndDeleteBookCellDelegate <NSObject>

- (void)userDidPressDeleteButton:(OSU_3BModifyAndDeleteBookCell *)cell;
- (void)userDidPressUpdateButton:(OSU_3BModifyAndDeleteBookCell *)cell;

@end
