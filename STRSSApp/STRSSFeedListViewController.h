//
//  STRSSFeedListViewController.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRSSFeedListViewController : UIViewController < UITableViewDataSource, UITableViewDelegate >
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addBarButtonItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *feeds;
@end
