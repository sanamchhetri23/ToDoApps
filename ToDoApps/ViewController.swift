import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ToDoTableViewCellDelegate {
    
    @IBOutlet var UserTitle: UITextField!
    @IBOutlet var UserDescription: UITextField!
    @IBOutlet var ToDoTableView: UITableView!
    
    struct ToDoItem {
        let title: String
        let description: String
    }
    
    var toDoList: [ToDoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoTableView.dataSource = self
        ToDoTableView.delegate = self
    }
    
    @IBAction func AddButtonTapped(_ sender: UIButton) {
        if let title = UserTitle.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let description = UserDescription.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           !title.isEmpty, !description.isEmpty {
            
            let newToDo = ToDoItem(title: title, description: description)
            toDoList.append(newToDo)
            ToDoTableView.reloadData()
            
            UserTitle.text = ""
            UserDescription.text = ""
        } else {
            showAlert(message: "Please enter valid title and description.")
        }
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error !!!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoIdentifier", for: indexPath) as? ToDoTableViewCell else {
            return UITableViewCell()
        }
        
        let toDoItem = toDoList[indexPath.row]
        cell.ResultTitle.text = toDoItem.title
        cell.ResultDescription.text = toDoItem.description
        cell.delegate = self // Set the delegate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func didTapDeleteButton(_ cell: ToDoTableViewCell) {
        if let indexPath = ToDoTableView.indexPath(for: cell) {
            toDoList.remove(at: indexPath.row)
            ToDoTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
