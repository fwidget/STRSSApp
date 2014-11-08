//
//  STRSSFeedListViewController.m
//  STRSSApp
//
//  Created by KIMSEONGTAN on 2014. 11. 6..
//  Copyright (c) 2014년 devst. All rights reserved.
//

#import "STRSSFeedListViewController.h"

#import "STRSSChannel.h"
#import "STRSSFeedViewController.h"
#import "STRSSFeedCell.h"

@interface STRSSFeedListViewController ()

@end

@implementation STRSSFeedListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)_updateToolbarItems:(NSArray *)items animated:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:animated];
    [self setToolbarItems:items animated:animated];
}

- (IBAction)editItems:(id)sender {
    if (self.editing) {
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItems:)];
        [self _updateToolbarItems:[NSArray arrayWithObjects:barItem, nil] animated:YES];
    } else {
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneItems:)];
        [self _updateToolbarItems:[NSArray arrayWithObjects:barItem, nil] animated:YES];
    }
    self.editing = !self.editing;
 
    [self _updateNavigationItem:YES];
}

- (void)doneItems:(id)sender
{
    [self editItems:sender];
}

- (IBAction)doneAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_updateNavigationItem:(BOOL)animated
{
    if (self.editing) {
        [self.navigationItem setLeftBarButtonItem:nil animated:animated];
        [self.navigationItem setRightBarButtonItem:nil animated:animated];
    } else {
        [self.navigationItem setLeftBarButtonItem:_addItem animated:animated];
        [self.navigationItem setRightBarButtonItem:_doneItem animated:animated];
    }
}


#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:kStoryBoardSegueIdentifierShowFeedDetail sender:_feeds[indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

#pragma mark - UITableViewDataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = kCellIdentifierFeedCell;
    STRSSFeedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    cell.titleLb.text = @"";
    cell.feedUrlLb.text = @"";
    
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierShowAddFeed]) {
        STRSSFeedViewController *vc = segue.destinationViewController;
        vc.addFeedItem = YES;
    }
    if ([segue.identifier isEqualToString:kStoryBoardSegueIdentifierShowFeedDetail]) {
        STRSSFeedViewController *vc = segue.destinationViewController;
        vc.titleTxt.text = @"";
        vc.feedUrlTxtView.text = @"";
    }
}


@end
