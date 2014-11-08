//
//  Item.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSString * pubDate;
//@property (nonatomic, retain) NSNumber * read;
@property (nonatomic) BOOL read; // NSNumber형식을 불린형으로 변형
@property (nonatomic, retain) NSManagedObject *channel;

@end
