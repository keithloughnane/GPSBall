//
//  statsView.h
//  FitNexus
//
//  Created by keith on 07/10/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface statsView : UIView {
	
double aTime[1000];
	double aX[1000];
	double aY[1000];
	double aZ[1000];
	
	double lTime[1000];
double llat[1000];
double llong[1000];
	
	id myOwner;
	double baseTime;
	
	CLLocation *loc1;
	

	
}

//@property  int lives;

-(int)initWithOwner : (id) owner;

-(int)setAT : (double) value : (int) index; 
-(int)setAX : (double) value : (int) index; 
-(int)setAY : (double) value : (int) index; 
-(int)setAZ : (double) value : (int) index;

-(int)getLives;
-(int)getScores;
-(int)reinitalise;

-(int)setLT : (double) value : (int) index; 
-(int)setLLat : (double) value; 
-(int)setLLong : (double) value;
-(int)setBaseTime : (double) time;

-(double)getLlat: (int) index;
-(double)getLlong: (int) index;

@end
