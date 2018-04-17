# Notifier
More easier to use NotificationCenter. 

No need to define Notification Name string, no worries about typo

## Before:
```
NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name(rawValue: "UserLogin"), object: nil)

NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserLogin"), object: true, userInfo: ["Name": "xxxx"])

override func handleNotification(_ notification: Notification) {
   let success = notification.object as? Bool ?? false
   let name = notification.userInfo?["name"] as? String ?? ""  //!!!should be 'Name', not 'name'
   ...
}
```
Emm... 


## Now

### Define the Notification Name as you like
```
public enum NotifierName: String {
    case login
    case logout
    case registration = "NotificationKeyRegistration"
    ...
}
```

### Define the Notification user info key if you need to pass some values
```
public enum NotifierKey: String {
    case result
    case name
    ...
}
```

### Register
```
Notifier.register(.login, to: self, selector: #selector(handleNotification(_:)))
```

### Remove
```
Notifier.unregister(.login, from: self)
```

### Post with values
```
Notifier.post(.login, value: [.result: true, .name: "god"])
```

### Handle
```
let success: Bool = notification.value(for: .result) ?? false
let name: String = notification.value(for: .name) ?? ""
print("notification: \(success) ---- \(name)")
```
