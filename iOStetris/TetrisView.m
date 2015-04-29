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
@property (strong, nonatomic) CALayer *iPolyomino;
@property (strong, nonatomic) CALayer *oPolyomino;
@property (strong, nonatomic) CALayer *tPolyomino;
@property (strong, nonatomic) CALayer *lPolyomino;
@property (strong, nonatomic) CALayer *jPolyomino;
@property (strong, nonatomic) CALayer *sPolyomino;
@property (strong, nonatomic) CALayer *zPolyomino;

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
    self.iPolyomino.bounds = CGRectMake(0, 0, blockWidth*4, blockHeight);
    self.iPolyomino.position = CGPointMake(150, 150);
    self.iPolyomino.backgroundColor = [UIColor blueColor].CGColor;
    for (int i = 0; i < 4; i++) {
        CALayer *block = [self.iPolyomino.sublayers objectAtIndex:i];
        block.bounds = CGRectMake(0, 0, blockWidth, blockHeight);
        block.position = CGPointMake(blockWidth/2+blockWidth*i, blockHeight/2);
    }
    [self.layer addSublayer:self.iPolyomino];
}

-(void)awakeFromNib{
    self.iPolyomino = [[CALayer alloc] init];
    self.iPolyomino.name = @"polyomino";
    for (int i = 0; i < 4; i++) {
        CALayer *block = [[CALayer alloc] init];
        block.contents = (id)[UIImage imageNamed:@"silverBlock"].CGImage;
        block.name = @"block";
        [self.iPolyomino insertSublayer:block atIndex:i];
    }
    self.oPolyomino = [[CALayer alloc] init];
    self.tPolyomino = [[CALayer alloc] init];
    self.lPolyomino = [[CALayer alloc] init];
    self.jPolyomino = [[CALayer alloc] init];
    self.sPolyomino = [[CALayer alloc] init];
    self.zPolyomino = [[CALayer alloc] init];
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
        CGPoint newpos = CGPointMake(self.touchStartLayerPosition.x + delta.x,
                                     self.touchStartLayerPosition.y);
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.touchLayer.position = newpos;
        [CATransaction commit];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    self.touchLayer = nil;
    
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.touchLayer = nil;
}

@end
