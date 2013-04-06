//
//  OSU_insertNewBookViewController.h
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-4-5.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NIDropDown.h"

@interface OSU_insertNewBookViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, NIDropDownDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ISBNField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *authorField;
@property (weak, nonatomic) IBOutlet UITextField *publisherField;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;
@property (weak, nonatomic) IBOutlet UITextField *yearFIeld;
@property (weak, nonatomic) IBOutlet UITextField *priceFIeld;
@property (weak, nonatomic) IBOutlet UITextField *minQtyField;
@property (weak, nonatomic) IBOutlet UITextView *reviewsField;


@end
