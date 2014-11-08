//
//  STRSSFeedViewController.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSFeedViewController.h"
#import "STRSSChannel.h"

@interface STRSSFeedViewController ()

@end

@implementation STRSSFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setToolbarHidden:YES];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_addFeedItem) {
        [self _updateNavigationItem:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_updateNavigationItem:(BOOL)animated
{
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
    
    [self.navigationItem setLeftBarButtonItem:cancelItem];
    [self.navigationItem setRightBarButtonItem:saveItem];
}

- (void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAction
{
    STRSSChannel *channel = [[STRSSChannel alloc] init];
    channel.title = _titleTxt.text;
    channel.feedUrlString = _feedUrlTxtView.text;
    [[STRSSChannelManager sharedManager] addChannel:channel];
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
