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
    _channels = [STRSSChannelManager sharedManager].channels.mutableCopy;
    [_tableview reloadData];
    // Do any additional setup after loading the view.
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
    for (STRSSChannel *channel in _channels) {
        NSMutableArray *items = channel.items;
        for (STRSSItem *item in items) {
            item.read = YES;
        }
    }
    
    [self _updateVisibleCells];
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kStoryBoardSegueIdentifierShowChannelItemList sender:_channels[indexPath.row]];
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
    return _channels.count;
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
    STRSSChannel *channel = _channels[indexPath.row];
    cell.titleLb.text = channel.title;
    NSInteger noReadCount = 0;
    for (STRSSItem *item in channel.items) {
        if (!item.read) {
            noReadCount ++;
        }
    }
    cell.countNumberLb.text = (noReadCount > 99) ? @"99+" : [NSString stringWithFormat:@"%d", noReadCount];
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
        // 데이터 세팅
        if ([sender isKindOfClass:[STRSSChannel class]]) {
            STRSSChannel *item = (STRSSChannel *)sender;
            vc.channelItems = item.items;
        }
    }

    // Present Feed List
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierPresentFeedList]) {
        STRSSFeedListViewController *vc = segue.destinationViewController;
        // 데이터 세팅
    }
}

@end
