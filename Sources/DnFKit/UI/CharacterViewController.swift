//
//  dnfViewController.swift
//  DnFKit
//
//  Created by 라주영 on 4/22/25.
//

import UIKit

public class CharacterViewController: UIViewController {
    let character: Character
    
    public init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
