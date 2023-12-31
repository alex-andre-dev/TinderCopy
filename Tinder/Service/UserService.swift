//
//  UserService.swift
//  Tinder
//
//  Created by Alexandre  Machado on 11/07/23.
//

import Foundation

class UserService{
    
    static let shared = UserService()
    
    let users: [User] = [
        User(id: 101, name: "Maria Silva", age: 19, match: true, phrase: "O último a dar match chama", picture: "pessoa-1"),
        User(id: 102, name: "Debora Lima", age: 25, match: false, phrase: "Deu like sem querer?", picture: "pessoa-2"),
        User(id: 103, name: "Sandra Souza", age: 24, match: false, phrase: "Acho q a gente combina", picture: "pessoa-3"),
        User(id: 104, name: "Anna Beatriz", age: 22, match: true, phrase: "Não bebo não fumo e não curto balada", picture: "pessoa-4"),
        User(id: 105, name: "Laura Oliveira", age: 26, match: true, phrase: "Quer saber mais sobre mim?", picture: "pessoa-5"),
        User(id: 106, name: "Silva Paz", age: 19, match: false, phrase: "Se não for conversar nem dá like", picture: "pessoa-6"),
        User(id: 107, name: "Debora Lima", age: 25, match: false, phrase: "Em busca de novas amizades", picture: "pessoa-7"),
        User(id: 108, name: "Sandra Souza", age: 24, match: true, phrase: "Fotos sem camisa não me impressionam", picture: "pessoa-8"),
        User(id: 109, name: "Tah Beatriz", age: 22, match: false, phrase: "Oi pelo visto a gente combina", picture: "pessoa-9"),
        User(id: 110, name: "Laura Oliveira", age: 26, match: true, phrase: "Procurando um bom papo", picture: "pessoa-10"),
        User(id: 111, name: "Sabrina Santos", age: 21, match: false, phrase: "Quem se descreve se limita", picture: "pessoa-11"),
        User(id: 112, name: "Amelia Margaret", age: 30, match: false, phrase: "Não quero nada casual", picture: "pessoa-12"),
        User(id: 113, name: "Laura Komako", age: 26, match: true, phrase: "Bom humor é fundamental", picture: "pessoa-13"),
        User(id: 114, name: "Rosa Oliveira", age: 25, match: false, phrase: "Não sei me descrever", picture: "pessoa-14"),
        User(id: 115, name: "Nadia Joana", age: 20, match: false, phrase: "Quer saber mais? é só dar like", picture: "pessoa-15"),
        User(id: 116, name: "Mary Dandara", age: 20, match: false, phrase: "Tenho um relacionamento aberto", picture: "pessoa-16"),
        User(id: 117, name: "Anita Eleanor", age: 23, match: false, phrase: "Bonita demais pra ser verdade", picture: "pessoa-17"),
        User(id: 118, name: "Helen Aung San", age: 24, match: true, phrase: "Espero q vc seja mente aberta", picture: "pessoa-18"),
        User(id: 119, name: "Laura Nelle", age: 18, match: false, phrase: "Estou aqui para fazer novas amizades", picture: "pessoa-19"),
        User(id: 120, name: "Maria Virginia", age: 18, match: false, phrase: "Adoro balada", picture: "pessoa-20")
    ]

    func searchUsers(completion: @escaping ([User]?, Error?) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0){
        completion(self.users, nil)
        }
    }
}
