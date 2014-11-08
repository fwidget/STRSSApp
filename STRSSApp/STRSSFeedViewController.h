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
@property (nonatomic) BOOL addFeedItem;
@end
