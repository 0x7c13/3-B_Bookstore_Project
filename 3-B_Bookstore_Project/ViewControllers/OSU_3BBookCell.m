//
//  OSU_3BBookCell.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_3BBookCell.h"
#import "OSU_3BShoppingCart.h"

@implementation OSU_3BBookCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)addToCartButtonPressed:(UIButton *)sender {

    [[OSU_3BShoppingCart sharedInstance] addItem:self.book withQuantity:1];
    
    self.addToCartButton.userInteractionEnabled = NO;
    [self.addToCartButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.checkMark.alpha = 1.0;

    [self.delegate userDidPressAddToCartButton:self];

    
}

- (IBAction)reviewsButtonPressed:(UIButton *)sender {
 
    popoverReviews = [PopoverView showPopoverAtPoint:CGPointMake(25, 0)
                                              inView:self.reviewsButton.viewForBaselineLayout
                                            withText:self.bookReviews delegate:self];
    
    [self.delegate userDidPressReviewsButton:self];
}

@end
