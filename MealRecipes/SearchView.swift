//
//  ContentView.swift
//  MealRecipes
//
//  Created by Ahmet Karsli on 03.09.24.
//

import SwiftUI

struct SearchView: View {
    @State var searchedMeals: String = ""
    @StateObject private var mealAPI = MealAPI()
    
    var body: some View {
        NavigationView {
            List(mealAPI.meals, id: \.idMeal) { meal in
                NavigationLink(destination: RecipeDetailView(meal: meal)) {
                    HStack(spacing: 30) {
                        if let url = URL(string: meal.strMealThumb) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(meal.strMeal)
                                .font(.headline)
                            Text(meal.strCategory)
                                .font(.subheadline)
                            Text(meal.strArea)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .searchable(text: $searchedMeals)
            .onChange(of: searchedMeals) { oldValue, newValue in
                if newValue.count >= 3 { //search at 3 letters
                    Task {
                        do {
                            mealAPI.meals.removeAll()
                            print("searching for: \(newValue)")
                            print("searchedMeals: \(searchedMeals)")
                            try await mealAPI.fetchMeals(searchedLetter: newValue, countLetter: newValue.count)
                        } catch {
                            print("Failed to fetch meals: \(error)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SearchView()
}
