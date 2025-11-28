# TruLens-verifying-information
TruLens is a powerful AI-based web application that helps fight fake news and deepfakes by providing authenticity verification in seconds. By combining Agentic AI, NLP, deep learning, government verification, and multilingual processing, TruLens offers a reliable tool for today’s information-driven world.
A comprehensive web application that uses artificial intelligence to detect fake news, misinformation, and manipulated content across text, media, and URLs. Built with React, TypeScript, Vite, and powered by Google Gemini AI.

## 🌟 Features

### Multi-Format Analysis
- **Text Analysis** - Analyze news articles, social media posts, and claims for authenticity
- **Media Analysis** - Detect deepfakes and manipulations in images, videos, and audio files
- **URL Verification** - Check website credibility, domain reputation, and phishing risks

### Advanced AI Capabilities
- **Multilingual Support** - Automatic language detection and analysis in 25+ languages including:
  - English, Spanish, French, German, Portuguese, Italian
  - Hindi, Arabic, Chinese, Japanese, Korean
  - Bengali, Punjabi, Telugu, Marathi, Tamil, Urdu
  - Turkish, Vietnamese, Thai, Indonesian, Dutch, Polish, Ukrainian, Russian

- **Fact Checking** - Cross-references claims with official sources (WHO, CDC, NASA, Reuters, etc.)
- **Source Credibility Analysis** - Evaluates the trustworthiness of information sources
- **Bias Detection** - Identifies potential bias and manipulation tactics
- **Corrected Statements** - Provides accurate information when false claims are detected

### Real-Time Results
- **Authenticity Score** - 0-100% credibility rating
- **Detection Metrics** - Detailed breakdown of analysis factors
- **Key Findings** - Specific issues or authenticity indicators identified
- **AI Recommendations** - Actionable guidance on how to treat the content

### User Experience
- **Notification Center** - Track all analyzed content history
- **Language Selection** - Manual language override option
- **Responsive Design** - Works seamlessly on desktop and mobile devices
- **Dark Theme** - Modern, eye-friendly interface

## 🚀 Getting Started

### Prerequisites
- Node.js 18+ and npm
- Supabase account (database and edge functions)
- Google Gemini API key

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd project
```

2. **Install dependencies**
```bash
npm install
```

3. **Configure environment variables**

Create a `.env` file in the root directory:
```env
VITE_SUPABASE_URL=your_supabase_project_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
VITE_GEMINI_API_KEY=your_gemini_api_key
```

4. **Set up Supabase**

The database schema is automatically created through migrations. Run:
```bash
# Apply migrations (if using Supabase CLI)
supabase db push
```

5. **Deploy Edge Functions**

The `analyze-content` edge function handles all AI analysis. It's deployed automatically through the Supabase MCP integration.

6. **Start development server**
```bash
npm run dev
```

The application will be available at `http://localhost:5173`

## 🏗️ Project Structure

```
project/
├── src/
│   ├── components/          # React components
│   │   ├── Hero.tsx         # Landing page hero section
│   │   ├── Features.tsx     # Feature showcase
│   │   ├── InputTypeSelector.tsx  # Analysis type selection
│   │   ├── TextInput.tsx    # Text content input
│   │   ├── FileUpload.tsx   # Media file upload
│   │   ├── URLInput.tsx     # URL verification input
│   │   ├── AnalysisResult.tsx  # Results display
│   │   ├── FactCheckSection.tsx  # Fact-check results
│   │   ├── NotificationCenter.tsx  # History panel
│   │   └── LanguageSelector.tsx  # Language switcher
│   │
│   ├── contexts/            # React contexts
│   │   └── LanguageContext.tsx  # Language state management
│   │
│   ├── services/            # API and business logic
│   │   ├── analysisService.ts    # Analysis API calls
│   │   └── notificationService.ts  # Notification CRUD
│   │
│   ├── utils/               # Utility functions
│   │   └── translations.ts  # Multilingual translations
│   │
│   ├── lib/                 # Third-party integrations
│   │   └── supabase.ts      # Supabase client
│   │
│   ├── App.tsx              # Main application component
│   ├── main.tsx             # Application entry point
│   └── index.css            # Global styles
│
├── supabase/
│   ├── functions/
│   │   └── analyze-content/  # Edge function for AI analysis
│   │       └── index.ts
│   └── migrations/           # Database schema migrations
│
├── public/                   # Static assets
├── package.json             # Dependencies and scripts
├── vite.config.ts           # Vite configuration
├── tailwind.config.js       # Tailwind CSS configuration
└── tsconfig.json            # TypeScript configuration
```

## 🔧 Available Scripts

```bash
# Development
npm run dev          # Start development server

# Building
npm run build        # Build for production
npm run preview      # Preview production build

# Code Quality
npm run lint         # Run ESLint
npm run typecheck    # Run TypeScript type checking
```

## 📊 Database Schema

### Notifications Table
Stores analysis history for users:
- `id` - Unique identifier (UUID)
- `content` - Analyzed content (text/URL/filename)
- `content_type` - Type: 'text' | 'media' | 'url'
- `verdict` - Analysis result: 'TRUE' | 'FALSE' | 'MISLEADING' | 'NEEDS_VERIFICATION'
- `authenticity_score` - Credibility score (0-100)
- `reasoning` - AI recommendation text
- `key_findings` - Array of specific findings
- `corrected_statement` - Correct information (for false claims)
- `sources` - Array of official verification sources
- `user_id` - User identifier
- `is_read` - Read status flag
- `created_at` - Timestamp
- `updated_at` - Timestamp

## 🤖 AI Analysis Pipeline

### 1. Language Detection
- Analyzes text script/alphabet (Latin, Devanagari, Arabic, Chinese, etc.)
- Identifies language-specific patterns
- Returns ISO 639-1 language code

### 2. Content Analysis
**For Text:**
- Sensationalist language detection
- Source credibility assessment
- Factual accuracy evaluation
- Bias identification
- Writing quality analysis

**For URLs:**
- Domain reputation check
- HTTPS security verification
- Phishing pattern detection
- Known legitimate source identification
- Suspicious URL structure analysis

**For Media:**
- Metadata integrity verification
- Visual consistency analysis
- Artifact detection
- Pattern anomaly identification

### 3. Fact Checking (for low scores < 70%)
- Extracts main claim
- Cross-references with official sources
- Provides corrected information
- Lists authoritative verification sources

### 4. Result Generation
- Authenticity score (0-100%)
- Detection metrics breakdown
- Specific findings (4 items)
- AI recommendation
- Fact-check results (if applicable)

All outputs are provided in the detected language for better user understanding.

## 🌐 Supported Languages

The system automatically detects and responds in these languages:

| Code | Language | Code | Language | Code | Language |
|------|----------|------|----------|------|----------|
| en | English | es | Spanish | fr | French |
| de | German | it | Italian | pt | Portuguese |
| hi | Hindi | ar | Arabic | zh | Chinese |
| ja | Japanese | ko | Korean | ru | Russian |
| bn | Bengali | pa | Punjabi | te | Telugu |
| mr | Marathi | ta | Tamil | ur | Urdu |
| tr | Turkish | vi | Vietnamese | th | Thai |
| id | Indonesian | nl | Dutch | pl | Polish |
| uk | Ukrainian | | | | |

## 🔐 Security & Privacy

- **No Personal Data Collection** - Only analyzed content is stored
- **Supabase RLS** - Row-level security enabled on all tables
- **HTTPS Required** - Secure communication only
- **API Key Protection** - Environment variables for sensitive keys
- **CORS Enabled** - Proper cross-origin resource sharing

## 🎨 Technology Stack

**Frontend:**
- React 18 with TypeScript
- Vite for fast development and building
- Tailwind CSS for styling
- Lucide React for icons

**Backend:**
- Supabase (PostgreSQL database)
- Supabase Edge Functions (Deno runtime)
- Google Gemini AI for analysis

**Libraries:**
- @supabase/supabase-js - Supabase client
- React Hooks for state management

## 📝 API Integration

### Google Gemini AI
The application uses Google's Gemini AI model for:
- Language detection
- Content analysis
- Fact checking
- Multilingual response generation

To get a Gemini API key:
1. Visit [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Add it to your `.env` file

### Supabase Setup
1. Create a project at [Supabase](https://supabase.com)
2. Get your project URL and anon key from Settings > API
3. Add them to your `.env` file
4. Migrations will automatically create the required tables

## 🚦 Usage Examples

### Analyzing Text
```javascript
// User pastes suspicious message
"URGENT! New virus spreading! Share immediately!!!"

// System returns:
- Authenticity Score: 25%
- Findings: Sensationalist language, no source attribution, emotional manipulation
- Recommendation: Treat with high skepticism, verify with health authorities
```

### Verifying URLs
```javascript
// User submits URL
"https://bbc.com/news/world-12345"

// System returns:
- Authenticity Score: 95%
- Findings: HTTPS secure, recognized news source, legitimate domain
- Recommendation: Credible source, content appears authentic
```

### Fact Checking
```javascript
// User submits false claim about vaccines
"Vaccines contain microchips for tracking"

// System returns:
- Verdict: FALSE
- Corrected Statement: "Vaccines do not contain microchips..."
- Sources: CDC, WHO, Reuters Fact Check
```

## 🤝 Contributing

This is a demonstration project. If you'd like to contribute:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📄 License

This project is for educational and demonstration purposes.

## 🙏 Acknowledgments

- **Google Gemini AI** - Powering the AI analysis
- **Supabase** - Backend infrastructure and database
- **Tailwind CSS** - Beautiful, responsive UI
- **Lucide Icons** - Clean, modern iconography

## 📞 Support

For issues, questions, or suggestions, please open an issue on the repository.

---

**Built with ❤️ to combat misinformation and promote media literacy**
