//
//  STRSSFeedViewController.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSFeedViewController.h"
#import "STRSSChannel.h"
#import "STRSSFeedListViewController.h"

@interface STRSSFeedViewController ()

@end

@implementation STRSSFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_addFeedItem) {
        self.title = @"Add Feed Info";
        [self _updateNavigationbarItems:YES];
        _titleTxt.enabled = YES;
        _titleTxt.clearButtonMode = UITextFieldViewModeWhileEditing;
        _feedUrlTxtView.editable = YES;
        [self.navigationController setToolbarHidden:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_currentChannel) {
        _titleTxt.text = _currentChannel.title;
        _feedUrlTxtView.text = _currentChannel.feedUrlString;
    }
}

- (IBAction)actionEditBarButtonItemInToolbar
{
    UIBarButtonItem *buttonitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionDoneButtonItemInToolbar)];
    [self _updateToolbarItems:[NSArray arrayWithObjects:buttonitem, nil] animated:YES];
}

- (void)actionDoneButtonItemInToolbar
{
    UIBarButtonItem *buttonitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEditBarButtonItemInToolbar)];
    [self _updateToolbarItems:[NSArray arrayWithObjects:buttonitem, nil] animated:YES];
}

- (void)_updateToolbarItems:(NSArray *)items animated:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:animated];
    [self setToolbarItems:items animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_updateNavigationbarItems:(BOOL)animated
{
    UIBarButtonItem *cancelBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(actionCancelBarButtonItemInNavigationbar)];
    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(actionSaveBarButtonItemInNavigationbar)];
    
    [self.navigationItem setLeftBarButtonItem:cancelBarButtonItem];
    [self.navigationItem setRightBarButtonItem:saveBarButtonItem];
}

- (void)actionCancelBarButtonItemInNavigationbar
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)actionSaveBarButtonItemInNavigationbar
{
    STRSSChannel *channel = [[STRSSChannel alloc] init];
    channel.title = _titleTxt.text;
    channel.feedUrlString = _feedUrlTxtView.text;
    channel.link = _feedUrlTxtView.text;
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
