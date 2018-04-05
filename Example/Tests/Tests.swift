import UIKit
import XCTest
import AeroSwift

struct TestModel : Codable {
    
    let fullName : String?
    let id : Int?
    let twitter : String?
    
    
    enum CodingKeys: String, CodingKey {
        case fullName = "fullName"
        case id = "id"
        case twitter = "twitter"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        twitter = try values.decodeIfPresent(String.self, forKey: .twitter)
    }
}

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAPIRequest() {
        let e = expectation(description: "ApiRequest")
        
        let url = "http://www.mocky.io/v2/5ac5f09b4a00004e007e056e"
        
        let headers = ["Content-Type" : "application/json"]
        
        ApiRequest.sharedInstance.request(url, "GET", nil, headers, {(data, status) in
            if let data = data, let testModel = data.decode(TestModel.self), status == 200 {
                XCTAssert(testModel.fullName == "Elon Musk")
                XCTAssert(testModel.id == 123456)
                XCTAssert(testModel.twitter == "https://twitter.com/elonmusk")
            } else {
                XCTAssert(false)
            }
            e.fulfill()
        })
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
