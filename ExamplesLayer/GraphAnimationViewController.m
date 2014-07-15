//
//  GraphAnimationViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/11/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//
#define DEG2RAD(angle) angle*M_PI/180.0

#import "GraphAnimationViewController.h"

@interface GraphAnimationViewController (){
    CALayer *baseLayer;
}

@end

@implementation GraphAnimationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Graph animation";
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
    [self setupPath];
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

-(void)setup{
    
    
    
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[self getImageFromName:@"graph_bg"]];
    UIView *viewContent = [[UIView alloc] initWithFrame:bgView.frame];
    viewContent.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    [viewContent addSubview:bgView];
    [self.view addSubview:viewContent];
    
    //now the path
    baseLayer = [CALayer layer];
    baseLayer.frame = CGRectMake(0, 0,CGRectGetWidth(viewContent.bounds),CGRectGetHeight(viewContent.bounds));
    baseLayer.backgroundColor = [UIColor clearColor].CGColor;
    [viewContent.layer addSublayer:baseLayer];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:36.0];
    label.text = @"y = 2 * sin(x)";
    label.textColor = [UIColor grayColor];
    [label sizeToFit];
    
    label.center = CGPointMake(
                               CGRectGetMidX(self.view.bounds),
                               CGRectGetMidY(self.view.bounds) - CGRectGetMidY(viewContent.bounds) - CGRectGetMidY(label.bounds)
                               );
    
    [self.view addSubview:label];
    
    

}

-(void)setupPath{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(16, 90)];
    
    CGFloat offsetY = 90.0;
    CGFloat offsetX = 16.0;
    CGFloat step = (float)100/360;
    for (int i = 0; i <= 990; i=i+5) {
        [path addLineToPoint:CGPointMake(
                                         ( i*step ) + offsetX,
                                         offsetY + ( ( sin( DEG2RAD(i) ) ) * 43 ) )
         ];
        
    }
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = baseLayer.bounds;
    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor redColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 2.0f;
    pathLayer.lineJoin = kCALineJoinRound;
    
    [baseLayer addSublayer:pathLayer];
    

    [pathLayer removeAllAnimations];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
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
