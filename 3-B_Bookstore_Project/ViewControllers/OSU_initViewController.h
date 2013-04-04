//
//  OSUViewController.h
//  3-B_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-26.
//  Copyright (c) 2013 The Ohio State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "OSU_searchViewController.h"
#import "OSU_newCustomerViewController.h"
#import "ASDepthModalViewController.h"

@interface OSU_initViewController : UIViewController <OSU_newCustomerViewControllerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *popupView;

@end
