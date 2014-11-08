//
//  STRSSFeedListViewController.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRSSFeedListViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneItem;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *feeds;
- (IBAction)editItems:(id)sender;
@end
