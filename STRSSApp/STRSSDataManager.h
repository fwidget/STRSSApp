//
//  STRSSDataManager.h
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Item.h"
#import "Channel.h"

@interface STRSSDataManager : NSObject

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, readonly) NSArray *sortedChannels;

+ (STRSSDataManager *)sharedInstance;

- (Item *)insertNewItem;
- (Channel *)insertNewChannel;
- (void)save;

@end
