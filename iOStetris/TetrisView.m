//
//  TetrisView.m
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "TetrisView.h"

@interface TetrisView()

//tetrominoes
@property (strong, nonatomic) CALayer *current;
@property (strong, nonatomic) CALayer *next;

@property (strong, nonatomic) CALayer *tetrisLayer;

//dragging
@property (assign, nonatomic) CGPoint touchStartPoint;
@property (assign, nonatomic) CGPoint touchStartLayerPosition;
@property (weak, nonatomic) CALayer *touchLayer;

@end


@implementation TetrisView

-(void)layoutSubviews{
    CGFloat blockWidth = self.bounds.size.width/10;
    CGFloat blockHeight = self.bounds.size.height/18;
    self.current.bounds = CGRectMake(0, 0, blockWidth*4, blockHeight);
    self.current.position = CGPointMake(150, 150);
    self.current.backgroundColor = [UIColor blueColor].CGColor;
    for (int i = 0; i < 4; i++) {
        CALayer *block = [self.current.sublayers objectAtIndex:i];
        block.bounds = CGRectMake(0, 0, blockWidth, blockHeight);
        block.position = CGPointMake(blockWidth/2+blockWidth*i, blockHeight/2);
    }
    [self.layer addSublayer:self.current];
}

-(void)awakeFromNib{
    self.current = [[CALayer alloc] init];
    self.next = [[CALayer alloc] init];
    self.current.name = @"polyomino";
    for (int i = 0; i < 4; i++) {
        CALayer *block = [[CALayer alloc] init];
        block.contents = (id)[UIImage imageNamed:@"silverBlock"].CGImage;
        block.name = @"block";
        [self.current insertSublayer:block atIndex:i];
    }
}

//touch events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInView:self];
    CGPoint hitPoint = [self.layer convertPoint:pos toLayer:self.layer.superlayer];
    
    CALayer *layer = [self.layer hitTest:hitPoint];
    if([layer.name isEqualToString:@"block"]){
        self.touchStartPoint = pos;
        self.touchStartLayerPosition = layer.superlayer.position;
        self.touchLayer = layer.superlayer;
    }else{
        NSLog(@"touched table");
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.touchLayer != nil){
        UITouch *touch = [touches anyObject];
        CGPoint pos = [touch locationInView:self];
        CGPoint delta = CGPointMake(pos.x-self.touchStartPoint.x,
                                    pos.y-self.touchStartPoint.y);
        CGPoint newpos;
        if (self.touchLayer.position.x + delta.x <= 0)
            newpos = CGPointMake(self.current.bounds.size.width/2, self.touchStartLayerPosition.y);
        else if(self.touchLayer.position.x + delta.x >=  self.bounds.size.width)
            newpos = CGPointMake(self.bounds.size.width - self.current.bounds.size.width/2, self.touchStartLayerPosition.y);
        else
            newpos = CGPointMake(self.touchStartLayerPosition.x + delta.x, self.touchStartLayerPosition.y);
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.touchLayer.position = newpos;
        [CATransaction commit];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.touchLayer != nil){
        CGFloat blockWidth = self.bounds.size.width/10;
        NSInteger row =  round(self.touchLayer.position.x/blockWidth);
        CGPoint newpos = CGPointMake(blockWidth*row, self.touchLayer.position.y);
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.touchLayer.position = newpos;
        [CATransaction commit];
    }
    self.touchLayer = nil;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.touchLayer = nil;
}

@end
