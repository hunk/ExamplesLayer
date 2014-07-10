//
//  MainTableViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/7/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//

#import "MainTableViewController.h"

#import "ProgressViewController.h"
#import "MaskCircleViewController.h"
#import "OscillationLineViewController.h"
#import "GradientCircleViewController.h"
#import "GradientMaskViewController.h"
#import "TapProgressViewController.h"
#import "BackgroundGradientViewController.h"
#import "DrawViewController.h"

@interface MainTableViewController (){
    NSArray *examples;
}

@end

@implementation MainTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.title = @"CALayer Examples";
        examples = @[
                     @"Progress view",
                     @"Mask in circle",
                     @"Oscillation lines",
                     @"Gradient circle",
                     @"Gradient mask",
                     @"Tap progress",
                     @"Background gradient",
                     @"Draw"
                     ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return examples.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
    }
    
    // Configure the cell...
    cell.textLabel.text = [examples objectAtIndex:indexPath.row];
    
    return cell;
    
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    if (indexPath.row == 0) {
        ProgressViewController *progress = [[ProgressViewController alloc] init];
        [self.navigationController pushViewController:progress animated:YES];
    }else if (indexPath.row == 1){
        MaskCircleViewController *mask = [[MaskCircleViewController alloc] init];
        [self.navigationController pushViewController:mask animated:YES];
    }else if (indexPath.row == 2){
        OscillationLineViewController *oscillation = [[OscillationLineViewController alloc] init];
        [self.navigationController pushViewController:oscillation animated:YES];
    }else if (indexPath.row == 3){
        GradientCircleViewController *gradient = [[GradientCircleViewController alloc] init];
        [self.navigationController pushViewController:gradient animated:YES];
    }else if (indexPath.row == 4){
        GradientMaskViewController *gradientMask = [[GradientMaskViewController alloc] init];
        [self.navigationController pushViewController:gradientMask animated:YES];
    }else if (indexPath.row == 5){
        TapProgressViewController *tap = [[TapProgressViewController alloc] init];
        [self.navigationController pushViewController:tap animated:YES];
    }else if (indexPath.row == 6){
        BackgroundGradientViewController *bg = [[BackgroundGradientViewController alloc] init];
        [self.navigationController pushViewController:bg animated:YES];
    }else if (indexPath.row == 7){
        DrawViewController *draw = [[DrawViewController alloc] init];
        [self.navigationController pushViewController:draw animated:YES];
    }
}

@end
