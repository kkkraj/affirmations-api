# Affirmations API

A simple and lightweight API for managing positive affirmations, built with Sinatra and Ruby.

## Features

- **CRUD Operations**: Create, read, update, and delete affirmations
- **Random Affirmations**: Get a random affirmation for daily inspiration
- **Category Filtering**: Filter affirmations by category
- **RESTful API**: Clean and intuitive REST endpoints
- **In-Memory Storage**: Simple and fast, no database setup required
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
| GET | `/health` | Health check endpoint |
| GET | `/affirmations` | Get all affirmations |
| GET | `/affirmations/:id` | Get affirmation by ID |
| GET | `/affirmations/random` | Get a random affirmation |
| GET | `/affirmations/category/:category` | Get affirmations by category |
| GET | `/affirmations/categories` | Get all available categories |
| POST | `/affirmations` | Create a new affirmation |
| PUT | `/affirmations/:id` | Update an affirmation |
| DELETE | `/affirmations/:id` | Delete an affirmation |

## Usage Examples

### Get all affirmations
```bash
curl http://localhost:4567/affirmations
```

### Get a random affirmation
```bash
curl http://localhost:4567/affirmations/random
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

### Get affirmations by category
```bash
curl http://localhost:4567/affirmations/category/motivation
```

## Data Structure

### Affirmation Object
```json
{
  "id": 1,
  "text": "I am capable of achieving great things",
  "category": "motivation",
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

## Sample Data

The API comes pre-loaded with 5 sample affirmations across different categories:
- motivation
- growth
- confidence
- potential
- self-worth

## Development

This is a simple in-memory API perfect for:
- Learning and testing
- Prototyping
- Small applications
- Development environments

For production use, consider adding persistent storage (database) and additional features like authentication.

## License

This project is open source and available under the MIT License.
