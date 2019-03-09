//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by David Andres Cespedes on 3/8/19.
//  Copyright © 2019 David Andres Cespedes. All rights reserved.
//

import UIKit

public class SelectQuestionsGroupViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: - Properties
    public let questionsGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!
}

// MARK: - UITableViewDataSource
extension SelectQuestionsGroupViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsGroups.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionsGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectQuestionsGroupViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionsGroups[indexPath.row]
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? QuestionViewController else { return }
        viewController.questionGroup = selectedQuestionGroup
        viewController.delegate = self
    }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionsGroupViewController: QuestionViewControllerDelegate {
    func questionViewController(_ viewcontroller: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    func questionViewController(_ viewController: QuestionViewController, diComplete questionsGroup: QuestionGroup) {
        navigationController?.popToViewController(self, animated: true)
    }
}
