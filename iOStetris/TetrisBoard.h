//
//  TetrisBoard.h
//  iOStetris
//
//  Created by Adam Matthew Bennett on 4/21/15.
//  Copyright (c) 2015 Adam M. Bennett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TetrisBoard : NSObject

@property (strong, nonatomic) NSMutableArray *scoreBoard;
@property (assign, nonatomic) NSInteger score;
@property (assign, nonatomic) NSInteger level;

-(instancetype) init;
-(BOOL)canMoveRight;
-(void)moveRight;
-(BOOL)canMoveLeft;
-(void)moveLeft;
-(BOOL)canMoveDown;
-(void)moveDown;
-(void)lockPiece;
-(BOOL)canRotate;
-(void)rotate;
-(NSInteger)getCurrentPiece;
-(NSInteger)getCurrentPieceXpos;
-(NSInteger)getCurrentPieceYpos;
-(NSInteger)getCurrentPieceDirection;
-(NSInteger)getBlockInRow:(int)row col:(int)col;
-(NSInteger)getScore;
-(void)newGame;
-(void)clearRow:(int)row;
-(BOOL)isFullRow:(int)row;

@end


