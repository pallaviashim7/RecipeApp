//
//  URLConfig.swift
//  Recipe
//
//  Created by Pallavi Ashim on 1/21/25.
//


protocol URLConfigurable {
    func remoteURL() -> String
}

struct URLConfig: URLConfigurable {
    func remoteURL() -> String {
        return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
//        return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
//        return "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    }
}
