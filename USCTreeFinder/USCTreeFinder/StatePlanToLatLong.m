//
//  StatePlanToLatLong.m
//  USCTreeFinder
//
//  Created by Dayton Pruet on 5/31/14.
//  Copyright (c) 2014 PruetSoftwareLLC. All rights reserved.
//

#import "StatePlanToLatLong.h"
#import <Math.h>
#import <CoreLocation/CoreLocation.h>

@implementation StatePlanToLatLong


- (CLLocationCoordinate2D)convert:(float)xCoord YCoordinate:(float)yCoord {
    
    // North is Y
    // East is X
    
    
    
    double x = xCoord;
    double y = yCoord;
    
    x = x * 0.3048;
    y = y * 0.3048;
    
    double lat,lon;
    
    double a,e,angRad,pi4,p0,p1,p2,m0,x0f,x0;
    
    int method = 2;
    
    //double cmf = 1.0;
    
    angRad = M_PI / 180;      //' number of radians in a degree
    pi4 = M_PI / 4;    //' Pi / 4
    
    a = 6378137.0;      //' major radius of ellipsoid
    e = 0.08181919092890624;        //' eccentricity of ellipsoid
    
    x0f = 2000000.0;
    x0 = x0f * 0.3048;  //' False easting of central meridian, map units
    
    if (method == 1) {
        p0 = 33 * angRad;         //' latitude of origin
        p1 = 33.76666666666667 * angRad;            //' latitude of first standard parallel
        p2 = 34.96666666666667 * angRad;            //' latitude of second standard parallel
        m0 = -81 * angRad;        //' central meridian
    } else if (method == 2) {
        p0 = 31.83333333333333 * angRad;         //' latitude of origin
        p1 = 32.33333333333334 * angRad;            //' latitude of first standard parallel
        p2 = 33.66666666666666 * angRad;            //' latitude of second standard parallel
        m0 = -81 * angRad;        //' central meridian
    } else if (method == 3) {
        p0 = 31.83333333333333 * angRad;         //' latitude of origin
        p1 = 34.83333333333334 * angRad;            //' latitude of first standard parallel
        p2 = 32.5 * angRad;            //' latitude of second standard parallel
        m0 = -81 * angRad;        //' central meridian
    } else if (method == 4) {
        p0 = 31.83333333333333 * angRad;         //' latitude of origin
        p1 = 32.5 * angRad;            //' latitude of first standard parallel
        p2 = 34.83333333333334 * angRad;            //' latitude of second standard parallel
        m0 = -81 * angRad;        //' central meridian
    }
    
    
    //' Calculate the coordinate system constants.
    double m1 = cos(p1) / sqrt(1 - pow(((e * e) * sin(p1)),2) );
    double m2 = cos(p2) / sqrt(1 - pow(((e * e) * sin(p2)),2) );
    double t0 = tan(pi4 - (p0 / 2));
    double t1 = tan(pi4 - (p1 / 2));
    double t2 = tan(pi4 - (p2 / 2));
    t0 = t0 / (  pow(    ((1 - (e * (sin(p0)))) / (1 + (e * (sin(p0))))),(e / 2)  )   );
    t1 = t1 / (  pow(    ((1 - (e * (sin(p1)))) / (1 + (e * (sin(p1))))),(e / 2)  )   );
    t2 = t2 / (  pow(    ((1 - (e * (sin(p2)))) / (1 + (e * (sin(p2))))),(e / 2)  )   );
    double n = log(m1 / m2) / log(t1 / t2);
    double f = m1 / (n * pow(t1,n)  );
    double rho0 = a * f * pow(t0,n);
    
    
    //' Convert the coordinate to Latitude/Longitude.
    
    //' Calculate the Longitude.
    x = x - x0;
    double pi2 = pi4 * 2;
    double rho = sqrt(     pow(x,2) + (     pow((rho0 - y),2)    ));
    double theta = atan(x / (rho0 - y));
    double t =  pow(    (rho / (a * f)) , (1 / n)   )   ;
    lon = (theta / n) + m0;
    x = x + x0;
    
    
    //' Estimate the Latitude
    double lat0 = pi2 - (2 * atan(t));
    
    //' Substitute the estimate into the iterative calculation that
    //' converges on the correct Latitude value.
    double part1 = (1 - (e * sin(lat0))) / (1 + (e * sin(lat0)));
    double lat1 = pi2 - (2 * atan(t * (    pow( part1,(e / 2))       )));
    
    
    //Do Until Abs(lat1-lat0) < 0.000000002
    while ( abs(lat1 - lat0) > 0.000000002) {
        lat0 = lat1;
        part1 = (1 - (e * sin(lat0))) / (1 + (e * sin(lat0)));
        lat1 = pi2 - (2 * atan(t * (  pow(   part1,(e / 2) )     )));
    }
    
    /*
     Do Until Abs(lat1 - lat0) < 0.000000002
     lat0 = lat1
     part1 = (1 - (e * Sin(lat0))) / (1 + (e * Sin(lat0)))
     lat1 = pi2 - (2 * Atn(t * (part1 ^ (e / 2))))
     Loop
    */
    
    
    
    //' Convert from radians to degrees.
    
    
    lat = lat1 / angRad;
    lon = lon  / angRad;
    
    //' Calcuate degrees, minutes, and seconds.
    //double dLat = floor(lat);
    //double mLat = 60 * (lat - dLat);
    //double sLat = 60 * (mLat - floor(mLat));
    //mLat = floor(mLat);
    
    //lon = 0 - lon;
    //double dLon = floor(lon);
    //double mLon = 60 * (lon - dLon);
    //double sLon = 60 * (mLon - floor(mLon));
    //mLon = floor(mLon);
    //lon = 0 - lon;
    //dLon = 0 - dLon;
    
    //'Round the seconds
    //sLat = (CLng(sLat * 100)) / 100;
    //sLon = (CLng(sLon * 100)) / 100;
    
    CLLocationCoordinate2D treeLocation;
    treeLocation.latitude = lat;
    treeLocation.longitude = lon;
    
    return treeLocation;
}



@end


/*
 
 
 y = Request("y")
 x = Request("x")
 
 If y = "" or x = "" Then
 Response.Write "No value entered</title><body bgcolor=#ffffff>"
 Response.Write "<h2>No value was entered for Northing or Easting</h2>"
 Response.Write "</body></html>"
 Response.End
 End If
 
 ' Set up the coordinate system parameters.
 'a = 6378206.4              ' major radius of ellipsoid, map units (NAD 27)
 'e = 0.08227185422          ' eccentricity of ellipsoid (NAD 27)
 a = 6378137                ' major radius of ellipsoid, map units (NAD 83)
 e = 0.08181922146          ' eccentricity of ellipsoid (NAD 83)
 angRad = 0.01745329252     ' number of radians in a degree
 pi4 = 3.141592653582 / 4   ' Pi / 4
 p0 = 44.25 * angRad        ' latitude of origin
 p1 = 45 * angRad           ' latitude of first standard parallel
 p2 = 49 * angRad           ' latitude of second standard parallel
 m0 = -109.5 * angRad       ' central meridian
 x0 = 600000                ' False easting of central meridian, map units
 
 ' Calculate the coordinate system constants.
 m1 = Cos(p1) / Sqr(1 - ((e ^ 2) * Sin(p1) ^ 2))
 m2 = Cos(p2) / Sqr(1 - ((e ^ 2) * Sin(p2) ^ 2))
 t0 = Tan(pi4 - (p0 / 2))
 t1 = Tan(pi4 - (p1 / 2))
 t2 = Tan(pi4 - (p2 / 2))
 t0 = t0 / (((1 - (e * (Sin(p0)))) / (1 + (e * (Sin(p0)))))^(e / 2))
 t1 = t1 / (((1 - (e * (Sin(p1)))) / (1 + (e * (Sin(p1)))))^(e / 2))
 t2 = t2 / (((1 - (e * (Sin(p2)))) / (1 + (e * (Sin(p2)))))^(e / 2))
 n = Log(m1 / m2) / Log(t1 / t2)
 f = m1 / (n * (t1 ^ n))
 rho0 = a * f * (t0 ^ n)
 
 ' Convert the coordinate to Latitude/Longitude.
 
 ' Calculate the Longitude.
 x = x - x0
 pi2 = pi4 * 2
 rho = Sqr((x ^ 2) + ((rho0 - y) ^ 2))
 theta = Atn(x / (rho0 - y))
 t = (rho / (a * f)) ^ (1 / n)
 lon = (theta / n) + m0
 x = x + x0
 
 ' Estimate the Latitude
 lat0 = pi2 - (2 * Atn(t))
 
 ' Substitute the estimate into the iterative calculation that
 ' converges on the correct Latitude value.
 part1 = (1 - (e * Sin(lat0))) / (1 + (e * Sin(lat0)))
 lat1 = pi2 - (2 * Atn(t * (part1 ^ (e / 2))))
 Do Until Abs(lat1 - lat0) < 0.000000002
 lat0 = lat1
 part1 = (1 - (e * Sin(lat0))) / (1 + (e * Sin(lat0)))
 lat1 = pi2 - (2 * Atn(t * (part1 ^ (e / 2))))
 Loop
 
 ' Convert from radians to degrees.
 lat = lat1 / angRad
 lon = lon / angRad
 
 'Round the latitude and longitude
 lat = (CLng(lat * 100000)) / 100000
 lon = (CLng(lon * 100000)) / 100000
 
 ' Calcuate degrees, minutes, and seconds.
 dLat = int(lat)
 mLat = 60 * (lat - dLat)
 sLat = 60 * (mLat - int(mLat))
 mLat = int(mLat)
 
 lon = 0 - lon
 dLon = int(lon)
 mLon = 60 * (lon - dLon)
 sLon = 60 * (mLon - int(mLon))
 mLon = int(mLon)
 lon = 0 - lon
 dLon = 0 - dLon
 
 'Round the seconds
 sLat = (CLng(sLat * 100)) / 100
 sLon = (CLng(sLon * 100)) / 100
 
 */
