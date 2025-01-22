//
//  DIContainer.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/21/25.
//


class DIContainer {
    
    static let shared = DIContainer()
    
    private var dependencies = [String: Any]()
    private init() {}
    
    /// This function registers the dependency in the container
    /// - Parameters:
    ///   - type: Protocol type of the dependency.
    ///   - dependecy: Actual Dependecy.
    /// - Returns: Void.

    func register<T>(type: T.Type, dependecy: Any) {
        let key = "\(type)"
        dependencies[key] = dependecy
    }
    
    /// This function is used to fetch the dependencies stored in the container
    /// - Parameters:
    /// - Returns: Dependency.
    ///
    func resolve<T>() -> T? {
        let key = "\(T.self)"
        return dependencies[key] as? T
    }
    
}


@propertyWrapper

struct Injected<T> {
    private var dependency: T?

    init() {
        self.dependency = DIContainer.shared.resolve()
    }

    /// The value wrapped by the property wrapper
    var wrappedValue: T {
        get {
            guard let dependency = dependency else {
                fatalError("Dependency not resolved.")
            }
            return dependency
        }
        
    }
}

