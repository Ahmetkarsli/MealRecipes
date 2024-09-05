//
//  RecipeDetailView.swift
//  MealRecipes
//
//  Created by Ahmet Karsli on 06.09.24.
//

import SwiftUI

struct RecipeDetailView: View {
    let meal: Meal
    
    var body: some View {
        ScrollView {
            ZStack {
                // Bild oben
                if let url = URL(string: meal.strMealThumb) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .shadow(radius: 10)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

            }
            Spacer()
            
            // Mahlzeitnamen
            Text(meal.strMeal)
                .font(.title)
                .bold()
                .padding(.bottom, 8)
            
            // Kategorie und Land
            HStack {
                Text("Category: \(meal.strCategory)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Area: \(meal.strArea)")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            // Zutaten
            VStack(alignment: .center) {
                Text("Ingredients")
                    .font(.title2)
                    .bold()
                    .padding(.vertical, 8)
                
                ForEach(Array(zip(meal.ingredients, meal.measures)), id: \.0) { ingredient, measure in
                    HStack {
                        Text(ingredient.description.capitalized)
                            .font(.body)
                            .foregroundStyle(.primary)
                        Spacer()
                        
                        Text(measure)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding()

            // Anweisungen
            Text("Instructions")
                .font(.title2)
                .bold()
                .padding(.vertical, 8)
            
            Text(meal.strInstructions)
                .font(.body)
                .lineSpacing(4)
            
            // Tags
            if let tags = meal.strTags {
                Text("Tags: \(tags)")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.vertical, 8)
            }
            
            // YouTube Link
            if let youtubeURL = meal.strYoutube, let url = URL(string: youtubeURL) {
                Link("Watch on YouTube", destination: url)
                    .font(.body)
                    .foregroundColor(.blue)
                    .padding(.vertical, 8)
            }
            
            Spacer()
        }
        .navigationTitle("Meal Details")
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    RecipeDetailView(meal: Meal.example)
}
