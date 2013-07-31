//
//  StatsScreen.m
//  FitNexus
//
//  Created by keith on 07/09/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "StatsScreen.h"


@implementation StatsScreen

//@synthesize myDBControler;
@synthesize myStatsView;
//@synthesize myDBControler;
@synthesize myMap;
@synthesize myLocationGetter;

@synthesize livesLabel;
@synthesize scoreLabel;

int orX,orY, curX,curY;
bool first;


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

-(int)setAT : (double) value : (int) index
{
	[myStatsView setAT:value :index];
	if(baseTime < value)
	{
		//baseTime = value;
		//[myStatsView setBaseTime:value];
	}
	return 0;
}
-(int)setAX : (double) value : (int) index
{
	[myStatsView setAX:value :index];
	return 0;
} 
-(int)setAY : (double) value : (int) index
{
	[myStatsView setAY:value :index];
	return 0;
} 
-(int)setAZ : (double) value : (int) index
{
	[myStatsView setAZ:value :index];
	return 0;
} 

-(int)setLT : (double) value : (int) index
{
	[myStatsView setLT:value :index];
	return 0;
} 
-(int)setLLat : (double) value : (int) index
{
	[myStatsView setLLat:value :index];
	return 0;
} 
-(int)setLLong : (double) value : (int) index
{
	[myStatsView setLLong:value :index];
	return 0;
}





// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
		//[self setInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
	//myDBControler = [DataBaseControler alloc];
	//[myDBControler initWithOwner:self];
	

	//myStatsView.alpha = 0.50;
	
	//myDBControler = [DataBaseControler alloc];
	//[myDBControler initWithOwner:self];
	
	//[myDBControler DBloadIntoStatsView];
	baseTime = 0.0;
	
	//myMap.alpha = 0.0;
	location.latitude = [myStatsView getLlat:locIndex ];
	location.longitude = [myStatsView getLlong:locIndex];	
	[myMap setCenterCoordinate:location];
	
	[myStatsView initWithOwner:self];
	
	MKCoordinateRegion region;
	//Set Zoom level using Span
	MKCoordinateSpan span;  
	region.center=myMap.region.center;
	
	span.latitudeDelta=myMap.region.span.latitudeDelta /20000.0002;
	span.longitudeDelta=myMap.region.span.longitudeDelta /20000.0002;
	region.span=span;
	[myMap setRegion:region animated:TRUE];
	myLocationGetter =  [LocationGetter alloc] ;
	[myLocationGetter initWithOwner:self];	
	locIndex = 0;
	first = true;
		
[NSTimer scheduledTimerWithTimeInterval:(1.0/20) target:self selector:@selector(tick) userInfo:nil repeats:YES];
		
    [super viewDidLoad];
	
	//CGRect rect3 = CGRectMake(0, 0, 500, 500);

	//[self drawRect: CGRectMake(0, 0, 500, 500)];
}
- (void)updateMap
{
	if([myStatsView getLlat:locIndex] != 0.0)
	   {
	location.latitude = [myStatsView getLlat:locIndex ];
	location.longitude = [myStatsView getLlong:locIndex];	
	
	//[myMap setCenterCoordinate:location];
	}
	
}
- (void)tick
{
	//NSLog(@"tick");
	locIndex++;
	[self updateMap];
	baseTime ++;
	[myStatsView setBaseTime:baseTime];
	
	livesLabel.text = [NSString stringWithFormat:@"Lives: %d",[myStatsView getLives]];
	scoreLabel.text = [NSString stringWithFormat:@"Score: %d",[myStatsView getScores]];
	
	
	
	//self.interfaceOrientation = ;
	//[myStatsView drawRect: CGRectMake(100, 100, 100, 100)];
}

-(int)getsLoc : (double) locLat: (double) locLong : (double) locAlt: (double) LocHAccuracy :  (double) LocVAccuracy
{
	//NSLog(@"GETS LOC METHOD CALLED %f, %f",locLat,locLong);
	//NSLog(@"Undating lable");
	//NSString statusTemp =  @"LOC %f %f",locLat,locLong;
	//statusText.text = statusTemp;
	//NSLog(@"Undating save");
	
	//-(int)saveDataPoint: (NSString *) datetime : (NSString *) datatype : (double) floatData: (NSString *) stringData : (double) errorMargin;
	
	//int time = [self getTime];
	/*[myDBControler saveDataPoint:[self getTime]:@"LOCLAT":locLat:@"0":LocHAccuracy];
	//int time = [self getTime];
	[myDBControler saveDataPoint:[self getTime]:@"LOCLONG":locLong:@"0":LocHAccuracy];
	//int time = [self getTime];
	[myDBControler saveDataPoint:[self getTime]:@"LOCALT":locAlt:@"0":LocVAccuracy];
	//NSLog(@"Done");
	//location 
	//locStatus =[NSString stringWithFormat:@"Location:\n\tlong:%f\n\tlat:%f",locLong,locLat];
	//statusText.text = [NSString stringWithFormat:@"%f %@ %@",[self getTime],locStatus,accStatus];
	return 0;
	 
	 */
	
	//NSLog(@"Got loc-> %f lat-> %f",locLat,locLong);

	
	
[myStatsView setLLat:locLat];
[myStatsView setLLong:locLong];
	
	

	
	// Get first location and use as 0,0 point
	//after that get distance long and distance lat in Meters from current point
	
	
}



//- (void)drawRect:(CGRect)rect  {

//}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[myStatsView release];
    [super dealloc];
}


@end
