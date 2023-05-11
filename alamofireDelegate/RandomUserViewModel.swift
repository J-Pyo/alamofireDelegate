//
//  RandomUserViewModel.swift
//  alamofireDelegate
//
//  Created by 홍정표 on 2023/03/26.
//

import Foundation
protocol RandomUserViewModelDelegate: AnyObject {
  func didUpdateState(to state: RandomUserViewModelState)
}
enum RandomUserViewModelState {
  /// RandomUser 조회 완료
  case gotRandomUser
  /// 에러
  case error(reason: String)
}
class RandomUserViewModel {
    weak var delegate: RandomUserViewModelDelegate?
    
    var randomUsers: [RandomUser] = []{
        didSet{
            self.delegate?.didUpdateState(to: .gotRandomUser)
        }
    }
    var api = APIServices()
    var pagingNumber = 50
    var paging = false
    func fetchRandomUsers(){
        let baseUrl = "https://randomuser.me/api/?results=\(pagingNumber)&gender=female"
        
        api.protocolWithAlamo(urlString: baseUrl) { result in
            guard let result = result else{
                self.delegate?.didUpdateState(to: .error(reason: "NOT FETCH DATA"))
                return
            }
            
            self.randomUsers = result
        }
    }
    func addRandomUser(){
        let baseUrl = "https://randomuser.me/api/?results=\(pagingNumber)&gender=female"
        let existUser = self.randomUsers
        var newUser: [RandomUser] = []
        if !paging{
            paging = true
            api.protocolWithAlamo(urlString: baseUrl) { result in
                guard let result = result else{
                    self.delegate?.didUpdateState(to: .error(reason: "NOT FETCH DATA"))
                    return
                }
                newUser = result
                for user in existUser {
                    for (index, new) in newUser.enumerated() {
                        if new.login.uuid == user.login.uuid{
                            print("dup : \(newUser[index])")
                            newUser.remove(at: index)
                        }
                    }
                }
                self.randomUsers.append(contentsOf: newUser)
                self.paging = false
            }
        }else{
            print("now paging")
        }
    }
    
}
