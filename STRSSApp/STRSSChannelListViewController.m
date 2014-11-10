//
//  STRSSChannelListViewController.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSChannelListViewController.h"

#import "STRSSChannelCell.h"
#import "STRSSItemListViewController.h"
#import "STRSSFeedListViewController.h"

@interface STRSSChannelListViewController ()

@end

@implementation STRSSChannelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self _updateVisibleCells];
}

- (IBAction)updateAllChannel:(id)sender
{
    [_tableview reloadData];
}

- (IBAction)readAllChannel:(id)sender
{
    NSMutableArray *channels = [STRSSChannelManager sharedManager].channels.mutableCopy;
    for (STRSSChannel *channel in channels) {
        NSMutableArray *items = channel.items;
        for (STRSSItem *item in items) {
            item.read = YES;
        }
    }
    
    [self _updateVisibleCells];
    
    [STRSSChannelManager sharedManager].channels = (NSArray *)channels;
    [[STRSSChannelManager sharedManager] save];
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kStoryBoardSegueIdentifierShowChannelItemList sender:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [STRSSChannelManager sharedManager].channels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = kCellIdentifierChannelCell;
    STRSSChannelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    [self _updateCell:cell atIndexPath:indexPath];
    return cell;
    
}

- (void)_updateCell:(STRSSChannelCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *channels = [STRSSChannelManager sharedManager].channels.mutableCopy;
    STRSSChannel *channel = channels[indexPath.row];
    cell.titleLb.text = channel.title;
    NSInteger noReadCount = 0;
    for (STRSSItem *item in channel.items) {
        if (!item.read) {
            noReadCount ++;
        }
    }
    cell.countNumberLb.text = (noReadCount > 99) ? @"99+" : [NSString stringWithFormat:@"%d", noReadCount];
    [[STRSSChannelManager sharedManager] save];
}

- (void)_updateVisibleCells
{
    for (STRSSChannelCell *cell in [_tableview visibleCells]) {
        [self _updateCell:cell atIndexPath:[_tableview indexPathForCell:cell]];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Show Channel Item List
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierShowChannelItemList]) {
        STRSSItemListViewController *vc = segue.destinationViewController;
        if ([sender isKindOfClass:[NSIndexPath class]]) {
            vc.indexPath = (NSIndexPath *)sender;
        }
    }
    // Present Feed List
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierPresentFeedList]) {
    }
}

@end
