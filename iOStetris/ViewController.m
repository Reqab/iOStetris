//
//  ViewController.m
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/16/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import "ViewController.h"
#import "TetrisBoard.h"
#import "TetrisView.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet TetrisView *puzzleView;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isPaused;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *pause;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@property (weak, nonatomic) IBOutlet UITextField *scoreTextField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTetrisView{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    TetrisBoard *board = appDelegate.board;
    
    for (int row = 0; row < 18; row++) {
        for (int col = 0; col < 10; col++) {
            NSInteger block = [board getBlockInRow:row col:col];
            [self.puzzleView setBlockContentInTetrisLayerAtRow:row Col:col Block:block];
        }
    }
}

-(void)moveDown{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    TetrisBoard *board = appDelegate.board;
    if([board canMoveDown]){
        [board moveDown];
        [self.puzzleView moveTetrominoDown];
    }else{
        NSLog(@"lockPiece");
        [board lockPiece];
        [self setTetrisView];
        [self.puzzleView setCurrentTetromino:(int)[board getCurrentPiece]];
    }
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    TetrisBoard *board = appDelegate.board;
    self.scoreTextField.text = [NSString stringWithFormat:@"%ld", [board getScore]];
    
    //timer setup
    self.isPaused = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(moveDown) userInfo:nil repeats:YES];
    [self.puzzleView setCurrentTetromino:(int)board.getCurrentPiece];
}

- (IBAction)pause:(id)sender {
    if(self.isPaused){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(moveDown) userInfo:nil repeats:YES];
        self.isPaused = NO;
        self.pause.title = @"Pause";
    }else{
        [self.timer invalidate];
        self.timer = nil;
        self.isPaused = YES;
        self.pause.title = @"Resume";
    }
}

//tap events for rotate
- (IBAction)handleTap:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    TetrisBoard *board = appDelegate.board;
    if([board canRotate]){
        [board rotate];
        int direction = (int)[board getCurrentPieceDirection];
        [self.puzzleView rotateTetromino:direction];
    }
}

//touch events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if([self.pause.title  isEqual: @"Resume"]) return;
    UITouch *touch = [touches anyObject];
    CGPoint pos = [touch locationInView:self.puzzleView];
    CGPoint hitPoint = [self.puzzleView.layer convertPoint:pos toLayer:self.puzzleView.layer.superlayer];
    
    CALayer *layer = [self.puzzleView.layer hitTest:hitPoint];
    if([layer.name isEqualToString:@"block"]){
        self.puzzleView.touchStartPoint = pos;
        self.puzzleView.touchStartLayerPosition = layer.superlayer.position;
        self.puzzleView.touchLayer = layer.superlayer;
    }else{
        NSLog(@"touched table");
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.puzzleView.touchLayer != nil){
        UITouch *touch = [touches anyObject];
        CGPoint pos = [touch locationInView:self.puzzleView];
        CGPoint delta = CGPointMake(pos.x-self.puzzleView.touchStartPoint.x,
                                    pos.y-self.puzzleView.touchStartPoint.y);
        CGPoint newpos;
        
        if (self.puzzleView.touchLayer.position.x + delta.x <= 0)
            newpos = CGPointMake(self.puzzleView.current.bounds.size.width/2, self.puzzleView.current.position.y);
        else if(self.puzzleView.touchLayer.position.x + delta.x >=  self.puzzleView.bounds.size.width)
            newpos = CGPointMake(self.puzzleView.bounds.size.width - self.puzzleView.current.bounds.size.width/2, self.puzzleView.current.position.y);
        else
            newpos = CGPointMake(self.puzzleView.touchStartLayerPosition.x + delta.x, self.puzzleView.current.position.y);
        
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.puzzleView.touchLayer.position = newpos;
        [CATransaction commit];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.puzzleView.touchLayer != nil){
        CGFloat blockWidth = self.puzzleView.bounds.size.width/10;
        NSInteger row = round(self.puzzleView.touchLayer.position.x/blockWidth);
        NSInteger rowAdj = round(self.puzzleView.current.bounds.size.width/blockWidth);
        rowAdj = rowAdj%2;
        CGPoint  newpos = CGPointMake(blockWidth*(row - rowAdj*0.5), self.puzzleView.current.position.y);
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.puzzleView.touchLayer.position = newpos;
        [CATransaction commit];
    }
    self.puzzleView.touchLayer = nil;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    self.puzzleView.touchLayer = nil;
}


@end
