//
//  DrawViewController.m
//  ExamplesLayer
//
//  Created by Edgar on 7/8/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//

#import "DrawViewController.h"

@interface DrawViewController (){
    CALayer *baseLayer;
    CAShapeLayer *drawLayer;
    
    UIBezierPath *pathDraw;
    
    UIColor *drawColor;
}

@end

@implementation DrawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Erase" style:UIBarButtonItemStylePlain target:self action:@selector(toggleAction:)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    
    baseLayer = [CALayer layer];
    baseLayer.frame = CGRectMake(0, 0,CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds));
    baseLayer.backgroundColor = [UIColor grayColor].CGColor;
    [self.view.layer addSublayer:baseLayer];
    
    drawColor = [UIColor blackColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
}


-(void)toggleAction:(id)sender{
    UIBarButtonItem *btn = (UIBarButtonItem*)sender;
    NSLog(@"%@",btn.title);
    
    if ([btn.title isEqual:@"Erase"]) {
        btn.title = @"Draw";
        self.navigationItem.rightBarButtonItem = btn;
        drawColor = [UIColor grayColor];
    }else{
        btn.title = @"Erase";
        self.navigationItem.rightBarButtonItem = btn;
        drawColor = [UIColor blackColor];
    }
}

-(void)setup{
    //now
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 4)];
    [path addLineToPoint:CGPointMake(100, 44)];
    [path addLineToPoint:CGPointMake(200, 4)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = baseLayer.bounds;
    pathLayer.bounds = CGRectInset(baseLayer.bounds, 100.0f, 100.0f);;
//    pathLayer.geometryFlipped = YES;
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [[UIColor grayColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 5.0f;
    pathLayer.lineJoin = kCALineJoinRound;
    
    [baseLayer addSublayer:pathLayer];
    
    drawLayer = pathLayer;
    
    [drawLayer removeAllAnimations];
    
    drawLayer.hidden = NO;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 5.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [drawLayer addAnimation:pathAnimation forKey:@"strokeEnd"];

}

-(void)drawThisPoint:(CGPoint)point isFirst:(BOOL)first{
    
    if (first) {
        drawLayer = [CAShapeLayer layer];
        drawLayer.frame = baseLayer.bounds;
        drawLayer.bounds = CGRectInset(baseLayer.bounds, 100.0f, 100.0f);
        drawLayer.strokeColor = [drawColor CGColor];
        drawLayer.fillColor = nil;
        drawLayer.lineWidth = 5.0f;
        drawLayer.lineJoin = kCALineJoinRound;
        
        pathDraw = [UIBezierPath bezierPath];
        [pathDraw moveToPoint:point];
        
        drawLayer.path = pathDraw.CGPath;
        
        [baseLayer addSublayer:drawLayer];
    }else{
        
        [pathDraw addLineToPoint:point];
        drawLayer.path = pathDraw.CGPath;
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self drawThisPoint:touchPoint isFirst:YES];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    [self drawThisPoint:touchPoint isFirst:NO];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]){
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
        
    }else{
        UIGraphicsBeginImageContext(self.view.bounds.size);
    }

    [baseLayer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *layerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageView *imgTMP = [[UIImageView alloc] initWithImage:layerImage];
    [self.view addSubview:imgTMP];
    
    baseLayer.contents = (id) layerImage.CGImage;
    baseLayer.sublayers = nil;
    [self performSelector:@selector(remoImg:) withObject:imgTMP afterDelay:0.2];
    
}

-(void)remoImg:(UIImageView*)img{
    [img removeFromSuperview];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"cancel");
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
