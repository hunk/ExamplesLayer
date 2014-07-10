//
//  GradientMaskViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/7/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//
#define DEG2RAD(angle) angle*M_PI/180.0

#import "GradientMaskViewController.h"

@interface GradientMaskViewController (){
    UIView *viewBase;
    
    CALayer *maskHalfCircle;
    NSTimer *timer;
    CGFloat degreeCircle;
}

@end

@implementation GradientMaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Gradient mask";
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
    [self setup];
}

-(void)setup{
    viewBase = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
	[viewBase setBackgroundColor:[UIColor clearColor]];
    viewBase.center = CGPointMake(self.view.center.x, self.view.center.y);
	[self.view addSubview:viewBase];
	
	

	//creamos
	CAGradientLayer *layer = [CAGradientLayer layer];
	[layer setStartPoint:CGPointMake(0.0, 0.5)];
	[layer setEndPoint:CGPointMake(1.0, 0.5)];
	[layer setFrame:CGRectMake(0, 0, 100, 100)];
	
	NSMutableArray *colors = [NSMutableArray array];
	for (NSInteger hue = 0; hue <= 360; hue += 5) {
		UIColor *color;
		color = [UIColor colorWithHue:1.0 * hue / 360.0 saturation:1.0 brightness:1.0 alpha:1.0];
		[colors addObject:(id)[color CGColor]];
	}
    [layer setColors:colors];
    [viewBase.layer addSublayer:layer];

	
	CAShapeLayer *slice = [CAShapeLayer layer];
	slice.fillColor = [UIColor redColor].CGColor;
	slice.strokeColor = [UIColor blackColor].CGColor;
	slice.lineWidth = 0.0;
	
	CGPoint center = CGPointMake(50, 50);
	CGFloat radius = 50.0;
	
	UIBezierPath *piePath = [UIBezierPath bezierPath];
    [piePath moveToPoint:CGPointMake(10, 50)];
    [piePath addLineToPoint:CGPointMake(0, 50)];
    [piePath addArcWithCenter:center radius:radius startAngle:DEG2RAD(180.0) endAngle:DEG2RAD(0) clockwise:YES];
    [piePath addLineToPoint:CGPointMake(90, 50)];
    [piePath addArcWithCenter:center radius:radius-10 startAngle:DEG2RAD(0) endAngle:DEG2RAD(-180) clockwise:NO];
	[piePath closePath];
	slice.path = piePath.CGPath;
	
	[layer setMask:slice];
    
    degreeCircle = 180;
	maskHalfCircle = [self createPieSlice];
	[viewBase.layer setMask:maskHalfCircle];
	
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
	CGPoint center = CGPointMake(50.0, 50.0);
	CGFloat radius = 50.0;
	
	UIBezierPath *piePath = [UIBezierPath bezierPath];
	[piePath moveToPoint:center];
	
	[piePath addLineToPoint:CGPointMake(center.x + radius * cosf(angle), center.y + radius * sinf(angle))];
	
	[piePath addArcWithCenter:center radius:radius startAngle:angle endAngle:DEG2RAD(degreeCircle) clockwise:YES];
	[piePath closePath];
	slice.path = piePath.CGPath;
	
	return slice;
}

-(void)onTimer {
	if (degreeCircle >= 360) {
		if ([timer isValid]) {
			[timer invalidate];
			return;
		}
	}
	
	degreeCircle += 0.2;
	maskHalfCircle = [self createPieSlice];
	[viewBase.layer setMask:maskHalfCircle];
	
}

-(void)viewDidDisappear:(BOOL)animated{
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
