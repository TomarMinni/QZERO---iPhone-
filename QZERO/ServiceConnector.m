//
//  ServiceConnector.m
//  Service Reader
//
//  Created by Divan Visagie on 2012/08/25.
//  Copyright (c) 2012 Divan Visagie. All rights reserved.
//

#import "ServiceConnector.h"
#import "JSONDictionaryExtensions.h"
#import "Constants.h"


@implementation ServiceConnector
{
    NSURLConnection *theConnection;
    NSMutableData *receivedData;
}
-(void)getDataFromApi:(NSString*)Url{
    
    
    NSMutableURLRequest *theRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:Url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60.0];
    [theRequest setValue:@"OAI9/IAkW/jA4u+zosKrBKTcqDP9DHM9MtCEvaLZPSg=" forHTTPHeaderField:@"appKey"];
    receivedData = [NSMutableData dataWithCapacity: 0];
    theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!theConnection)
    {
        receivedData = nil;
    }
}
-(void)postDataToApi:(NSString *)parameterString withURLString:(NSString *)urlString
{
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120.0];
    [request setValue:@"OAI9/IAkW/jA4u+zosKrBKTcqDP9DHM9MtCEvaLZPSg=" forHTTPHeaderField:@"appKey"];
    NSData *requestData = [parameterString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    [request setHTTPMethod:@"POST"];
    unsigned long long postLength = [parameterString length];
    NSString *contentLength = [NSString stringWithFormat:@"%llu",postLength];
    [request setValue:contentLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:requestData];
    receivedData = [NSMutableData dataWithCapacity: 0];
    theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!theConnection)
    {
        receivedData = nil;
    }
}

#pragma mark - Data connection delegate -

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    [receivedData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    
    // Append the new data to receivedData.
    
    [receivedData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection

  didFailWithError:(NSError *)error

{
    theConnection = nil;
    
    receivedData = nil;
    
    // inform the user
    
    NSLog(@"Connection failed! Error - %@ %@",
          
          [error localizedDescription],
          
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[receivedData length]);
    [self.delegate requestReturnedData:receivedData];//send the data to the delegate
    theConnection = nil;
    receivedData = nil;
}

@end
