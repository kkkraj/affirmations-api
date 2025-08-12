# Affirmations API

A powerful and comprehensive API for managing positive affirmations, built with Sinatra and Ruby.

## Features

- **500+ Affirmations**: Comprehensive collection of positive affirmations
- **CRUD Operations**: Create, read, update, and delete affirmations
- **Random Affirmations**: Get a random affirmation for daily inspiration
- **Category Filtering**: Filter affirmations by category
- **RESTful API**: Clean and intuitive REST endpoints
- **JSON File Storage**: Loads affirmations from a structured JSON file
- **In-Memory Processing**: Fast and efficient data handling
- **JSON API**: All responses in JSON format

## Quick Start

1. **Install dependencies**
   ```bash
   bundle install
   ```

2. **Start the server**
   ```bash
   ruby app.rb
   ```

3. **Access the API**
   The API will be available at `http://localhost:4567`

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | API information and available endpoints |
| GET | `/health` | Health check endpoint with affirmation count |
| GET | `/affirmations` | Get all affirmations (500+) |
| GET | `/affirmations/:id` | Get affirmation by ID |
| GET | `/affirmations/random` | Get a random affirmation |
| GET | `/affirmations/category/:category` | Get affirmations by category |
| GET | `/affirmations/categories` | Get all available categories |
| POST | `/affirmations` | Create a new affirmation |
| PUT | `/affirmations/:id` | Update an affirmation |
| DELETE | `/affirmations/:id` | Delete an affirmation |

## Available Categories

The API includes affirmations across these categories:
- **confidence-self-belief** - Building self-confidence and belief
- **gratitude-abundance** - Appreciating life's blessings
- **calm-peace** - Finding inner peace and tranquility
- **motivation-forward-momentum** - Staying motivated and moving forward
- **healing-resilience** - Overcoming challenges and healing
- **self-love** - Loving and accepting yourself
- **inner-strength** - Discovering your inner power
- **presence** - Living in the present moment
- **creativity** - Unleashing your creative potential
- **compassion** - Showing kindness to yourself and others
- **connection** - Building meaningful relationships
- **universal-positivity** - Embracing life's positive aspects

## Usage Examples

### Get all affirmations
```bash
curl http://localhost:4567/affirmations
```

### Get a random affirmation
```bash
curl http://localhost:4567/affirmations/random
```

### Get affirmations by category
```bash
curl http://localhost:4567/affirmations/category/confidence-self-belief
```

### Get all categories
```bash
curl http://localhost:4567/affirmations/categories
```

### Create a new affirmation
```bash
curl -X POST http://localhost:4567/affirmations \
  -H "Content-Type: application/json" \
  -d '{
    "text": "I am capable of amazing things",
    "category": "motivation",
    "author": "Anonymous"
  }'
```

## Data Structure

### Affirmation Object
```json
{
  "id": 1,
  "text": "I am enough.",
  "category": "confidence-self-belief",
  "author": "Anonymous"
}
```

### Create/Update Affirmation
```json
{
  "text": "Your affirmation text here",
  "category": "category_name",
  "author": "Author name (optional)"
}
```

## Data Source

The API loads affirmations from `affirmations.json`, which contains:
- **500+ carefully curated affirmations**
- **12 different categories** covering various aspects of personal growth
- **Professional quality content** suitable for daily use
- **Consistent formatting** for easy integration

## Development

This API is perfect for:
- **Personal development apps**
- **Wellness and meditation platforms**
- **Daily motivation services**
- **Mental health applications**
- **Educational tools**

## Future Enhancements

Consider adding:
- **User accounts** and personal affirmation collections
- **Favorite affirmations** functionality
- **Search and filtering** capabilities
- **Daily affirmation scheduling**
- **Analytics and usage tracking**

## License

This project is open source and available under the MIT License.
