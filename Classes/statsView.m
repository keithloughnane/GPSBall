//
//  statsView.m
//  FitNexus
//
//  Created by keith on 07/10/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "statsView.h"


@implementation statsView

double orX,orY,curX,curY,ballX,ballY,wallStartX,wallStartY,wallEndX,wallEndY;
double ballX, ballY, ballVX, ballVY;
double paddleX, paddleY;
double paddleWidth,paddleHeight;
double speed;
int scoreIncrement;
//score;
//int lives;
double sizeX,sizeY;
int level;
double screenCenterX,screenCenterY;
int gpsCount;
bool CXSet, CYSet;

 int lives, score;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
	NSLog(@"STATS SCREEN LOADED F");
    return self;
}

- (int) getLives
{
	return lives;
}
- (int) getScores
{
	return score;
}

-(int)reinitalise
{
	for(int i = 0; i<254; i++)
	{
		aTime[i] = aX[i] = aY[i] = aZ[i] =lTime[i] = llat[i] = llong[i] = 0.0;
	}
	
	ballX = 150;
	ballY = 150;
	
	ballVX = 1;
	ballVY = -1;
	score = 0;
	
	lives = 10;
	
	scoreIncrement = 3;
	
	sizeX = 300;
	sizeY = 380;
	
	paddleWidth= 10;
	paddleHeight= 5.0;
	
	
	return 0;
}

-(int)initWithOwner : (id) owner
{
	CXSet = CYSet = false;
	myOwner = owner;
	for(int i = 0; i<254; i++)
	{
		aTime[i] = aX[i] = aY[i] = aZ[i] =lTime[i] = llat[i] = llong[i] = 0.0;
	}
	
	NSLog(@"STATS SCREEN LOADED O");
	screenCenterX = 150;
	screenCenterY = 365;
	
	ballX = 150;
	ballY = 150;
	
	ballVX = 1;
	ballVY = -1;
	score = 0;
	
	lives = 10;
	
	scoreIncrement = 3;
	
	sizeX = 300;
	sizeY = 380;
	
	paddleWidth= 10;
	paddleHeight= 5.0;
	
	
	return 0;
	
}
-(int)setAT : (double) value : (int) index
{
	aTime[index] = value;
	//NSLog(@"got AT");
	//self.alpha = value;
	return 0;
}
-(int)setAX : (double) value : (int) index
{
	aX[index] = value;
	
	//NSLog(@"got AX");
	return 0;
} 
-(int)setAY : (double) value : (int) index
{
	aY[index] = value;
	//NSLog(@"got AY");
	return 0;
} 
-(int)setAZ : (double) value : (int) index
{
	aZ[index] = value;
	//NSLog(@"got AZ");
	return 0;
} 

-(int)setLT : (double) value  : (int) index
{
	lTime[index] = value;
	//NSLog(@"got LT");
	return 0;
} 
-(int)setLLat : (double) value
{
	//llat[index] = value;
	
	
	NSLog(@"got Lat");
	curX = value;
	if(gpsCount < 5)
	{
		//gpsCount --;
		orX = curX;
		CXSet = true;
	}
	return 0;
} 
-(int)setLLong : (double) value
{
	//llong[index] = value;
	
	
	NSLog(@"got Long");
	curY = value;	
	if(gpsCount < 5)
	{
		gpsCount ++;
		orY = curY;
		CYSet = true;
	}
	return 0;
}
-(int)setBaseTime : (double) time
{
	baseTime = time;
	//[self drawRect: CGRectMake(100, 100, 100, 100)];
	return 0;
}

-(double)getLlat: (int) index
{
	[self setNeedsDisplay];
	
	return llat[index];
	
}
-(double)getLlong: (int) index
{
[self setNeedsDisplay];
	
	return llong[index];
}

- (void)drawRect:(CGRect)rect {
	
	ballX += ballVX;
	ballY += ballVY;
	
	CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)orX longitude:(CLLocationDegrees)orY];
	CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:(CLLocationDegrees)curX longitude:(CLLocationDegrees)curY];
	
	double dist = [loc1 getDistanceFrom:loc2];
	
	//NSLog(@"Distance %f",dist);
	
	//NSLog(@"draw Rect called");
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 2.0);
	UIColor		*currentColor;
	//currentColor = [UIColor redColor];
	//CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
	//for(int i = 1; i < 254; i++)
	//{
		/*currentColor = [UIColor redColor];
		CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
	CGContextMoveToPoint(context,screenCenterX-1,screenCenterY+1);
	CGContextAddLineToPoint(context,screenCenterX+1,screenCenterY+1);
		//NSLog(@"drawing from %f to %f",aZ[i-1],aZ[i]);
		CGContextStrokePath(context);*/
	
	
	CGContextSetLineWidth(context, 4.0);
	currentColor = [UIColor whiteColor];
	CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
	CGContextMoveToPoint(context,ballX-2,ballY);
	CGContextAddLineToPoint(context,ballX+2,ballY);
	//NSLog(@"drawing from %f to %f",aZ[i-1],aZ[i]);
	CGContextStrokePath(context);
	
	//draw paddle
	

	currentColor = [UIColor yellowColor];
	CGContextSetLineWidth(context, 5.0);	
	CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
	//CGContextMoveToPoint(context,((screenCenterX+((curX-orX)*1000000)))-10,((screenCenterY+((curY-orY)*1000000)))+1);
	//CGContextAddLineToPoint(context,((screenCenterX+((curX-orX)*1000000)))+10,((screenCenterY+((curY-orY)*1000000)))+1);	
	
	paddleX = dist *5;	
	paddleY = screenCenterY;
	
	
	paddleWidth = 100;
	
	
	CGContextMoveToPoint(context,paddleX-paddleWidth,screenCenterY);
	CGContextAddLineToPoint(context,paddleX+paddleWidth,screenCenterY);	
	//NSLog(@"drawing from %f to %f",aZ[i-1],aZ[i]);
	CGContextStrokePath(context);
	
	
		
	/*	currentColor = [UIColor blueColor];
		CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
		CGContextMoveToPoint(context, (i-baseTime) *2.5, (aY[i-1]*-60)+50);
		CGContextAddLineToPoint(context, ( (i-baseTime)*2.5)+2.5, (aY[i]*-60)+50);
		//NSLog(@"drawing from %f to %f",aY[i-1],aY[i]);
		CGContextStrokePath(context);
		
		currentColor = [UIColor greenColor];
		CGContextSetStrokeColorWithColor(context, currentColor.CGColor);
		CGContextMoveToPoint(context, (i-baseTime) *2.5, (aX[i-1]*-60)+75);
		CGContextAddLineToPoint(context, ( (i-baseTime)*2.5)+2.5, (aX[i]*-60)+75);
		//NSLog(@"drawing from %f to %f",aX[i-1],aX[i]);
		CGContextStrokePath(context);  */
//}
	
	//NSLog(@"size = %f * %f",sizeX,sizeY);
	if(ballX > sizeX||ballX < 0)
		ballVX = ballVX * -1;
	if(ballY < 0)
		ballVY = ballVY * -1;
	if(ballY > sizeY)
	{
		ballVY = ballVY * -1;
		
		lives --;
		
		if(lives <0)
		{
			[self reinitalise];
		}
		
		
		
		NSLog(@"lives = %d",lives);
	
	}
	
	
	
	
	if((ballY == screenCenterY)&&
						 (ballX > paddleX-paddleWidth) && (ballX < paddleX+paddleWidth))
	{
		score += scoreIncrement;
		scoreIncrement ++;
		
		ballVY = ballVY *-1;
		ballVY = ballVY *1.1;
		NSLog(@"Score %d",score);
		if(paddleWidth > 5)
		{
			paddleWidth--;
		}
	}
	
}


- (void)dealloc {
    [super dealloc];
}


@end
