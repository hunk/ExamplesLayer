//
//  MaskCircleViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/7/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//
#define DEG2RAD(angle) angle*M_PI/180.0

#import "MaskCircleViewController.h"

@interface MaskCircleViewController (){
    UIImageView *batman;
    CGSize sizeImg;
    CALayer *maskBatman;
    NSTimer *timer;
    CGFloat degreeCircle;
}

@end

@implementation MaskCircleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Mask in circle";
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
    [self performSelector:@selector(setup) withObject:nil afterDelay:1.0];
}

-(void)setup{
    
    batman = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bat"]];
    sizeImg = batman.image.size;
    batman.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [self.view addSubview:batman];
    
    degreeCircle = 180.0;
	maskBatman = [self createPieSlice];
	[batman.layer setMask:maskBatman];
	
	timer = [NSTimer scheduledTimerWithTimeInterval:(0.005)
											 target: self
										   selector:@selector(onTimer)
										   userInfo: nil repeats: YES];
}

-(CAShapeLayer *)createPieSlice {
	CAShapeLayer *slice = [CAShapeLayer layer];
	slice.fillColor = [UIColor redColor].CGColor;
	slice.strokeColor = [UIColor blackColor].CGColor;
	slice.lineWidth = 0.0;
	
	CGFloat angle = DEG2RAD(180.0);
	CGPoint center = CGPointMake(sizeImg.width/2, sizeImg.height/2);
	CGFloat radius = sizeImg.height/2;
	
	UIBezierPath *piePath = [UIBezierPath bezierPath];
	[piePath moveToPoint:center];
	[piePath addLineToPoint:CGPointMake(center.x + radius * cosf(angle), center.y + radius * sinf(angle))];
	[piePath addArcWithCenter:center radius:radius startAngle:angle endAngle:DEG2RAD(degreeCircle) clockwise:YES];
	[piePath closePath];
	slice.path = piePath.CGPath;
	
	return slice;
}

-(void)onTimer {
	if (degreeCircle >= 540) {
		if ([timer isValid]) {
			[timer invalidate];
			return;
		}
	}
	
	degreeCircle += 0.2;
	maskBatman = [self createPieSlice];
	[batman.layer setMask:maskBatman];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if ([timer isValid]) {
        [timer invalidate];
    }
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
