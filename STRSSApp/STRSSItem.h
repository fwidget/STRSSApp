//
//  STRSSItem.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STRSSItem : NSObject <NSCoding>

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, getter=isRead) BOOL read;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *pubDate;

@end
