//
//  GenericDataSource.swift
//  MVVMSample
//
//  Created by Dan Mori on 01/06/19.
//  Copyright © 2019 Daniel Mori. All rights reserved.
//

import Foundation

class GenericDataSource<T> : NSObject {
    var data: Observable<[T]> = Observable([])
}
