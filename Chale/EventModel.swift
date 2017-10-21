//
//  HomeModel.swift
//  Chale
//
//  Created by Vishnu on 10/21/17.
//  Copyright © 2017 Vishnu. All rights reserved.
//

import Foundation

class EventModel {
    
    private var _eventName: String!
    private var _dateTime: String!
    private var _location: String!
    
    var eventName: String {
        if _eventName == nil {
            _eventName = ""
        }
        return _eventName
    }
    
    var dateTime: String {
        if _dateTime == nil {
            _dateTime = ""
        }
        return _dateTime
    }
    
    var location: String {
        if _location == nil {
            _location = ""
        }
        return _location
    }

    init(eventName: String, dateTime: String, location: String) {
        _eventName = eventName
        _dateTime = dateTime
        _location = location
    }
}
