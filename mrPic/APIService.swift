//
//  APIService.swift
//  mrPic
//
//  Created by 홍정표 on 2023/03/26.
//

import Alamofire
import Foundation

class APIServices{
    /**
     * Alamofire url get방식을 사용한 통신
     */
    func protocolWithAlamo(urlString: String,completition: @escaping ([RandomUser]?) -> Void) {
            //위의 URL와 파라미터를 담아서 POST 방식으로 통신하며, statusCode가 200번대(정상적인 통신) 인지 유효성 검사 진행
            let alamo = AF.request(urlString, method: .get, parameters: nil).validate(statusCode: 200..<300)
            let decoder = JSONDecoder()
            
            //결과값으로 문자열을 받을 때 사용
            alamo.responseString() { response in
                switch response.result
                {
                //통신성공
                case .success(let value):
                    let data: Data = Data(value.utf8)
                    if let userData = try? decoder.decode(RandomUserModel.self, from: data){
                    //escaping으로 통신이 완료 되었을때 bookData.items를 반환
                        completition(userData.results)
                    }else{
                        print("fail")
                    }
                //통신실패
                case .failure(let error):
                    print("error: \(String(describing: error.errorDescription))")
                }
            }
        }
}
