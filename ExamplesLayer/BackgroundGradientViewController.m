//
//  BackgroundGradientViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/8/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//

#import "BackgroundGradientViewController.h"

@interface BackgroundGradientViewController ()

@end

@implementation BackgroundGradientViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Background Gradient";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CAGradientLayer *bgLayer = [self bgGradient];
    bgLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:bgLayer];
    
}

- (CAGradientLayer*) bgGradient {
    
    UIColor *colorRed = [UIColor redColor];
    UIColor *colorYellow = [UIColor yellowColor];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorRed.CGColor, colorYellow.CGColor, nil];
    
    NSNumber *locationOne = [NSNumber numberWithFloat:0.0];
    NSNumber *locationTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:locationOne, locationTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
