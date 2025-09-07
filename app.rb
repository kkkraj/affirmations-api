require 'sinatra'
require 'json'

# Configure port for deployment
set :port, ENV['PORT'] || 4567
set :bind, '0.0.0.0'

# Load affirmations from JSON file
def load_affirmations
  if File.exist?('affirmations.json')
    JSON.parse(File.read('affirmations.json'))
  else
    # Fallback to original affirmations if file doesn't exist
    [
      {
        id: 1,
        text: "I am capable of achieving great things",
        category: "motivation",
        author: "Anonymous"
      },
      {
        id: 2,
        text: "Every day is a new opportunity to grow",
        category: "growth",
        author: "Anonymous"
      },
      {
        id: 3,
        text: "I choose to be confident and strong",
        category: "confidence",
        author: "Anonymous"
      },
      {
        id: 4,
        text: "My potential is limitless",
        category: "potential",
        author: "Anonymous"
      },
      {
        id: 5,
        text: "I am worthy of love and respect",
        category: "self-worth",
        author: "Anonymous"
      }
    ]
  end
end

# Load affirmations into memory
$affirmations = load_affirmations

# Helper method to find next ID
def next_id
  $affirmations.empty? ? 1 : $affirmations.map { |a| a['id'] || a[:id] }.max + 1
end

# Helper method to find affirmation by ID
def find_affirmation(id)
  $affirmations.find { |a| (a['id'] || a[:id]) == id.to_i }
end

# Routes
get '/' do
  content_type :json
  {
    message: 'Welcome to the Affirmations API!',
    version: '1.0.0',
    total_affirmations: $affirmations.length,
    endpoints: {
      affirmations: '/affirmations',
      random_affirmation: '/affirmations/random',
      categories: '/affirmations/categories'
    }
  }.to_json
end

# Get all affirmations
get '/affirmations' do
  content_type :json
  $affirmations.to_json
end

# Get a random affirmation
get '/affirmations/random' do
  content_type :json
  random_affirmation = $affirmations.sample
  random_affirmation ? random_affirmation.to_json : { error: 'No affirmations found' }.to_json
end

# Get affirmations by category
get '/affirmations/category/:category' do
  content_type :json
  category = params[:category]
  filtered_affirmations = $affirmations.select { |a| (a['category'] || a[:category]) == category }
  
  if filtered_affirmations.any?
    filtered_affirmations.to_json
  else
    status 404
    { error: "No affirmations found for category: #{category}" }.to_json
  end
end

# Get all categories
get '/affirmations/categories' do
  content_type :json
  categories = $affirmations.map { |a| a['category'] || a[:category] }.uniq.compact
  { 
    categories: categories,
    total_categories: categories.length
  }.to_json
end

# Get affirmation by ID
get '/affirmations/:id' do
  content_type :json
  affirmation = find_affirmation(params[:id])
  
  if affirmation
    affirmation.to_json
  else
    status 404
    { error: 'Affirmation not found' }.to_json
  end
end

# Create a new affirmation
post '/affirmations' do
  content_type :json
  data = JSON.parse(request.body.read)
  
  new_affirmation = {
    id: next_id,
    text: data['text'],
    category: data['category'],
    author: data['author'] || 'Anonymous'
  }
  
  $affirmations << new_affirmation
  status 201
  new_affirmation.to_json
end

# Update an affirmation
put '/affirmations/:id' do
  content_type :json
  affirmation = find_affirmation(params[:id])
  
  if affirmation
    data = JSON.parse(request.body.read)
    
    affirmation['text'] = data['text'] if data['text']
    affirmation['category'] = data['category'] if data['category']
    affirmation['author'] = data['author'] if data['author']
    
    affirmation.to_json
  else
    status 404
    { error: 'Affirmation not found' }.to_json
  end
end

# Delete an affirmation
delete '/affirmations/:id' do
  affirmation = find_affirmation(params[:id])
  
  if affirmation
    $affirmations.delete(affirmation)
    status 204
  else
    status 404
    { error: 'Affirmation not found' }.to_json
  end
end

# Health check endpoint
get '/health' do
  content_type :json
  { 
    status: 'healthy', 
    timestamp: Time.now.iso8601,
    total_affirmations: $affirmations.length
  }.to_json
end

# Error handling
error 404 do
  content_type :json
  { error: 'Not found' }.to_json
end

error 500 do
  content_type :json
  { error: 'Internal server error' }.to_json
end
