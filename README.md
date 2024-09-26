To create a Swift application that calls an API and displays the items in a UITableView without using Storyboards, you can follow these steps:

Step 1: Create a New Swift Project
Step 2: Set Up Your API Model
Step 3: Create the TableView Controller
Step 4: Set Up the App Delegate
Step 5: Run Your Application

### Complete Implementation

#### 1. Create a New Swift Project

- Open Xcode and create a new project.
- Select **App** under the iOS section and click **Next**.
- Name your project (e.g., `APITableViewApp`), choose **Swift** as the language, and select **UIKit** for the interface.
- Click **Next**, choose a location to save the project, and click **Create**.

#### 2. Create the Data Model

First, create a model to represent the data you'll be fetching. For this example, we'll use a placeholder API that returns a list of posts.

1. **Create a Swift file** named `Post.swift`:

```swift
import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
```

### 3. Create the View Controller with TableView

Next, create a `UIViewController` subclass that will contain the `UITableView`.

1. **Create a new Swift file** named `PostsViewController.swift`:

```swift
import UIKit

class PostsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        view.backgroundColor = .white
        
        // Set up the table view
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)

        // Set up constraints
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        fetchPosts()
    }

    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            guard let data = data else { return }
            
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = posts
                    self.tableView.reloadData()
                }
            } catch let jsonError {
                print("Error decoding JSON: \(jsonError)")
            }
        }
        task.resume()
    }

    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
}
```

### 4. Set Up the App Delegate

Now, set the `PostsViewController` as the root view controller in your `AppDelegate.swift` file.

1. **Modify `AppDelegate.swift`**:

```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let postsViewController = PostsViewController()
        let navigationController = UINavigationController(rootViewController: postsViewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}
```

### 5. Run Your Application

- Select a simulator or a physical device.
- Click the **Run** button (▶️) in Xcode to build and run your app.

### Explanation of Key Parts

- **Data Model**: The `Post` struct conforms to `Codable`, which allows easy encoding and decoding of JSON data.
- **Network Request**: The `fetchPosts` function makes a network request to the given URL, retrieves the data, and decodes it into an array of `Post` objects.
- **TableView**: The `UITableView` is set up to display the title of each post. The data source methods provide the necessary data to the table view.
- **UI Setup**: The table view is added to the view hierarchy and constraints are applied to make it fill the entire screen.

### Conclusion

This implementation fetches posts from a sample API, parses the JSON response, and displays the titles in a table view without using Storyboards. If you have any further questions or need additional help, feel free to ask! 😊
