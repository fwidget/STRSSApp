//
//  STRSSChannel.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRSSChannel : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, strong) NSString *feedUrlString;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;

@property (nonatomic, readonly) NSMutableArray *items;

@end
