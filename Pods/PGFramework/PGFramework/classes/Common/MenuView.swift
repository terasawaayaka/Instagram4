//
//  MenuView.swift
//  PGFramework
//
//  Created by Hiroki Umatani on 2020/01/28.
//  Copyright © 2020 Playground. All rights reserved.
//

import UIKit


public protocol MenuViewDelegate: NSObjectProtocol{
    func tableView(indexPath: IndexPath)
}

extension MenuViewDelegate {
    public func tableView(indexPath: IndexPath){}
}
// MARK: - Property
public class MenuView: UIView {
    public weak var delegate: MenuViewDelegate? = nil

    // outlet
    var view: UIView?
    @IBOutlet weak var tableView: BaseTableView!
}

// MARK: - Life cycle
extension MenuView {
    override open func awakeFromNib() {
        super.awakeFromNib()
        loadView()
        setDelegates()
        loadCells()
    }
}

// MARK: - Protocol
extension MenuView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath)
        return cell
    }
}

extension MenuView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.tableView(indexPath: indexPath)
        }
    }
}

// MARK: - method
extension MenuView {
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadCells() {
        let bundle = Bundle(for: MenuTableViewCell.self)
        let nib = UINib(nibName: "MenuTableViewCell", bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    func loadView() {
        let bundle = Bundle(for: type(of: self))
        view = bundle.loadNibNamed(className, owner: self, options: nil)!.first as? UIView

        guard let view = view else { return }

        view.frame = bounds
        view.autoresizingMask =
            [.flexibleHeight,
             .flexibleWidth]
        addSubview(view)
        initHideHeaderView()
    }

    public func initHideHeaderView() {
        self.transform = CGAffineTransform.init(translationX: -self.frame.width * 2, y: 0)
    }

    public func showMenuView() {
        UIView.animate(withDuration: 0.4) {
            self.transform = CGAffineTransform.identity
        }
    }

    public func hideMenuView() {
        UIView.animate(withDuration: 0.4) {
            self.transform = CGAffineTransform.init(translationX: -self.frame.width * 2, y: 0)
        }
    }
}
