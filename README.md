# LancerCalc

A Flutter currency calculator built for freelancers who need quick currency conversion and tax calculations in one place, without juggling multiple apps or manual math.

This project is also a hands-on learning vehicle for Flutter, Bloc/Cubit architecture, API integration, and professional development workflows (feature branches, PRs, CI, conventional commits).

## The Problem

Freelancers regularly need to convert payments between currencies and calculate tax percentages on income. Doing this with a standard calculator means manually running one equation, writing down the result, then running a second equation with that number, currency conversion after every calculation. LancerCalc handles both in a single flow.

## Status

**v0.1 — In active development.**

| Screen | Status |
|---|---|
| Calculator | Functionally complete |
| Settings / Currency Selection | Partially complete |
| Tax | Not yet built |
| Currencies | Not yet built |

The project is currently in a planning phase before building the Tax and Currencies screens, covering the v1 feature set, screen design, and an API caching strategy.

### Known gaps (intentionally deferred, tracked as `TODO`s in code)
- Double-negative (`--`) handling in the calculator input
- Full responsive layout across screen sizes
- API response caching

## Features

- Real-time currency conversion using live exchange rates
- Quick swap between two selected currencies
- Persistent currency preferences (saved locally between sessions)
- Standard calculator functionality (basic operations, decimal handling)

**Planned:**
- Tax calculation screen
- Full currency management screen
- Full responsive layout
- API response caching

## Tech Stack

- **Framework:** Flutter / Dart
- **State Management:** Bloc / Cubit (`flutter_bloc`)
- **HTTP Client:** `dio`
- **Local Storage:** `shared_preferences`
- **Math Parsing:** `math_expressions`
- **API:** [ExchangeRate-API](https://www.exchangerate-api.com/)
- **CI:** GitHub Actions (`flutter analyze` on push to `main`)

## Getting Started

### Prerequisites
- Flutter SDK (see `pubspec.yaml` for the supported Dart SDK range)
- A free API key from [ExchangeRate-API](https://www.exchangerate-api.com/)

### Setup

1. Clone the repo:
   ```bash
   git clone https://github.com/Omar-E-Khalifa/currency_calculator.git
   cd currency_calculator
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Create a `secrets.json` file in the project root (this file is gitignored):
   ```json
   {
     "EXCHANGE_RATE_API_KEY": "your_api_key_here"
   }
   ```

4. Run the app with the secrets file loaded:
   ```bash
   flutter run --dart-define-from-file secrets.json
   ```

   If you're using VS Code, the included `.vscode/launch.json` configurations already pass this flag for debug, profile, and release modes.

## Project Structure

```
lib/
├── cubits/          # State management (Bloc/Cubit)
├── data/            # Static data (e.g. calculator button layout)
├── models/          # Data models
├── services/        # API and local storage services
├── views/           # App screens
└── widgets/         # Reusable UI components
```

## Target Platform

Android (Play Store)
