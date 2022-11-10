//
//  CatVC.swift
//  TheCatApi
//
//  Created by Andres Hidalgo on 9/11/2022.
//  Copyright © 2019 Andres Hidalgo. All rights reserved.
//

import UIKit

class CatVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var viewModel: CatViewModel!
    
    static func initWith(title: String, viewModel: CatViewModel) -> CatVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CatVC") as! CatVC
        vc.title = title
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        viewModel.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func setupVC() {
        self.tableView.dataSource = self
        tableView.register(UINib(nibName: "CatCell", bundle: nil), forCellReuseIdentifier:  CatCell.cellIdentifier)
    }
    
    deinit {
        print("deinit: CatVC")
    }
}

extension CatVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CatCell.cellIdentifier, for: indexPath) as! CatCell
        cell.configure(index: indexPath.row, item: viewModel.items[indexPath.row], viewModelService: viewModel)
        return cell
    }
}
