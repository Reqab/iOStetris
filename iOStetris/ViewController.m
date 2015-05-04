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
        [board lockPiece];
        [self setTetrisView];
        self.scoreTextField.text = [NSString stringWithFormat:@"%ld", [board getScore]];
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
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    TetrisBoard *board = appDelegate.board;
    CGFloat blockWidth = self.puzzleView.bounds.size.width/10;
    
    if(self.puzzleView.touchLayer != nil){
        UITouch *touch = [touches anyObject];
        CGPoint pos = [touch locationInView:self.puzzleView];
        CGPoint delta = CGPointMake(pos.x-self.puzzleView.touchStartPoint.x,
                                    pos.y-self.puzzleView.touchStartPoint.y);
        
        CGPoint newpos = CGPointMake(self.puzzleView.touchStartLayerPosition.x + delta.x, self.puzzleView.current.position.y);
        
        if (delta.x > 0 && ![board canMoveRight]) {
            newpos = self.puzzleView.touchLayer.position;
        }else if (delta.x < 0 && ![board canMoveLeft]){
            newpos = self.puzzleView.touchLayer.position;
        }
        
        CGFloat pieceWidth;
        if([board getCurrentPieceDirection]%2 == 0){
            pieceWidth = self.puzzleView.current.bounds.size.width;
        }else{
            pieceWidth = self.puzzleView.current.bounds.size.height;
        }
        
        NSInteger row = round((self.puzzleView.current.position.x - pieceWidth/2)/blockWidth);
        NSInteger newrow = round((newpos.x - pieceWidth/2)/blockWidth);
        if (newrow != row) newrow > row ? [board moveRight] : [board moveLeft];
        
        self.puzzleView.touchLayer.position = newpos;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    TetrisBoard *board = appDelegate.board;
    
    if(self.puzzleView.touchLayer != nil){
        CGFloat blockWidth = self.puzzleView.bounds.size.width/10;
        CGFloat pieceWidth;
        if([board getCurrentPieceDirection]%2 == 0){
            pieceWidth = self.puzzleView.current.bounds.size.width;
        }else{
            pieceWidth = self.puzzleView.current.bounds.size.height;
        }
        
        NSInteger row = round((self.puzzleView.current.position.x - pieceWidth/2)/blockWidth);
        CGPoint  newpos = CGPointMake(blockWidth*row + pieceWidth/2, self.puzzleView.current.position.y);
        
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
