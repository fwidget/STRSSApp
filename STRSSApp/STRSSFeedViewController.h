//
//  STRSSFeedViewController.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRSSFeedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTxt;
@property (weak, nonatomic) IBOutlet UITextView *feedUrlTxtView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarButtonItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) STRSSChannel *channel;
@property (nonatomic) BOOL addFeedItem;
@end
