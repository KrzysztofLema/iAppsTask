//
//  Request.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Foundation

public protocol Request {
    
    func buildRequest() -> URLRequest?
}
