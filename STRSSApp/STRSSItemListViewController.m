//
//  STRSSItemListViewController.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSItemListViewController.h"

#import "STRSSChannelItemCell.h"
#import "STRSSContentViewController.h"

@interface STRSSItemListViewController ()

@end

@implementation STRSSItemListViewController

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

- (IBAction)readAllItem:(id)sender
{
    for (STRSSItem *item in _channelItems) {
        item.read = YES;
    }

    [self _updateVisibleCells];
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    STRSSItem *item = _channelItems[indexPath.row];
    item.read = YES;
    [self performSegueWithIdentifier:kStoryBoardSegueIdentifierShowChannelItemDetail sender:item];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark - UITableViewDataSource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _channelItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = kCellIdentifierChannelItemCell;
    STRSSChannelItemCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    [self _updateCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)_updateCell:(STRSSChannelItemCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    STRSSItem *item = (STRSSItem *)_channelItems[indexPath.row];
    cell.titleLb.text = item.title;
    cell.dateLb.text = item.pubDate;
    cell.postLb.text = item.itemDescription;
    cell.markView.alpha = (item.read) ? 0.0 : 1.0 ;
}

- (void)_updateVisibleCells
{
    for (STRSSChannelItemCell *cell in [_tableview visibleCells]) {
        [self _updateCell:cell atIndexPath:[_tableview indexPathForCell:cell]];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierShowChannelItemDetail]) {
        STRSSContentViewController *vc = segue.destinationViewController;
        if ([sender isKindOfClass:[STRSSItem class]]) {
            STRSSItem *item = (STRSSItem *)sender;
            vc.titleLb.text = item.title;
            vc.dateLb.text = item.pubDate;
            vc.postTextview.text = item.itemDescription;
        }
    }
}


@end
