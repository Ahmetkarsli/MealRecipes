//
//  MealAPI.swift
//  MealRecipes
//
//  Created by Ahmet Karsli on 03.09.24.
//

import Foundation

// Error Handling
enum FError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

struct MealResponse: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?

    var ingredients: [String] {
        return [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ].compactMap { $0 }.filter { !$0.isEmpty }
    }
    
    var measures: [String] {
        return [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
            strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
            strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        ].compactMap { $0 }.filter { !$0.isEmpty }
    }
    
    static let example = Meal(
            idMeal: "52771",
            strMeal: "Spicy Arrabiata Penne",
            strCategory: "Vegetarian",
            strArea: "Italian",
            strInstructions: "Bring a large pot of water to a boil. Add kosher salt to the boiling water, then add the pasta. Cook according to the package instructions, about 9 minutes.\r\nIn a large skillet over medium-high heat, add the olive oil and heat until the oil starts to shimmer. Add the garlic and cook, stirring, until fragrant, 1 to 2 minutes. Add the chopped tomatoes, red chile flakes, Italian seasoning and salt and pepper to taste. Bring to a boil and cook for 5 minutes. Remove from the heat and add the chopped basil.\r\nDrain the pasta and add it to the sauce. Garnish with Parmigiano-Reggiano flakes and more basil and serve warm.",
            strMealThumb: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
            strTags: "Pasta,Curry",
            strYoutube: "https://www.youtube.com/watch?v=1IszT_guI08",
            
            // Zutaten und Maße
            strIngredient1: "penne rigate",
            strIngredient2: "olive oil",
            strIngredient3: "garlic",
            strIngredient4: "chopped tomatoes",
            strIngredient5: "red chilli flakes",
            strIngredient6: "italian seasoning",
            strIngredient7: "basil",
            strIngredient8: "Parmigiano-Reggiano",
            strIngredient9: nil,
            strIngredient10: nil,
            strIngredient11: nil,
            strIngredient12: nil,
            strIngredient13: nil,
            strIngredient14: nil,
            strIngredient15: nil,
            strIngredient16: nil,
            strIngredient17: nil,
            strIngredient18: nil,
            strIngredient19: nil,
            strIngredient20: nil,

            strMeasure1: "1 pound",
            strMeasure2: "1/4 cup",
            strMeasure3: "3 cloves",
            strMeasure4: "1 tin",
            strMeasure5: "1/2 teaspoon",
            strMeasure6: "1/2 teaspoon",
            strMeasure7: "6 leaves",
            strMeasure8: "spinkling",
            strMeasure9: nil,
            strMeasure10: nil,
            strMeasure11: nil,
            strMeasure12: nil,
            strMeasure13: nil,
            strMeasure14: nil,
            strMeasure15: nil,
            strMeasure16: nil,
            strMeasure17: nil,
            strMeasure18: nil,
            strMeasure19: nil,
            strMeasure20: nil
        )
}

// API Manager
class MealAPI: ObservableObject {
    @Published var meals: [Meal] = []

    func fetchMeals(searchedLetter: String, countLetter: Int) async throws {
        var baseUrl = ""
        if countLetter > 1 {
            baseUrl = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(searchedLetter.lowercased())"
        } else {
            baseUrl = "https://www.themealdb.com/api/json/v1/1/search.php?f=\(searchedLetter.lowercased())"
        }
        guard let url = URL(string: baseUrl) else {
            throw FError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Debugging: Raw JSON response printen
            if let rawJson = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(rawJson)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw FError.invalidResponse
            }
            
            let jsonString = String(data: data, encoding: .utf8) ?? ""
            if jsonString.isEmpty {
                throw FError.invalidData
            }
            
            let decoder = JSONDecoder()
            let mealResponse = try decoder.decode(MealResponse.self, from: data)
            DispatchQueue.main.async {
                self.meals = mealResponse.meals
            }
        } catch {
            print("Error fetching meals: \(error.localizedDescription)")
            throw error
        }
    }
}
