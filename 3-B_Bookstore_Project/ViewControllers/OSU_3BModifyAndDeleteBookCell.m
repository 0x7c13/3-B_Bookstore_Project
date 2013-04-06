//
//  OSU_3BModifyAndDeleteBookCell.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-6.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import "OSU_3BModifyAndDeleteBookCell.h"

@implementation OSU_3BModifyAndDeleteBookCell

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

- (IBAction)deleteButtonPressed:(UIButton *)sender
{
    self.deleteButton.userInteractionEnabled = NO;
    [self.deleteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.updateButton.userInteractionEnabled = NO;
    [self.updateButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.deletedLabel.alpha = 1.0;
    
    [self.delegate userDidPressDeleteButton:self];
}



- (IBAction)updateButtonPressed:(UIButton *)sender
{

    [self.delegate userDidPressUpdateButton:self];
}
     
@end
