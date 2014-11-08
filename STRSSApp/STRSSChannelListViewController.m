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
}

- (IBAction)updateAllChannel:(id)sender
{
    
}

- (IBAction)readAllChannel:(id)sender
{
    
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
    STRSSChannel *item = _channels[indexPath.row];
    cell.titleLb.text = item.title;
    // TODO : No read is count
    NSNumber *countNumber = @(100);
    cell.countNumberLb.text = (countNumber.integerValue > 99) ? @"99+" : countNumber.stringValue;
    return cell;
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Show Channel Item List
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierShowChannelItemList]) {
        STRSSItemListViewController *vc = segue.destinationViewController;
        // 데이터 세팅
    }

    // Present Feed List
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierPresentFeedList]) {
        STRSSFeedListViewController *vc = segue.destinationViewController;
        // 데이터 세팅
    }
}

@end
