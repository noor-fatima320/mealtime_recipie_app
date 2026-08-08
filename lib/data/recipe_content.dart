import 'meal_data.dart';

class Ingredient {
  final String name;
  final String quantity;

  const Ingredient({required this.name, required this.quantity});
}

class RecipeContent {
  final List<Ingredient> ingredients;
  final List<String> cookware;
  final List<String> instructions;

  final int calories;
  final String protein;
  final String carbs;
  final String fat;
  final String sugar;
  final String salt;
  final String fibre;

  const RecipeContent({
    required this.ingredients,
    required this.cookware,
    required this.instructions,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.sugar,
    required this.salt,
    required this.fibre,
  });
}

// ------------------------------------------------------------
// Recipe data for all meals
// ------------------------------------------------------------

final Map<String, RecipeContent> recipeContents = {
  "Chicken Breast with cooked Rice and a sticky, Flavorful Sauce.":
      const RecipeContent(
        ingredients: [
          Ingredient(name: "Chicken breast", quantity: "2 pieces"),
          Ingredient(name: "Basmati rice", quantity: "1 cup"),
          Ingredient(name: "Chicken broth", quantity: "2 cups"),
          Ingredient(name: "Garlic", quantity: "2 cloves"),
          Ingredient(name: "Ginger", quantity: "1 inch"),
          Ingredient(name: "Soy sauce", quantity: "2 tbsp"),
          Ingredient(name: "Honey", quantity: "1 tbsp"),
          Ingredient(name: "Olive oil", quantity: "1 tbsp"),
          Ingredient(name: "Black pepper", quantity: "½ tsp"),
          Ingredient(name: "Salt", quantity: "½ tsp"),
        ],
        cookware: [
          "Can opener",
          "Knife",
          "Cutting board",
          "Frying pan",
          "Saucepan",
          "Mixing bowl",
        ],
        instructions: [
          "Rinse the rice under cold running water and drain well.",
          "Place the rice in a saucepan, add broth and bring to a boil.",
          "Season the chicken with salt and black pepper.",
          "Heat olive oil in a frying pan and cook the chicken until golden.",
          "Add garlic and ginger and cook until fragrant.",
          "Add soy sauce and honey to make the sticky sauce.",
          "Coat the chicken with the sauce and cook for another few minutes.",
          "Serve the chicken with the cooked rice.",
        ],
        calories: 520,
        protein: "38 g",
        carbs: "54 g",
        fat: "16 g",
        sugar: "9 g",
        salt: "1.4 g",
        fibre: "3 g",
      ),

  "Classic Greek Salad with Feta and Kalamata Olives": const RecipeContent(
    ingredients: [
      Ingredient(name: "Cucumber", quantity: "1 medium"),
      Ingredient(name: "Tomatoes", quantity: "2 medium"),
      Ingredient(name: "Red onion", quantity: "½"),
      Ingredient(name: "Feta cheese", quantity: "100 g"),
      Ingredient(name: "Kalamata olives", quantity: "½ cup"),
      Ingredient(name: "Olive oil", quantity: "2 tbsp"),
      Ingredient(name: "Lemon juice", quantity: "1 tbsp"),
      Ingredient(name: "Oregano", quantity: "1 tsp"),
      Ingredient(name: "Salt", quantity: "½ tsp"),
      Ingredient(name: "Black pepper", quantity: "¼ tsp"),
    ],
    cookware: ["Knife", "Cutting board", "Mixing bowl", "Serving bowl"],
    instructions: [
      "Wash and dry all fresh vegetables.",
      "Cut the cucumber and tomatoes into bite-sized pieces.",
      "Thinly slice the red onion.",
      "Add vegetables and Kalamata olives to a bowl.",
      "Crumble feta cheese over the salad.",
      "Mix olive oil, lemon juice and oregano.",
      "Pour the dressing over the salad.",
      "Season with salt and black pepper and serve.",
    ],
    calories: 310,
    protein: "9 g",
    carbs: "14 g",
    fat: "24 g",
    sugar: "6 g",
    salt: "1.2 g",
    fibre: "4 g",
  ),

  " Italian Pasta fettuccine Alfredo with Creamy fettuccine Alfredo":
      const RecipeContent(
        ingredients: [
          Ingredient(name: "Fettuccine pasta", quantity: "250 g"),
          Ingredient(name: "Butter", quantity: "2 tbsp"),
          Ingredient(name: "Heavy cream", quantity: "1 cup"),
          Ingredient(name: "Parmesan cheese", quantity: "½ cup"),
          Ingredient(name: "Garlic", quantity: "2 cloves"),
          Ingredient(name: "Black pepper", quantity: "½ tsp"),
          Ingredient(name: "Salt", quantity: "½ tsp"),
        ],
        cookware: [
          "Can opener",
          "Knife",
          "Saucepan",
          "Large pot",
          "Colander",
          "Mixing spoon",
        ],
        instructions: [
          "Bring a large pot of salted water to a boil.",
          "Cook the fettuccine until tender.",
          "Melt butter in a saucepan over medium heat.",
          "Add garlic and cook briefly.",
          "Pour in the cream and stir gently.",
          "Add Parmesan cheese and stir until creamy.",
          "Drain the pasta and add it to the sauce.",
          "Season with black pepper and serve immediately.",
        ],
        calories: 590,
        protein: "18 g",
        carbs: "62 g",
        fat: "30 g",
        sugar: "4 g",
        salt: "1.3 g",
        fibre: "3 g",
      ),

  "Spaghetti with Tomato Sauce, Olives and Basil garnish": const RecipeContent(
    ingredients: [
      Ingredient(name: "Spaghetti", quantity: "250 g"),
      Ingredient(name: "Tomatoes", quantity: "400 g"),
      Ingredient(name: "Garlic", quantity: "2 cloves"),
      Ingredient(name: "Kalamata olives", quantity: "½ cup"),
      Ingredient(name: "Fresh basil", quantity: "½ bunch"),
      Ingredient(name: "Olive oil", quantity: "2 tbsp"),
      Ingredient(name: "Salt", quantity: "½ tsp"),
      Ingredient(name: "Black pepper", quantity: "¼ tsp"),
    ],
    cookware: ["Large pot", "Colander", "Knife", "Cutting board", "Frying pan"],
    instructions: [
      "Bring a large pot of salted water to a boil.",
      "Cook the spaghetti until tender.",
      "Heat olive oil in a frying pan.",
      "Add garlic and cook until fragrant.",
      "Add tomatoes and simmer the sauce.",
      "Stir in the olives and fresh basil.",
      "Drain the spaghetti and add it to the sauce.",
      "Toss everything together and serve.",
    ],
    calories: 450,
    protein: "13 g",
    carbs: "67 g",
    fat: "15 g",
    sugar: "7 g",
    salt: "1.1 g",
    fibre: "6 g",
  ),

  "Japanese Chicken Teriyaki with Marinade Coated in a Glossy":
      const RecipeContent(
        ingredients: [
          Ingredient(name: "Chicken thighs", quantity: "2 pieces"),
          Ingredient(name: "Soy sauce", quantity: "3 tbsp"),
          Ingredient(name: "Honey", quantity: "1 tbsp"),
          Ingredient(name: "Ginger", quantity: "1 inch"),
          Ingredient(name: "Garlic", quantity: "2 cloves"),
          Ingredient(name: "Sesame oil", quantity: "1 tsp"),
          Ingredient(name: "Sesame seeds", quantity: "1 tsp"),
        ],
        cookware: [
          "Knife",
          "Cutting board",
          "Mixing bowl",
          "Frying pan",
          "Tongs",
        ],
        instructions: [
          "Prepare the chicken by trimming any excess fat.",
          "Mix soy sauce, honey, garlic and ginger.",
          "Marinate the chicken in the mixture.",
          "Heat sesame oil in a frying pan.",
          "Cook the chicken until golden and fully cooked.",
          "Pour the remaining teriyaki sauce into the pan.",
          "Allow the sauce to become glossy and thick.",
          "Sprinkle sesame seeds and serve.",
        ],
        calories: 480,
        protein: "35 g",
        carbs: "25 g",
        fat: "25 g",
        sugar: "13 g",
        salt: "2.1 g",
        fibre: "1 g",
      ),

  " Butter Chicken Murgh Makhani Infused with Mildly Spiced":
      const RecipeContent(
        ingredients: [
          Ingredient(name: "Chicken", quantity: "500 g"),
          Ingredient(name: "Butter", quantity: "3 tbsp"),
          Ingredient(name: "Tomato puree", quantity: "1 cup"),
          Ingredient(name: "Cream", quantity: "½ cup"),
          Ingredient(name: "Garlic", quantity: "3 cloves"),
          Ingredient(name: "Garam masala", quantity: "1 tsp"),
          Ingredient(name: "Chili powder", quantity: "½ tsp"),
          Ingredient(name: "Salt", quantity: "1 tsp"),
        ],
        cookware: [
          "Knife",
          "Cutting board",
          "Large pan",
          "Mixing bowl",
          "Wooden spoon",
        ],
        instructions: [
          "Cut the chicken into bite-sized pieces.",
          "Season chicken with salt and spices.",
          "Heat butter in a large pan.",
          "Cook the chicken until lightly browned.",
          "Add tomato puree and simmer.",
          "Add cream and stir until combined.",
          "Add garam masala and adjust seasoning.",
          "Simmer until the chicken is tender and serve.",
        ],
        calories: 560,
        protein: "34 g",
        carbs: "15 g",
        fat: "39 g",
        sugar: "8 g",
        salt: "1.7 g",
        fibre: "3 g",
      ),

  "Italian White Sauce Pasta with Chicken in Rich Creamy Sauce":
      const RecipeContent(
        ingredients: [
          Ingredient(name: "Pasta", quantity: "250 g"),
          Ingredient(name: "Chicken breast", quantity: "250 g"),
          Ingredient(name: "Butter", quantity: "2 tbsp"),
          Ingredient(name: "Milk", quantity: "1 cup"),
          Ingredient(name: "Cream", quantity: "½ cup"),
          Ingredient(name: "Parmesan cheese", quantity: "½ cup"),
          Ingredient(name: "Garlic", quantity: "2 cloves"),
          Ingredient(name: "Black pepper", quantity: "½ tsp"),
        ],
        cookware: [
          "Large pot",
          "Colander",
          "Knife",
          "Cutting board",
          "Frying pan",
          "Saucepan",
        ],
        instructions: [
          "Cook the pasta in salted boiling water.",
          "Cut the chicken into small pieces.",
          "Cook the chicken in butter until golden.",
          "Add garlic and cook briefly.",
          "Prepare the creamy white sauce.",
          "Add Parmesan cheese and stir.",
          "Combine pasta, chicken and sauce.",
          "Season with black pepper and serve.",
        ],
        calories: 610,
        protein: "36 g",
        carbs: "59 g",
        fat: "28 g",
        sugar: "6 g",
        salt: "1.4 g",
        fibre: "3 g",
      ),

  "Juicy Chicken Satay Skewers with Tomato Sauce": const RecipeContent(
    ingredients: [
      Ingredient(name: "Chicken breast", quantity: "400 g"),
      Ingredient(name: "Peanut butter", quantity: "3 tbsp"),
      Ingredient(name: "Soy sauce", quantity: "2 tbsp"),
      Ingredient(name: "Lime juice", quantity: "1 tbsp"),
      Ingredient(name: "Garlic", quantity: "2 cloves"),
      Ingredient(name: "Ginger", quantity: "1 tsp"),
      Ingredient(name: "Tomato sauce", quantity: "½ cup"),
    ],
    cookware: ["Knife", "Cutting board", "Mixing bowl", "Skewers", "Grill pan"],
    instructions: [
      "Cut the chicken into thin strips.",
      "Mix peanut butter, soy sauce and lime juice.",
      "Add garlic and ginger to the marinade.",
      "Coat the chicken with the marinade.",
      "Thread chicken onto skewers.",
      "Heat a grill pan.",
      "Cook the skewers until fully cooked.",
      "Serve with tomato sauce.",
    ],
    calories: 430,
    protein: "39 g",
    carbs: "18 g",
    fat: "23 g",
    sugar: "7 g",
    salt: "1.8 g",
    fibre: "2 g",
  ),
};
