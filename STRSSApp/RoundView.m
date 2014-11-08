//
//  RoundView.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 7..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "RoundView.h"

@implementation RoundView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.layer.cornerRadius = 10.0f;
}


@end
