//
//  OSU_searchResultViewController.m
//  CSE3241_Bookstore_Project
//
//  Created by FlyinGeek on 13-3-29.
//  Copyright (c) 2013年 The Ohio State University. All rights reserved.
//

#import "OSU_searchResultViewController.h"
#import "OSU_3BBookCell.h"

@interface OSU_searchResultViewController ()

@end

@implementation OSU_searchResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.resultTable.delegate = self;
    self.resultTable.dataSource = self;
    
    for (int i = 0; i < self.resultBooks.count; i++) {
        [self.resultBooks[i] print];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// protocols ***********************************************

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultBooks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSU_3BBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookCell"];
    
    cell.bookTitle.text = [self.resultBooks objectAtIndexedSubscript:indexPath.row].Titile;
    cell.bookAuthor.text = [self.resultBooks objectAtIndexedSubscript:indexPath.row].Author;
    cell.bookPublisher.text = [self.resultBooks objectAtIndexedSubscript:indexPath.row].Publisher;
    cell.bookISBN.text = [self.resultBooks objectAtIndexedSubscript:indexPath.row].ISBN;
    cell.bookPrice.text = [NSString stringWithFormat:@"$ %.2f",[self.resultBooks objectAtIndexedSubscript:indexPath.row].Price];
    return cell;
}

@end
