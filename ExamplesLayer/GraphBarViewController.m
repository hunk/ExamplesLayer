//
//  GraphBarViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/11/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//

#import "GraphBarViewController.h"

@interface GraphBarViewController (){
    UIView *viewContent;
}

@end

@implementation GraphBarViewController

- (CAGradientLayer*) bgGradient {
    
    UIColor *colorRed = [UIColor redColor];
    UIColor *colorYellow = [UIColor yellowColor];
    UIColor *colorGreen = [UIColor greenColor];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorGreen.CGColor,(id)colorYellow.CGColor, (id)colorRed.CGColor, nil];
    
    NSNumber *locationOne = [NSNumber numberWithFloat:0.0];
    NSNumber *locationTwo = [NSNumber numberWithFloat:0.5];
    NSNumber *locationThree = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:locationOne, locationTwo,locationThree, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
    
}


-(void)setupBarAndAnimation{
    
    [viewContent.layer removeAllAnimations];
    
    if (viewContent.layer.sublayers.count > 1) {
        viewContent.layer.sublayers = nil;
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[self getImageFromName:@"bg2"]];
        [viewContent addSubview:bgView];
    }
    
    CGPoint basePoint = CGPointMake(27, CGRectGetMaxY(viewContent.bounds)-8);
    
    for (int i = 0; i < 4; i++) {
        CAGradientLayer *bar =[self bgGradient];
        bar.position = CGPointMake(basePoint.x+(i*70), basePoint.y);
        
        bar.bounds = CGRectMake(0.0, 0.0, 40, 250);
        bar.anchorPoint = CGPointMake(0.0, 1.0);
        [viewContent.layer addSublayer:bar];
        
        CALayer *maskLayer = [CALayer layer];
        maskLayer.frame = CGRectMake(0, 250+5, 40, 0);
        [maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
        maskLayer.anchorPoint = CGPointMake(0.5, 1.0);
        
        [maskLayer setCornerRadius:5.0];
        
        bar.mask = maskLayer;
        
        float timeStep = (float)3.0/255;
        
        CGRect toBounds = maskLayer.bounds;
        toBounds.size.height = ((arc4random() % 10)+1) * 25;
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
        animation.fromValue = [NSValue valueWithCGRect:maskLayer.bounds];
        animation.toValue = [NSValue valueWithCGRect:toBounds];
        animation.repeatCount = 0;
        animation.autoreverses = NO;
        animation.duration = toBounds.size.height * timeStep;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        [maskLayer addAnimation:animation forKey:@"oscillation"];
        
        maskLayer.bounds = toBounds;
    }
}

-(void)setup{
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[self getImageFromName:@"bg2"]];
    viewContent = [[UIView alloc] initWithFrame:bgView.frame];
    viewContent.center = CGPointMake( CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) );
    [viewContent addSubview:bgView];
//    viewContent.clipsToBounds = YES;
    [self.view addSubview:viewContent];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0, 80, 30);
    btn.center = CGPointMake( CGRectGetMidX(self.view.bounds), CGRectGetMidY(self.view.bounds) +180);
    [btn setTitle:@"Repeat" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(setupBarAndAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

-(UIImage*)getImageFromName:(NSString*)name{
    
    NSString* imagePath = [ [ NSBundle mainBundle] pathForResource:name ofType:@"png"];
    
    //    UIImage *image = [UIImage imageNamed:name];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    image = [UIImage imageWithCGImage:[image CGImage]
                                scale:[UIScreen mainScreen].scale
                          orientation:UIImageOrientationUp];
    
    return image;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Graph bar";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self setupBarAndAnimation];
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
