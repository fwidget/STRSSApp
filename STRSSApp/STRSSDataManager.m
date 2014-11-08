//
//  STRSSDataManager.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSDataManager.h"
#import <CoreData/CoreData.h>

@implementation STRSSDataManager

@synthesize managedObjectContext = _managedObjectContext; // 외부에서는 readOnly로 내부에서 사용하기 위해 synthesize이용

- (void)save
{
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Save Error, %@", [error localizedDescription]);
    }
}

- (NSArray *)sortedChannels
{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Channel" inManagedObjectContext:context];
    [request setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"executeFetchRequest : failed, %@", [error localizedDescription]);
        return nil;
    }

    return result;
}

- (NSManagedObjectContext*)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil]; //bundle에 nil경우에는 기본적인 현재 사용중인 번들이 설정됨
    
    NSPersistentStoreCoordinator *persistenStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    NSURL *url;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    if (paths.count > 0) {
        NSString *path = paths.firstObject;
        path = [path stringByAppendingPathComponent:@".rss"];
        path = [path stringByAppendingPathComponent:@"strss.db"];
        // 위에 패스를 2단으로 한 이유는 1단일 경우에는 도큐멘트 폴더내에 해당 파일이 보일 가능성이 있어서임
        url = [NSURL fileURLWithPath:path];
    }
    
    NSError *error;
    NSPersistentStore *persistentStore = [persistenStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    if (!persistentStore || error) {
        NSLog(@"Failed to create add persitent store, %@", [error localizedDescription]);
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:persistenStoreCoordinator];
    return _managedObjectContext;
    
}

#pragma mark -
- (Item *)insertNewItem
{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *identifier = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
    CFRelease(uuid);
    item.identifier = identifier;
    return item;
}


- (Channel *)insertNewChannel
{
    NSManagedObjectContext *context = self.managedObjectContext;
    
    Channel *channel = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:context];
    
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *identifier = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
    CFRelease(uuid);
    channel.indentifier = identifier;
    
    //TODO:index설정 필요
    /*
     index
     */
    
    return channel;
}

@end
