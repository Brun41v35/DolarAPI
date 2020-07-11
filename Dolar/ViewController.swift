//
//  ViewController.swift
//  Dolar
//
//  Created by Bruno Alves da Silva on 08/07/20.
//  Copyright © 2020 Bruno Alves da Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lbValorDolar: UILabel!
    
    @IBOutlet weak var btAtualizarDolar: UIButton!
    
    @IBAction func btAtualizar(_ sender: Any) {
        self.atualizaValorDolar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func formatarPreco(preco: NSNumber) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = numberFormatter.string(from: preco) {
            return precoFinal
        }
        return "0,00"
    }
    
    func atualizaValorDolar() {
        
        //Alterando o texto do botao
        self.btAtualizarDolar.setTitle("Atualizando...", for: .normal)
        
        //Variavel responsavel pela consulta
        if let url = URL(string: "https://economia.awesomeapi.com.br/json/all") {
            
            let tarefa = URLSession.shared.dataTask(with: url) { (dados, requisicao, erro) in
                if (erro == nil) {
                    
                    if let retornoJson = dados {
                        
                        do {
                            if let objetoJson = try JSONSerialization.jsonObject(with: retornoJson, options: []) as? [String: Any] {
                                if let usd = objetoJson["USD"] as? [String: Double] {
                                    if let preco = usd["high"] {
                                        print(String(format: "%.02f", preco))
                                    }
                                }
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    
                } else {
                    
                }
            }
            tarefa.resume()
        }
    }
}

