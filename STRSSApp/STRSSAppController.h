//
//  STRSSAppController.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 3..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class STRSSAppController;

@interface STRSSAppController : NSObject <UIApplicationDelegate>

+ (STRSSAppController*)sharedInstance;

@end
