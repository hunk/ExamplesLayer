//
//  GradientView.m
//  ExamplesLayer
//
//  Created by Edgar on 7/7/14.
//  Copyright (c) 2014 hunk. All rights reserved.
//

#import "GradientView.h"

@interface GradientView (){
    NSTimer *timer;
    CALayer *maskLayer;
    CGFloat progress;
    CABasicAnimation *animation;
}

@end

@implementation GradientView

- (void)setProgress:(CGFloat)value {
    if (progress != value) {
        progress = MIN(1.0, fabs(value));
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    CGRect maskRect = [maskLayer frame];
    maskRect.size.width = CGRectGetWidth([self bounds]) * progress;
	
    
    [maskLayer setFrame:maskRect];
}

- (void)animationLayer{
	CAGradientLayer *layer = (id)[self layer];
	NSMutableArray *mutable = [[layer colors] mutableCopy];
	id lastColor = [mutable lastObject];
	[mutable removeLastObject];
	[mutable insertObject:lastColor atIndex:0];
	
	NSArray *shiftedColors = [NSArray arrayWithArray:mutable];
	[layer setColors:shiftedColors];
	
	animation = [CABasicAnimation animationWithKeyPath:@"colors"];
	[animation setToValue:shiftedColors];
	[animation setDuration:0.08];
	[animation setRemovedOnCompletion:YES];
	[animation setFillMode:kCAFillModeForwards];
	[animation setDelegate:self];
    [layer removeAnimationForKey:@"animateGradient"];
	[layer addAnimation:animation forKey:@"animateGradient"];
	
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self animationLayer];
    }
}


+ (Class)layerClass{
	return [CAGradientLayer class];
}

-(void)onTimer {
    [self setProgress:progress+0.0005];
	if (progress == 1.0) {
		if ([timer isValid]) {
			[timer invalidate];
		}
	}
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAGradientLayer *layer = (id)[self layer];
		[layer setStartPoint:CGPointMake(0.0, 0.5)];
		[layer setEndPoint:CGPointMake(1.0, 0.5)];
		
		NSMutableArray *colors = [NSMutableArray array];
		for (NSInteger hue = 0; hue <= 360; hue += 5) {
			UIColor *color;
			color = [UIColor colorWithHue:1.0 * hue / 360.0 saturation:1.0 brightness:1.0 alpha:1.0];
			[colors addObject:(id)[color CGColor]];
		}
		[layer setColors:colors];
		
		maskLayer = [CALayer layer];
		[maskLayer setFrame:CGRectMake(0, 0, 0, frame.size.height)];
		[maskLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
		[layer setMask:maskLayer];
		
		[self animationLayer];
		
		timer = [NSTimer scheduledTimerWithTimeInterval:(0.005)
												 target: self
											   selector:@selector(onTimer)
											   userInfo: nil repeats: YES];
    }
    return self;
}

-(void)willRemoveSubview:(UIView *)subview{
    
}

-(void)removeFromSuperview{
    [super removeFromSuperview];
    if ([timer isValid]) {
        [timer invalidate];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
