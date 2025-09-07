#!/usr/bin/env python3
"""
Generate static HTML files for GitHub Pages deployment
This creates a static version of your API that works with GitHub Pages
"""

import json
import os
import random

def load_affirmations():
    with open('affirmations.json', 'r') as f:
        return json.load(f)

def generate_static_site():
    affirmations = load_affirmations()
    
    # Create docs directory for GitHub Pages
    os.makedirs('docs', exist_ok=True)
    
    # Generate index.html
    index_html = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Affirmations API</title>
    <style>
        body {{ font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }}
        .affirmation {{ background: #f0f8ff; padding: 20px; margin: 10px 0; border-radius: 8px; }}
        .category {{ color: #666; font-size: 0.9em; }}
        .random-btn {{ background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; }}
        .random-btn:hover {{ background: #0056b3; }}
    </style>
</head>
<body>
    <h1>🌟 Affirmations API</h1>
    <p>Welcome to the Affirmations API! This static version contains {len(affirmations)} affirmations.</p>
    
    <button class="random-btn" onclick="showRandom()">Get Random Affirmation</button>
    
    <div id="random-affirmation" class="affirmation" style="display:none;">
        <div id="affirmation-text"></div>
        <div id="affirmation-category" class="category"></div>
    </div>
    
    <h2>All Affirmations</h2>
    <div id="all-affirmations">
        {generate_affirmations_html(affirmations)}
    </div>
    
    <script>
        const affirmations = {json.dumps(affirmations)};
        
        function showRandom() {{
            const random = affirmations[Math.floor(Math.random() * affirmations.length)];
            document.getElementById('affirmation-text').textContent = random.text;
            document.getElementById('affirmation-category').textContent = `Category: ${{random.category}}`;
            document.getElementById('random-affirmation').style.display = 'block';
        }}
    </script>
</body>
</html>"""
    
    with open('docs/index.html', 'w') as f:
        f.write(index_html)
    
    # Generate API endpoints as JSON files
    with open('docs/affirmations.json', 'w') as f:
        json.dump(affirmations, f, indent=2)
    
    # Generate categories
    categories = list(set(a['category'] for a in affirmations))
    with open('docs/categories.json', 'w') as f:
        json.dump({'categories': categories, 'total_categories': len(categories)}, f, indent=2)
    
    # Generate random affirmation endpoint
    random_affirmation = random.choice(affirmations)
    with open('docs/random.json', 'w') as f:
        json.dump(random_affirmation, f, indent=2)
    
    print(f"✅ Generated static site with {len(affirmations)} affirmations")
    print("📁 Files created in 'docs/' directory")
    print("🚀 Ready for GitHub Pages deployment!")

def generate_affirmations_html(affirmations):
    html = ""
    for aff in affirmations:
        html += f"""
        <div class="affirmation">
            <div>{aff['text']}</div>
            <div class="category">Category: {aff['category']}</div>
        </div>"""
    return html

if __name__ == "__main__":
    generate_static_site()
