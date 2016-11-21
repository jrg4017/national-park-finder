//
//  UIPickerDelegate.swift
//  national-park-finder
//
//  Created by Julianna Gabler on 11/17/16.
//  Copyright © 2016 Julianna Gabler. All rights reserved.
//

import UIKit

/**
  * extension handles the needs for UIPickerViewDelegate, UIPickerViewDataSource
  * see MapViewController
  */
extension MapViewController: UIPickerViewDelegate, UIPickerViewDataSource {
/**************** delegate functions **************************/
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(row) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
/**************** UIPickerViewDataSource functions ***********/
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    
/**************** helper functions **************************/
    
    //updates the view when different control is selected
    func updateMapViewType(_ selection: Int) {
        switch(selection) {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    } //end updateViewMapType
}
