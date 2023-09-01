import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var doneButton: UIBarButtonItem?
    var completedTasks = [Task]()
    var header = ["work"]
    var tasks = [Task]() {
        didSet { // 프로퍼티 옵저버, tasks 배열에 할일이 추가될 때마다 유저 디폴트에 할일이 저장됨
            saveTasks()
        }
    }

    // 화면 구현
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        loadTasks() // 유저디폴츠에 저장된 할일을 앱을 껏다 켜도 다시 불러와주는것
    }

    @IBOutlet weak var myTableView: UITableView!
    // Section의 갯수를 정해요.
    func numberOfSections(in tableView: UITableView) -> Int {
        return header.count
    }

    // Section에 따라서 갯수를 정해요
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    // Section에 따라서 Cell을 만들어요.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        // 사용하지 않는 메모리를 낭비하지 않기 위해서 dequeueResusableCell을 이용해서 셀을 재사용 하는 것
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title

        // 셀 표시됐을 때 체크마크 표시되게 하는 코드
        if task.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasks[indexPath.row].done = !tasks[indexPath.row].done

        myTableView.reloadData()

        myTableView.deselectRow(at: indexPath, animated: true)
    }

    // Section Header에 나타날 글자를 정해요
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return header[section]
    }

    @IBAction func buttonAction(_ sender: Any) {
        let alert = UIAlertController(title: "할 일 등록", message: "할 일을 입력해주세요.", preferredStyle: .alert)

        var taskTitleTextField: UITextField?

        let registerButton = UIAlertAction(title: "등록", style: .default, handler: { [weak self] _ in
            let textField = alert.textFields![0]
            print("Text field: \(textField.text)")
            guard let title = taskTitleTextField?.text else { return }
            let task = Task(title: title, done: false)
            self?.tasks.append(task)
            self?.myTableView.reloadData()
        })

        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(cancelButton)
        alert.addAction(registerButton)

        // 텍스트 필드 값 변경 감지하여 등록 버튼 활성화/비활성화 처리
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "할 일을 입력해주세요."

            taskTitleTextField = textField // 입력된 텍스트 필드를 변수에 저장

        })

        present(alert, animated: true, completion: nil)
    }

    func saveTasks() {
        let data = tasks.map {
            [
                "title": $0.title,
                "done": $0.done
            ]
        }
        var userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "tasks")
    }

    func loadTasks() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "tasks") as? [[String: Any]] else { return }
        tasks = data.compactMap {
            guard let title = $0["title"] as? String else { return nil }
            guard let done = $0["done"] as? Bool else { return nil }
            return Task(title: title, done: done)
        }
    }
}
