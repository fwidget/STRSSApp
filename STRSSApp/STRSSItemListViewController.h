//
//  STRSSItemListViewController.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRSSItemListViewController : UIViewController < UITableViewDelegate, UITableViewDataSource >

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) STRSSChannel *channel;
@property (strong, nonatomic) NSIndexPath *indexPath;
@end
