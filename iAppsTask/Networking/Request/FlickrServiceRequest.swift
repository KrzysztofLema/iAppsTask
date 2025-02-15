//
//  Untitled.swift
//  iAppsTask
//
//  Created by Krzysztof Lema on 14/02/2025.
//

import Foundation

struct FlickrServiceRequest: ServiceRequest {
    
    var endpoint: ServiceEndpoint?
    var parameters: [URLQueryItem]?
    var body: [String: AnyObject]? = nil
    var additionalHeaders: [HTTPHeaderField: String] = [:]
    
    var host: String {
        "api.flickr.com"
    }
    
    func buildRequest() -> URLRequest? {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
    
        if !urlParams.isEmpty {
          components.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let finalURL = components.url else { return nil }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        for (headerField, value) in additionalHeaders {
            request.addValue(value, forHTTPHeaderField: headerField.rawValue)
        }
        
        return request
    }
    
    var method: HTTPMethod {
        switch endpoint {
        case .flickrCategory:
            return .get
        case .none:
            return .get
        }
    }
    
    var urlParams: [String: String?] {
        switch endpoint {
        case .flickrCategory(let category):
            var params = ["format": "json"]
            params["nojsoncallback"] = "1"
            params["tags"] = category
            return params
      
        case .none:
            return [:]
        }
    }
    
    var path: String {
        switch endpoint {
        case .flickrCategory:
            return "/services/feeds/photos_public.gne"
        case nil:
            return ""
        }
    }
}
