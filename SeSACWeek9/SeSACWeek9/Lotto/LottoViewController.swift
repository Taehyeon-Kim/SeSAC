//
//  LottoViewController.swift
//  SeSACWeek9
//
//  Created by taekki on 2022/09/01.
//

import UIKit

final class LottoViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchLottoAPI(drwNo: 1000)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            self.viewModel.fetchLottoAPI(drwNo: 1022)
        }
        
        bind()
    }
}

extension LottoViewController {
    
    func bind() {
        viewModel.number1.bind { value in
            self.label1.text = "\(value)"
        }
        
        viewModel.number2.bind { value in
            self.label2.text = "\(value)"
        }
        
        viewModel.number3.bind { value in
            self.label3.text = "\(value)"
        }
        
        viewModel.number4.bind { value in
            self.label4.text = "\(value)"
        }
        
        viewModel.number5.bind { value in
            self.label5.text = "\(value)"
        }
        
        viewModel.number6.bind { value in
            self.label6.text = "\(value)"
        }
        
        viewModel.number7.bind { value in
            self.label7.text = "\(value)"
        }
        
        viewModel.lottoMoney.bind { value in
            self.dateLabel.text = "\(value)"
        }
    }
}
