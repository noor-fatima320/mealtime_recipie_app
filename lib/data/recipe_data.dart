import 'meal_data.dart';

class Ingredient {
  final String name;
  final String quantity;

  const Ingredient({required this.name, required this.quantity});
}

class RecipeDetails {
  final List<String> cookware;
  final List<Ingredient> ingredients;
  final List<String> instructions;

  const RecipeDetails({
    required this.cookware,
    required this.ingredients,
    required this.instructions,
  });
}

final Map<String, RecipeDetails> recipeDetails = {
  "assets/images/image1.jpg": const RecipeDetails(
    cookware: ["Pan", "Knife", "Cutting board", "Bowl"],
    ingredients: [
      Ingredient(name: "chicken breast", quantity: "2 pieces"),
      Ingredient(name: "cooked rice", quantity: "2 cups"),
      Ingredient(name: "soy sauce", quantity: "2 tbsp"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
      Ingredient(name: "ginger", quantity: "1 tsp"),
      Ingredient(name: "mixed vegetables", quantity: "1 cup"),
    ],
    instructions: [
      "Cut the chicken breast into small bite-sized pieces.",
      "Heat a pan over medium heat and add a little oil.",
      "Add garlic and ginger, then cook until fragrant.",
      "Add chicken and cook until lightly browned.",
      "Add the vegetables and cooked rice to the pan.",
      "Pour in the sauce and mix everything well.",
      "Cook for another 3–5 minutes.",
      "Serve hot with the flavorful sauce.",
    ],
  ),

  "assets/images/image2.jpg": const RecipeDetails(
    cookware: ["Knife", "Cutting board", "Large bowl", "Serving plate"],
    ingredients: [
      Ingredient(name: "tomatoes", quantity: "2 medium"),
      Ingredient(name: "cucumber", quantity: "1 medium"),
      Ingredient(name: "feta cheese", quantity: "100 g"),
      Ingredient(name: "Kalamata olives", quantity: "½ cup"),
      Ingredient(name: "red onion", quantity: "½ medium"),
      Ingredient(name: "olive oil", quantity: "2 tbsp"),
    ],
    instructions: [
      "Wash all vegetables thoroughly.",
      "Cut tomatoes and cucumber into bite-sized pieces.",
      "Thinly slice the red onion.",
      "Add vegetables and olives to a large bowl.",
      "Crumble feta cheese over the salad.",
      "Drizzle olive oil over the ingredients.",
      "Gently toss everything together.",
      "Serve fresh.",
    ],
  ),

  "assets/images/image3.jpg": const RecipeDetails(
    cookware: ["Large pot", "Pan", "Colander", "Wooden spoon"],
    ingredients: [
      Ingredient(name: "fettuccine pasta", quantity: "250 g"),
      Ingredient(name: "butter", quantity: "2 tbsp"),
      Ingredient(name: "heavy cream", quantity: "1 cup"),
      Ingredient(name: "parmesan cheese", quantity: "½ cup"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
      Ingredient(name: "black pepper", quantity: "½ tsp"),
    ],
    instructions: [
      "Bring a large pot of salted water to a boil.",
      "Cook the fettuccine until tender.",
      "Drain the pasta using a colander.",
      "Melt butter in a pan over medium heat.",
      "Add garlic and cook briefly.",
      "Add cream and bring it to a gentle simmer.",
      "Stir in parmesan cheese until the sauce becomes creamy.",
      "Add pasta and toss until fully coated.",
    ],
  ),

  "assets/images/image4.jpg": const RecipeDetails(
    cookware: ["Large pot", "Pan", "Colander", "Wooden spoon"],
    ingredients: [
      Ingredient(name: "spaghetti", quantity: "250 g"),
      Ingredient(name: "tomatoes", quantity: "4 medium"),
      Ingredient(name: "garlic", quantity: "3 cloves"),
      Ingredient(name: "olives", quantity: "½ cup"),
      Ingredient(name: "basil", quantity: "¼ cup"),
      Ingredient(name: "olive oil", quantity: "2 tbsp"),
    ],
    instructions: [
      "Boil the spaghetti in salted water.",
      "Heat olive oil in a pan.",
      "Add garlic and cook until fragrant.",
      "Add tomatoes and simmer the sauce.",
      "Add olives and stir well.",
      "Drain the spaghetti.",
      "Add spaghetti to the sauce and toss.",
      "Garnish with fresh basil and serve.",
    ],
  ),

  "assets/images/image5.jpg": const RecipeDetails(
    cookware: ["Pan", "Bowl", "Knife", "Rice cooker"],
    ingredients: [
      Ingredient(name: "chicken", quantity: "300 g"),
      Ingredient(name: "soy sauce", quantity: "3 tbsp"),
      Ingredient(name: "honey", quantity: "1 tbsp"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
      Ingredient(name: "ginger", quantity: "1 tsp"),
      Ingredient(name: "cooked rice", quantity: "2 cups"),
    ],
    instructions: [
      "Cut the chicken into small pieces.",
      "Mix soy sauce, honey, garlic and ginger in a bowl.",
      "Coat the chicken with the marinade.",
      "Heat a pan over medium heat.",
      "Cook chicken until golden and fully cooked.",
      "Pour the remaining sauce into the pan.",
      "Simmer until the sauce becomes glossy.",
      "Serve over warm rice.",
    ],
  ),

  "assets/images/image6.jpg": const RecipeDetails(
    cookware: ["Pan", "Knife", "Bowl", "Wooden spoon"],
    ingredients: [
      Ingredient(name: "chicken", quantity: "500 g"),
      Ingredient(name: "tomato puree", quantity: "1 cup"),
      Ingredient(name: "cream", quantity: "½ cup"),
      Ingredient(name: "butter", quantity: "2 tbsp"),
      Ingredient(name: "garam masala", quantity: "1 tsp"),
      Ingredient(name: "onion", quantity: "1 medium"),
    ],
    instructions: [
      "Cut chicken into medium-sized pieces.",
      "Heat butter in a pan.",
      "Add chopped onion and cook until soft.",
      "Add spices and tomato puree.",
      "Cook the sauce for several minutes.",
      "Add chicken and mix well.",
      "Cover and cook until chicken is tender.",
      "Add cream and simmer gently before serving.",
    ],
  ),

  "assets/images/image7.jpg": const RecipeDetails(
    cookware: ["Large pot", "Pan", "Colander", "Wooden spoon"],
    ingredients: [
      Ingredient(name: "pasta", quantity: "250 g"),
      Ingredient(name: "chicken", quantity: "200 g"),
      Ingredient(name: "cream", quantity: "1 cup"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
      Ingredient(name: "parmesan", quantity: "½ cup"),
      Ingredient(name: "olive oil", quantity: "1 tbsp"),
    ],
    instructions: [
      "Boil pasta until tender.",
      "Cut chicken into small pieces.",
      "Cook chicken in olive oil until golden.",
      "Add garlic and cook briefly.",
      "Add cream and bring to a gentle simmer.",
      "Stir in parmesan cheese.",
      "Add cooked pasta and mix well.",
      "Serve immediately.",
    ],
  ),

  "assets/images/image8.jpg": const RecipeDetails(
    cookware: ["Skewers", "Grill pan", "Bowl", "Brush"],
    ingredients: [
      Ingredient(name: "chicken", quantity: "400 g"),
      Ingredient(name: "soy sauce", quantity: "2 tbsp"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
      Ingredient(name: "tomato sauce", quantity: "½ cup"),
      Ingredient(name: "lemon juice", quantity: "1 tbsp"),
      Ingredient(name: "oil", quantity: "1 tbsp"),
    ],
    instructions: [
      "Cut chicken into small strips.",
      "Mix chicken with soy sauce, garlic and lemon juice.",
      "Allow the chicken to marinate.",
      "Thread chicken pieces onto skewers.",
      "Heat a grill pan.",
      "Cook skewers on each side until fully cooked.",
      "Brush with tomato sauce.",
      "Serve warm.",
    ],
  ),

  "assets/images/image9.jpg": const RecipeDetails(
    cookware: ["Large pot", "Bowl", "Pan", "Serving bowl"],
    ingredients: [
      Ingredient(name: "wonton wrappers", quantity: "12"),
      Ingredient(name: "ground chicken", quantity: "200 g"),
      Ingredient(name: "chili oil", quantity: "2 tbsp"),
      Ingredient(name: "soy sauce", quantity: "1 tbsp"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
      Ingredient(name: "spring onion", quantity: "2 tbsp"),
    ],
    instructions: [
      "Prepare the wonton filling.",
      "Place a small amount of filling inside each wrapper.",
      "Seal the wontons carefully.",
      "Boil water in a large pot.",
      "Cook wontons until they float.",
      "Prepare the spicy chili sauce.",
      "Drain the wontons and toss with the sauce.",
      "Garnish with spring onion.",
    ],
  ),

  "assets/images/image10.jpg": const RecipeDetails(
    cookware: ["Bowl", "Knife", "Cutting board", "Serving plate"],
    ingredients: [
      Ingredient(name: "arugula", quantity: "3 cups"),
      Ingredient(name: "feta cheese", quantity: "100 g"),
      Ingredient(name: "black olives", quantity: "½ cup"),
      Ingredient(name: "tomatoes", quantity: "1 cup"),
      Ingredient(name: "olive oil", quantity: "2 tbsp"),
      Ingredient(name: "lemon juice", quantity: "1 tbsp"),
    ],
    instructions: [
      "Wash and dry the arugula.",
      "Cut tomatoes into small pieces.",
      "Toast the feta lightly with herbs.",
      "Add arugula and tomatoes to a bowl.",
      "Add olives and feta.",
      "Mix olive oil and lemon juice.",
      "Drizzle dressing over the salad.",
      "Toss gently and serve.",
    ],
  ),

  "assets/images/image11.jpg": const RecipeDetails(
    cookware: ["Wok", "Bowl", "Spatula", "Knife"],
    ingredients: [
      Ingredient(name: "cooked rice", quantity: "3 cups"),
      Ingredient(name: "shrimp", quantity: "250 g"),
      Ingredient(name: "eggs", quantity: "2"),
      Ingredient(name: "soy sauce", quantity: "2 tbsp"),
      Ingredient(name: "peas", quantity: "½ cup"),
      Ingredient(name: "spring onion", quantity: "2 tbsp"),
    ],
    instructions: [
      "Heat a wok over medium-high heat.",
      "Cook the shrimp until pink and fully cooked.",
      "Move shrimp to one side of the wok.",
      "Add beaten eggs and scramble them.",
      "Add cooked rice and vegetables.",
      "Pour soy sauce over the rice.",
      "Toss everything together over high heat.",
      "Garnish with spring onion and serve.",
    ],
  ),

  "assets/images/image12.jpg": const RecipeDetails(
    cookware: ["Deep pan", "Bowl", "Tongs", "Wire rack"],
    ingredients: [
      Ingredient(name: "chicken wings", quantity: "500 g"),
      Ingredient(name: "gochujang", quantity: "2 tbsp"),
      Ingredient(name: "soy sauce", quantity: "1 tbsp"),
      Ingredient(name: "honey", quantity: "1 tbsp"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
      Ingredient(name: "sesame seeds", quantity: "1 tsp"),
    ],
    instructions: [
      "Prepare and season the chicken pieces.",
      "Heat oil in a deep pan.",
      "Cook chicken until crispy and fully cooked.",
      "Mix gochujang, soy sauce, honey and garlic.",
      "Heat the sauce gently.",
      "Add crispy chicken to the sauce.",
      "Toss until every piece is coated.",
      "Garnish with sesame seeds and serve.",
    ],
  ),
};

RecipeDetails getRecipeDetails(Meal meal) {
  return recipeDetails[meal.image] ??
      const RecipeDetails(
        cookware: ["Knife", "Pan", "Bowl"],
        ingredients: [],
        instructions: [
          "Prepare the ingredients.",
          "Cook according to the recipe.",
        ],
      );
}
