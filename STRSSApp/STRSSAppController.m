//
//  STRSSAppController.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 3..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSAppController.h"

static STRSSAppController* _sharedInstance;


@implementation STRSSAppController

+ (STRSSAppController*)sharedInstance
{
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if ( !self ) {
        return nil;
    }
    _sharedInstance = self;
    return self;
}

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // load
    

    return YES;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    // load
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    //save
}
@end
