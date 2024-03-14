class RecipeGenerator

  def initialize(ingredients)
    @recipe = Recipe.new
    @ingredients = ingredients
  end

  def generate
    # Initialize OpenAI Client with GPT-4 (ensure you've configured your OpenAI API key)
    client = OpenAI::Client.new

    begin
      # Adjusting the prompt for GPT-4 and refining the request
      chatgpt_response = client.chat(parameters: {
        model: "gpt-3.5-turbo", # Update this to the latest GPT-4 model ID once available
        messages: [{
          role: 'user',
          content: "Give me simple recipes that I can make with the following ingredients: #{@ingredients}, in the response can you include, prep time, cooking time, and level of difficulty",
        }]
      })

      content = chatgpt_response["choices"].first["message"]["content"]

      titles = content.scan(/\d+\.\s[^:]+:/)
    rescue => e
      @content = "Sorry, I couldn't fetch the recipe at this time."
      Rails.logger.error("Failed to get recipe from OpenAI: #{e.message}")
    end
  end
end
