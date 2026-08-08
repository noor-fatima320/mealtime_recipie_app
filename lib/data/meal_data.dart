class Ingredient {
  final String name;
  final String quantity;

  Ingredient({required this.name, required this.quantity});
}

class RecipeInstruction {
  final String text;
  final List<String> ingredients;
  final int? timerMinutes;

  RecipeInstruction({
    required this.text,
    this.ingredients = const [],
    this.timerMinutes,
  });
}

class Meal {
  final String image;
  final String title;
  final List<Ingredient> ingredients;
  final List<RecipeInstruction> instructions;

  Meal({
    required this.image,
    required this.title,
    this.ingredients = const [],
    this.instructions = const [],
  });
}

// ------------------------------------------------------------
// MOST POPULAR
// ------------------------------------------------------------

List<Meal> mostPopularMeals = [
  Meal(
    image: "assets/images/image1.jpg",
    title: "Chicken Breast with cooked Rice and a sticky, Flavorful Sauce.",
    ingredients: [
      Ingredient(name: "basmati rice", quantity: "½ cup"),
      Ingredient(name: "chicken or vegetable broth", quantity: "16 fl oz"),
      Ingredient(name: "cilantro", quantity: "½ small bunch"),
      Ingredient(name: "coconut milk", quantity: "½ (13.5 fl oz) can"),
      Ingredient(name: "garlic", quantity: "1 (1 inch) piece"),
      Ingredient(name: "ginger root", quantity: "1 piece"),
      Ingredient(name: "grape tomatoes", quantity: "½ pint"),
      Ingredient(name: "jalapeño pepper", quantity: "1"),
      Ingredient(name: "yellow onion", quantity: "1 medium"),
    ],
    instructions: [
      RecipeInstruction(
        text:
            "Using a strainer or colander, rinse the rice under cold, running water, then drain and transfer to a small saucepan. Add broth and bring the mixture to a boil over high heat.",
        ingredients: [
          "½ cup basmati rice",
          "8 fl oz (1 cup) chicken or vegetable broth",
        ],
      ),
      RecipeInstruction(
        text: "Meanwhile, wash and dry the fresh produce.",
        ingredients: [
          "1 piece ginger root",
          "1 jalapeño pepper",
          "½ small bunch cilantro",
          "½ pint grape tomatoes",
        ],
      ),
      RecipeInstruction(
        text:
            "Once the liquid comes to a boil, stir the mixture, cover the saucepan, and reduce heat to low. Cook rice until liquid is fully absorbed, 15–18 minutes. Once done, remove rice from the heat and let it stand, still covered, for 5 minutes.",
        timerMinutes: 5,
      ),
      RecipeInstruction(
        text:
            "Quarter the jalapeño pepper lengthwise; seed and remove ribs with a spoon. Mince and add to the bowl with the ginger and garlic.",
        ingredients: [
          "1 jalapeño pepper",
          "1 piece ginger root",
          "1 piece garlic",
        ],
      ),
      RecipeInstruction(
        text:
            "Once the liquid comes to a boil, stir the mixture, cover the saucepan, and reduce heat to low. Cook until the sauce is thick and flavorful.",
        timerMinutes: 5,
      ),
    ],
  ),

  Meal(
    image: "assets/images/image2.jpg",
    title: "Classic Greek Salad with Feta and Kalamata Olives",
    ingredients: [
      Ingredient(name: "tomatoes", quantity: "2 medium"),
      Ingredient(name: "cucumber", quantity: "1"),
      Ingredient(name: "red onion", quantity: "½"),
      Ingredient(name: "feta cheese", quantity: "100 g"),
      Ingredient(name: "Kalamata olives", quantity: "½ cup"),
      Ingredient(name: "olive oil", quantity: "2 tbsp"),
    ],
    instructions: [
      RecipeInstruction(text: "Wash and dry all fresh vegetables."),
      RecipeInstruction(
        text: "Chop the tomatoes and cucumber into bite-sized pieces.",
      ),
      RecipeInstruction(
        text: "Thinly slice the red onion and add it to the vegetables.",
      ),
      RecipeInstruction(text: "Add feta cheese and Kalamata olives."),
      RecipeInstruction(
        text: "Drizzle with olive oil and gently toss before serving.",
      ),
    ],
  ),

  Meal(
    image: "assets/images/image3.jpg",
    title: "Italian Pasta fettuccine Alfredo with Creamy fettuccine Alfredo",
    ingredients: [
      Ingredient(name: "fettuccine", quantity: "200 g"),
      Ingredient(name: "butter", quantity: "2 tbsp"),
      Ingredient(name: "heavy cream", quantity: "1 cup"),
      Ingredient(name: "parmesan cheese", quantity: "½ cup"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
    ],
    instructions: [
      RecipeInstruction(text: "Bring a large pot of salted water to a boil."),
      RecipeInstruction(
        text: "Add fettuccine and cook until tender.",
        timerMinutes: 10,
      ),
      RecipeInstruction(
        text: "Melt butter in a pan and gently cook the garlic.",
      ),
      RecipeInstruction(
        text: "Add cream and simmer until the sauce becomes creamy.",
        timerMinutes: 5,
      ),
      RecipeInstruction(
        text: "Add parmesan cheese and toss the pasta through the sauce.",
      ),
    ],
  ),

  Meal(
    image: "assets/images/image4.jpg",
    title: "Spaghetti with Tomato Sauce, Olives and Basil garnish",
    ingredients: [
      Ingredient(name: "spaghetti", quantity: "200 g"),
      Ingredient(name: "tomatoes", quantity: "2 cups"),
      Ingredient(name: "olives", quantity: "½ cup"),
      Ingredient(name: "basil", quantity: "½ cup"),
      Ingredient(name: "olive oil", quantity: "2 tbsp"),
    ],
    instructions: [
      RecipeInstruction(
        text: "Bring salted water to a boil and add spaghetti.",
      ),
      RecipeInstruction(
        text: "Prepare the tomato sauce with olive oil and tomatoes.",
        timerMinutes: 10,
      ),
      RecipeInstruction(text: "Add olives and stir the sauce."),
      RecipeInstruction(
        text: "Drain the spaghetti and combine it with the sauce.",
      ),
      RecipeInstruction(text: "Garnish with fresh basil and serve."),
    ],
  ),
];

// ------------------------------------------------------------
// RECENTLY CREATED
// ------------------------------------------------------------

List<Meal> recentMeals = [
  Meal(
    image: "assets/images/image5.jpg",
    title: "Japanese Chicken Teriyaki with Marinade Coated in a Glossy",
    ingredients: [
      Ingredient(name: "chicken breast", quantity: "2 pieces"),
      Ingredient(name: "soy sauce", quantity: "¼ cup"),
      Ingredient(name: "honey", quantity: "2 tbsp"),
      Ingredient(name: "ginger", quantity: "1 tsp"),
      Ingredient(name: "garlic", quantity: "1 clove"),
    ],
    instructions: [
      RecipeInstruction(text: "Prepare the chicken and pat it dry."),
      RecipeInstruction(
        text: "Mix soy sauce, honey, ginger and garlic to make the marinade.",
      ),
      RecipeInstruction(text: "Coat the chicken with the marinade."),
      RecipeInstruction(
        text: "Cook the chicken until golden and fully cooked.",
        timerMinutes: 8,
      ),
      RecipeInstruction(text: "Brush with remaining teriyaki sauce and serve."),
    ],
  ),

  Meal(
    image: "assets/images/image6.jpg",
    title: "Butter Chicken Murgh Makhani Infused with Mildly Spiced",
    ingredients: [
      Ingredient(name: "chicken", quantity: "500 g"),
      Ingredient(name: "butter", quantity: "2 tbsp"),
      Ingredient(name: "tomato sauce", quantity: "1 cup"),
      Ingredient(name: "cream", quantity: "½ cup"),
      Ingredient(name: "garam masala", quantity: "1 tsp"),
    ],
    instructions: [
      RecipeInstruction(text: "Cut the chicken into bite-sized pieces."),
      RecipeInstruction(
        text: "Cook the chicken until lightly browned.",
        timerMinutes: 8,
      ),
      RecipeInstruction(text: "Add tomato sauce and spices."),
      RecipeInstruction(
        text: "Cover and simmer until the chicken is tender.",
        timerMinutes: 15,
      ),
      RecipeInstruction(text: "Stir in cream and butter before serving."),
    ],
  ),

  Meal(
    image: "assets/images/image7.jpg",
    title: "Italian White Sauce Pasta with Chicken in Rich Creamy Sauce",
    ingredients: [
      Ingredient(name: "pasta", quantity: "200 g"),
      Ingredient(name: "chicken", quantity: "250 g"),
      Ingredient(name: "cream", quantity: "1 cup"),
      Ingredient(name: "parmesan", quantity: "½ cup"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
    ],
    instructions: [
      RecipeInstruction(
        text: "Boil the pasta in salted water.",
        timerMinutes: 10,
      ),
      RecipeInstruction(
        text: "Cook the chicken until golden.",
        timerMinutes: 8,
      ),
      RecipeInstruction(
        text: "Prepare the creamy white sauce with garlic and cream.",
      ),
      RecipeInstruction(
        text: "Add parmesan and stir until smooth.",
        timerMinutes: 3,
      ),
      RecipeInstruction(text: "Combine pasta, chicken and sauce and serve."),
    ],
  ),

  Meal(
    image: "assets/images/image8.jpg",
    title: "Juicy Chicken Satay Skewers with Tomato Sauce",
    ingredients: [
      Ingredient(name: "chicken", quantity: "400 g"),
      Ingredient(name: "tomato sauce", quantity: "½ cup"),
      Ingredient(name: "soy sauce", quantity: "2 tbsp"),
      Ingredient(name: "garlic", quantity: "1 clove"),
    ],
    instructions: [
      RecipeInstruction(text: "Cut the chicken into small strips."),
      RecipeInstruction(
        text: "Marinate the chicken with soy sauce and garlic.",
      ),
      RecipeInstruction(text: "Thread the chicken onto skewers."),
      RecipeInstruction(
        text: "Cook the skewers until golden and fully cooked.",
        timerMinutes: 10,
      ),
      RecipeInstruction(text: "Serve with tomato sauce."),
    ],
  ),
];

// ------------------------------------------------------------
// RECOMMENDED
// ------------------------------------------------------------

List<Meal> recommendedMeals = [
  Meal(
    image: "assets/images/image9.jpg",
    title: "Sichuan Spicy Wonton Tossed in a Bold, Spicy Chili Oil",
    ingredients: [
      Ingredient(name: "wontons", quantity: "12"),
      Ingredient(name: "chili oil", quantity: "2 tbsp"),
      Ingredient(name: "soy sauce", quantity: "1 tbsp"),
      Ingredient(name: "garlic", quantity: "1 clove"),
      Ingredient(name: "spring onion", quantity: "2"),
    ],
    instructions: [
      RecipeInstruction(text: "Prepare the wontons and bring water to a boil."),
      RecipeInstruction(
        text: "Cook the wontons until they float.",
        timerMinutes: 6,
      ),
      RecipeInstruction(text: "Mix chili oil, soy sauce and garlic."),
      RecipeInstruction(
        text: "Drain the wontons and toss them in the spicy sauce.",
      ),
      RecipeInstruction(text: "Garnish with spring onion and serve."),
    ],
  ),

  Meal(
    image: "assets/images/image10.jpg",
    title: "Mediterranean Arugula Salad with Herb-Toasted Feta & Black Olives",
    ingredients: [
      Ingredient(name: "arugula", quantity: "3 cups"),
      Ingredient(name: "feta", quantity: "100 g"),
      Ingredient(name: "black olives", quantity: "½ cup"),
      Ingredient(name: "herbs", quantity: "1 tbsp"),
      Ingredient(name: "olive oil", quantity: "2 tbsp"),
    ],
    instructions: [
      RecipeInstruction(text: "Wash and dry the arugula."),
      RecipeInstruction(text: "Prepare the feta with herbs."),
      RecipeInstruction(
        text: "Toast the feta until lightly golden.",
        timerMinutes: 5,
      ),
      RecipeInstruction(text: "Combine arugula, olives and toasted feta."),
      RecipeInstruction(text: "Drizzle with olive oil and serve."),
    ],
  ),

  Meal(
    image: "assets/images/image11.jpg",
    title: "Shrimp Fried Rice with Fluffy Scrambled Eggs and best Sauce",
    ingredients: [
      Ingredient(name: "rice", quantity: "2 cups"),
      Ingredient(name: "shrimp", quantity: "250 g"),
      Ingredient(name: "eggs", quantity: "2"),
      Ingredient(name: "soy sauce", quantity: "2 tbsp"),
      Ingredient(name: "spring onion", quantity: "2"),
    ],
    instructions: [
      RecipeInstruction(text: "Prepare the cooked rice and shrimp."),
      RecipeInstruction(text: "Scramble the eggs in a hot pan."),
      RecipeInstruction(
        text: "Add shrimp and cook until pink.",
        timerMinutes: 5,
      ),
      RecipeInstruction(
        text: "Add rice and soy sauce and stir-fry everything together.",
        timerMinutes: 5,
      ),
      RecipeInstruction(text: "Garnish with spring onion and serve."),
    ],
  ),

  Meal(
    image: "assets/images/image12.jpg",
    title: "Spicy Yangnyeom Fried Chicken Korean",
    ingredients: [
      Ingredient(name: "chicken", quantity: "500 g"),
      Ingredient(name: "gochujang", quantity: "2 tbsp"),
      Ingredient(name: "honey", quantity: "1 tbsp"),
      Ingredient(name: "garlic", quantity: "2 cloves"),
      Ingredient(name: "sesame seeds", quantity: "1 tbsp"),
    ],
    instructions: [
      RecipeInstruction(text: "Prepare the chicken pieces."),
      RecipeInstruction(
        text: "Coat the chicken and fry until crisp.",
        timerMinutes: 10,
      ),
      RecipeInstruction(text: "Prepare the spicy Yangnyeom sauce."),
      RecipeInstruction(
        text: "Toss the fried chicken in the sauce.",
        timerMinutes: 3,
      ),
      RecipeInstruction(text: "Garnish with sesame seeds and serve."),
    ],
  ),
];

List<Meal> favoriteMeals = [];
