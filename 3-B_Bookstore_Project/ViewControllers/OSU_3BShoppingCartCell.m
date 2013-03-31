//
//  OSU_3BShoppingCartCell.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-31.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_3BShoppingCartCell.h"
#import "OSU_3BShoppingCart.h"

@implementation OSU_3BShoppingCartCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _quantityStepper.minimumValue = 1.0;
        _quantityStepper.value = (double)self.book.Quantity;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)deleteButtonPressed:(UIButton *)sender {
    [self.delegate userDidPressDeleteButton:self];
}


- (IBAction)stepperPressed:(UIStepper *)sender {
    
    double value = [sender value];
    
    [[OSU_3BShoppingCart sharedInstance] changeQuantityOfItem:self.book withQuantity:(NSUInteger)value];
    self.book.Quantity = (NSUInteger)value;
    
    self.bookQuantity.text = [NSString stringWithFormat:@"%u", (NSInteger)self.book.Quantity];
    
    [self.delegate userDidPressStepper:self];
}


@end
