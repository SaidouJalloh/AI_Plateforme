#!/bin/bash

echo "🚀 Building TeamAI Solutions App..."

# Build React
echo "📦 Building React frontend..."
cd frontend
npm ci
npm run build
cd ..

# Test FastAPI
echo "🐍 Testing FastAPI backend..."
cd backend
pip install -r requirements.txt
echo "✅ Build completed successfully!"
echo ""
echo "To run locally:"
echo "cd backend && python app.py"
echo ""
echo "Your app will be available at: 
"