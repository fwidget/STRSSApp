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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readAllItem:(id)sender
{
    for (Item *item in _channelItems) {
        item.read = YES;
    }

    [[STRSSDataManager sharedInstance] save];

    [_tableview reloadData];
}

#pragma mark - UITableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kStoryBoardSegueIdentifierShowChannelItemDetail sender:_channelItems[indexPath.row]];
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
    Item *item = (Item *)_channelItems[indexPath.row];
    cell.titleLb.text = item.title;
    cell.dateLb.text = item.pubDate;
    cell.postLb.text = item.itemDescription;
    cell.markView.alpha = (item.read) ? 0.0 : 1.0 ;
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierShowChannelItemDetail]) {
        STRSSContentViewController *vc = segue.destinationViewController;
        if ([sender isKindOfClass:[Item class]]) {
            Item *item = (Item *)sender;
            vc.titleLb.text = item.title;
            vc.dateLb.text = item.pubDate;
            vc.postTextview.text = item.itemDescription;
        }
    }
}


@end
