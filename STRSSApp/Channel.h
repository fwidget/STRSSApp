//
//  Channel.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Channel : NSManagedObject

@property (nonatomic, retain) NSString * feedUrlString;
@property (nonatomic, retain) NSString * indentifier;
@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *items;
@end

@interface Channel (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
