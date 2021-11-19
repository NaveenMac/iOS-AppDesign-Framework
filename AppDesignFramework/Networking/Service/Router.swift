//
//  NetworkService.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/07.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()
public typealias NetworkRouterProgress = (_ progress: Double)->()
protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    
    func requestWithProgress(_ route: EndPoint, completion: @escaping NetworkRouterCompletion, progessHandler: @escaping NetworkRouterProgress)
    
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
            
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func requestWithProgress(_ route: EndPoint, completion: @escaping NetworkRouterCompletion, progessHandler: @escaping NetworkRouterProgress) {
        let session = URLSession.shared
        var observation:Int?
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
            observation = task?.progress.observe(\.fractionCompleted, changeHandler: { progess, _ in
                progessHandler(progess.fractionCompleted)
            })
        }catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
                        case .request:
                            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        case .requestParameters(let bodyParameters,
                                                let bodyEncoding,
                                                let urlParameters):
                            
                            try self.configureParameters(bodyParameters: bodyParameters,
                                                         bodyEncoding: bodyEncoding,
                                                         urlParameters: urlParameters,
                                                         request: &request)
                            
                        case .requestParametersAndHeaders(let bodyParameters,
                                                          let bodyEncoding,
                                                          let urlParameters,
                                                          let additionalHeaders):
                            
                            self.addAdditionalHeaders(additionalHeaders, request: &request)
                            try self.configureParameters(bodyParameters: bodyParameters,
                                                         bodyEncoding: bodyEncoding,
                                                         urlParameters: urlParameters,
                                                         request: &request)
                        case .multipartRequest(let headers, let parameters):
                            try configureMultipartRequest(headers, parameters: parameters, request: &request)
                        }

            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func configureMultipartRequest(_ additionalHeaders: HTTPHeaders?, parameters:Parameters?, request: inout URLRequest) throws {
        guard let headers = additionalHeaders else { throw Exceptions.InternalError.badRequest}
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
         

        let boundary = "Boundary-\(UUID().uuidString)"
         
        var body = Data()
        if let paramName = parameters?["key"] as? String,
           let paramSrc = parameters?["path"] as? String,
           let filename = parameters?["name"] as? String,
           let fileData = parameters?["data"] as? Data{
         
            let splitName = filename.split(separator: ".")
                let name = String(describing: splitName.first)
               
            var contentType:String?
            
            switch NSString(string: filename).pathExtension {
            case "png":
                contentType = "image/png"
            case "jpg","jpeg":
                contentType = "image/jpg"
            case "pdf":
                contentType = "application/pdf"
            default:
                print("Unknown Content Type")
            }
            
            guard let content_type = contentType else {
                return
            }
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition:form-data; name=\"body\";")
            
            body.append("filename=\"\(filename)\"\r\n")
            body.append("Content-Type: \(content_type)\r\n\r\n")
            body.append(fileData)
            body.append("\r\n");
            body.append("--\(boundary)--\r\n");
        }
        
        
        
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
    }
    
    
}

