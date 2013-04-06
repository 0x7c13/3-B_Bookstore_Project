//
//  OSU_updateBookViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-6.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NIDropDown.h"
#import "URBAlertView.h"
#import "OSU_3BBook.h"

@interface OSU_updateBookViewController : UIViewController <NIDropDownDelegate>

@property (strong, nonatomic) OSU_3BBook *currentBook;

@property (weak, nonatomic) IBOutlet UILabel *ISBNLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *authorField;
@property (weak, nonatomic) IBOutlet UITextField *publisherField;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextField *minQtyField;
@property (weak, nonatomic) IBOutlet UITextView *reviewsField;

@end
