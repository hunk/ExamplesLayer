//
//  GradientCircleViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/7/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//

#import "GradientCircleViewController.h"

@interface GradientCircleViewController ()

@end

@implementation GradientCircleViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Gradient circle";
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setup];
}

-(void)setup{
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, [UIScreen mainScreen].scale);
        
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    }
	
	int sectors = 360;
	float radius = 99.3;
	float angle = 2 * M_PI/sectors;
	UIBezierPath *bezierPath;
	
	for (int i = 0; i < sectors; i++) {
		CGPoint center = CGPointMake(100, 100);
		bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:i * angle endAngle:(i + 1) * angle clockwise:YES];
		[bezierPath addLineToPoint:center];
//        bezierPath.lineWidth = 0.4;
		[bezierPath closePath];
		UIColor *color = [UIColor colorWithHue:((float)i)/sectors saturation:1. brightness:1. alpha:1];
		[color setFill];
		[color setStroke];
		[bezierPath fill];
		[bezierPath stroke];
	}
	
	UIImage *circle = [[UIImage alloc] init];
	circle = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
	circleView.frame = CGRectMake(0, 0, 200, 200);
    circleView.center = CGPointMake(self.view.center.x, self.view.center.y);
    circleView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:circleView];

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
