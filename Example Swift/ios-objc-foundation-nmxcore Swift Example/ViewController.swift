    -(void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
    {
        mapListTableView.hidden =YES;
        
        latString =[NSString stringWithFormat:@"%f", coordinate.latitude];
        longString = [NSString stringWithFormat:@"%f",coordinate.longitude];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        [dic setObject:latString forKey:@"latitude"];
        [dic setObject:longString forKey:@"longitude"];
        
        [currentarr addObject:dic];
        
        [_mapView clear];
        [self creatingPathOfCoordinatesArray:currentarr];
    }

    -(void)creatingPathOfCoordinatesArray:(NSMutableArray*)array
    {
        
        GMSMutablePath *databasePath = [GMSMutablePath path];
        
        for (int i=0; i<array.count; i++)
        {
            NSString* currentLat = [NSString stringWithFormat:@"%f",[[[array objectAtIndex:i] objectForKey:@"latitude"] doubleValue]];
            NSString* currentLng = [NSString stringWithFormat:@"%f",[[[array objectAtIndex:i] objectForKey:@"longitude"] doubleValue]];
            
            [databasePath addCoordinate:CLLocationCoordinate2DMake([currentLat doubleValue], [currentLng doubleValue])];
            
        }
        
        if ([mapType isEqualToString:@"polygon"] && array.count>2)
        {
            NSString* lastLat = [NSString stringWithFormat:@"%f",[[[array objectAtIndex:0] objectForKey:@"latitude"] doubleValue]];
            NSString* lastLng = [NSString stringWithFormat:@"%f",[[[array objectAtIndex:0] objectForKey:@"longitude"] doubleValue]];
            
            [databasePath addCoordinate:CLLocationCoordinate2DMake([lastLat doubleValue], [lastLng doubleValue])];
        }
        [self polyCreation:databasePath ofCoordinateArray:array];
        
    }

