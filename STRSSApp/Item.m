//
//  Item.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 4..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "Item.h"


@implementation Item

@dynamic title;
@dynamic link;
@dynamic identifier;
@dynamic itemDescription;
@dynamic pubDate;
@dynamic read;
@dynamic channel;

- (BOOL)read
{
    BOOL read;
    [self willAccessValueForKey:@"read"];
    read = [[self primitiveValueForKey:@"read"] boolValue];
    [self didAccessValueForKey:@"read"];
    
    return read;
}

- (void)read:(BOOL)read
{
    [self willChangeValueForKey:@"read"];
    [self setPrimitiveValue:[NSNumber numberWithBool:read] forKey:@"read"];
    [self didChangeValueForKey:@"read"];
}


@end
