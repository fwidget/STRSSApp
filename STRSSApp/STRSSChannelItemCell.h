//
//  STRSSChannelItemCell.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 7..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRSSChannelItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *dateLb;
@property (weak, nonatomic) IBOutlet UILabel *postLb;
@property (weak, nonatomic) IBOutlet UIView *markView;
@end
