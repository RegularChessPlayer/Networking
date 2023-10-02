//import Foundation
//
//class APIRequest<Resource>  {
//    let resource: Resource
//
//    init(resource: APIResource) {
//        self.resource = resource
//    }
//}
//
//extension APIRequest: NetworkRequest {
//    func decode(_ data: Data) throws -> [APIResource.ModelType] {
//        let wrapper = try JSONDecoder.apiDecoder
//            .decode(Wrapper.self, from: data)
//        return wrapper.items
//    }
//
//    func execute() async throws -> [APIResource.ModelType] {
//        try await load(resource.url)
//    }
//}
