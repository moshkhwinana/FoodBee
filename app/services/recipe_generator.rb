class RecipeGenerator

  attr_reader :client, :recipe, :products, :ingredients, :recipes

  def initialize(products)
    @recipe = Recipe.new
    @products = products # Array of product instances
    @ingredients = @products.map(&:product_name)
    @recipes = []
    @client = get_client
  end

  def generate
    # Initialize OpenAI Client with GPT-4 (ensure you've configured your OpenAI API key)
    chatgpt_response = @client.chat(parameters: {
      model: "gpt-3.5-turbo", # Remember to update this to the GPT-4 model ID when available
      messages: [{
        role: 'user',
        content: <<-CONTENT
          I'm creating a cooking app and need to generate recipes based on specific ingredients. The ingredients I have are: #{@ingredients.join(" ")}. Generate exactly 3 simple recipes that utilize these ingredients. For each recipe, provide the following details in a structured format:
          - Recipe title
          - Steps provided in a list format, starting with "1."
          - Difficulty level out of 5
          - Preparation time
          - Cooking time
          - Ingredients list

          Return the answer as a JSON object, containing the following keys only:
          recipe_title, recipe_steps, recipe_difficulty, prep_time, cooking_time
        CONTENT
      }]
    })

    begin

      content = chatgpt_response["choices"].first["message"]["content"]

      @recipes = extract_and_create_recipes(content)

      puts "Generated #{@recipes.count} recipes: #{@recipes}"


    rescue => e
      @content = "Sorry, I couldn't fetch the recipe at this time."
      Rails.logger.error("Failed to get recipe from OpenAI: #{e.message}")
    end
  end

  def get_and_save_image_on_recipe(recipe)
    url = generate_image_for_recipe(recipe.recipe_name)
    # recipe.update(image_url: url)
    puts "the image url is #{url}"
    # recipe
    url
  end


  private

  def generate_image_for_recipe(recipe_name)
    prompt = "Generate a visually appealing image of #{recipe_name} made with #{@ingredients.join(' ')}."

    response = client.images.generate(parameters: { prompt: prompt, size: "256x256" })
    image_url = response.dig("data", 0, "url")

    puts "Generated image for recipe #{recipe_name}: #{image_url}"
    image_url
  end

  def get_client
    @client ||= OpenAI::Client.new
  end


  def extract_and_create_recipes(content)

    parsed_content = JSON.parse(content)

    parsed_content["recipes"].map do |recipe|
      recipe_attributes = {
        recipe_name: recipe["recipe_title"],
        instructions: recipe["recipe_steps"].join("\n"),
        level: recipe["recipe_difficulty"],
        prep_time: recipe["prep_time"],
        cooking_time: recipe["cooking_time"]
      }

      recipe = Recipe.create!(recipe_attributes)
      # recipe.image_url = generate_image_for_recipe(recipe.recipe_name)
      # url = get_and_save_image_on_recipe(recipe)
      # puts "the image url is now #{url}"
      # recipe.update!(image_url: url)

      # create a recipeingredient record for each product
      # @products.each do |product|
      #   recipe.products << product
      # end

      recipe
    end
  end
end
