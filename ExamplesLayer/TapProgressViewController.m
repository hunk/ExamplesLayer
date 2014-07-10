//
//  TapProgressViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/7/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//

#define DEG2RAD(angle) angle*M_PI/180.0

#import "TapProgressViewController.h"

@interface TapProgressViewController (){
    UIBezierPath *circlePath;
    UIImageView *circleColor;
    CALayer *maskCircle;
    NSTimer *timer;
    CGFloat degreeCircle;
    
    UILabel *label;
    
    float offset;
}

@end

@implementation TapProgressViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tap progress circle";
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
    
    
    CGPoint arcCenter = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds));
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:36.0];
    label.text = @"Tap!";
    label.textColor = [UIColor grayColor];
    [label sizeToFit];
//    [label setBackgroundColor:[UIColor redColor]];
//    [label setAdjustsFontSizeToFitWidth:YES];
    label.center = arcCenter;
    [self.view addSubview:label];
    
    
    CGFloat radius = 100-10;
    
    circlePath = [UIBezierPath bezierPathWithArcCenter:arcCenter
                                                     radius:radius
                                                 startAngle:M_PI
                                                   endAngle:-M_PI
                                                  clockwise:NO];
    
    CAShapeLayer *backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.path = circlePath.CGPath;
    backgroundLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    backgroundLayer.fillColor = [[UIColor clearColor] CGColor];
    backgroundLayer.lineWidth = 10;
    [self.view.layer addSublayer:backgroundLayer];

    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 200), NO, [UIScreen mainScreen].scale);
        
    }else{
        UIGraphicsBeginImageContext(CGSizeMake(200, 200));
    }
	
	int sectors = 2800;
	float angle = 2 * M_PI/sectors;
	UIBezierPath *bezierPath;
	
	for (int i = 0; i < sectors; i++) {
		CGPoint center = CGPointMake(100, 100);
		bezierPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:i * angle endAngle:(i + 1) * angle clockwise:YES];
//		[bezierPath addLineToPoint:center];
        bezierPath.lineWidth = 10;
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
    
	circleColor = [[UIImageView alloc] initWithImage:circle];
	circleColor.frame = CGRectMake(0, 0, 200, 200);
    circleColor.center = CGPointMake(self.view.center.x, self.view.center.y);
    circleColor.backgroundColor = [UIColor clearColor];
	[self.view addSubview:circleColor];
    
    //add mask
    degreeCircle = -90;
	maskCircle = [self createPieSlice];
	[circleColor.layer setMask:maskCircle];
	
	
    
    
}

-(CAShapeLayer *)createPieSlice {
	CAShapeLayer *slice = [CAShapeLayer layer];
	slice.fillColor = [UIColor redColor].CGColor;
	slice.strokeColor = [UIColor blackColor].CGColor;
	slice.lineWidth = 0.0;
	
	CGFloat angle = DEG2RAD(-90.0);
	CGPoint center = CGPointMake(100.0, 100.0);
	CGFloat radius = 100.0;
	
	UIBezierPath *piePath = [UIBezierPath bezierPath];
	[piePath moveToPoint:center];
	
	[piePath addLineToPoint:CGPointMake(center.x + radius * cosf(angle), center.y + radius * sinf(angle))];
	
	[piePath addArcWithCenter:center radius:radius startAngle:angle endAngle:DEG2RAD(degreeCircle) clockwise:YES];
	[piePath closePath];
	slice.path = piePath.CGPath;
	
	return slice;
}

-(void)onTimer {
	if (degreeCircle >= 270) {
		if ([timer isValid]) {
			[timer invalidate];
            label.text = @"Done!!";
            CGPoint center = label.center;
            [label sizeToFit];
            label.center = center;
			return;
		}
	}
    
    if (degreeCircle <= -90 && offset < 0) {
		if ([timer isValid]) {
			[timer invalidate];
            label.text = @"Tap!";
            CGPoint center = label.center;
            [label sizeToFit];
            label.center = center;
			return;
		}
	}
	degreeCircle += offset;
    
    if (degreeCircle < -90) {
        degreeCircle = -90;
    }
    if (degreeCircle > 270) {
        degreeCircle = 270;
    }
    
	maskCircle = [self createPieSlice];
	[circleColor.layer setMask:maskCircle];
    
    //update label
    int percentage = round(100*(degreeCircle+90)/360.0);
    label.text = [NSString stringWithFormat:@"%i%%",percentage];
    CGPoint center = label.center;
    [label sizeToFit];
    label.center = center;
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (degreeCircle >= 270) {
        return;
    }
    
    offset = 0.2;
    if (![timer isValid]) {
        timer = [NSTimer scheduledTimerWithTimeInterval:(0.001)
                                                 target: self
                                               selector:@selector(onTimer)
                                               userInfo: nil repeats: YES];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (degreeCircle >= 270) {
        return;
    }
    offset = -0.2;
//    if ([timer isValid]) {
//        [timer invalidate];
//    }
    
    //reset
//    degreeCircle = -90;
//    maskCircle = [self createPieSlice];
//    [circleColor.layer setMask:maskCircle];
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
