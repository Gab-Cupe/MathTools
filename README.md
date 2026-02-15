
# MathTools

<div align="center">

![flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)


**Math learning platform and advanced tools built with Flutter and Firebase.**

[See Live Demo](https://mathtools-psy.netlify.app/)

[![Buy me a coffee](https://img.shields.io/badge/Buy_me_a_coffe-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/gabcupe)

</div>

---

## System Preview

| Main Panel | Function Grapher | Scientific Calculator |
| :---: | :---: | :---: |
| ![Dashboard](https://i.ibb.co/3Ymw1vx1/image.png) | ![Grapher](https://i.ibb.co/FqLMB5TR/image.png) | ![Calculator](https://i.ibb.co/67f9FhQ2/image.pngt) |

| Exercise System | Profile and Achievements | Dark Mode |
| :---: | :---: | :---: |
| ![exercises](https://i.ibb.co/MHyhxyx/image.png) | ![Profile](https://i.ibb.co/ccq17S4C/image.png) | ![DarkMode](https://i.ibb.co/xK0m5MSY/image.png) |

---

## Detailed Features

### Mathematical Tools
* **Scientific Calculator:** Trigonometric functions (sine, cosine, tangent and inverses), logarithms, factorials using Gamma function, powers, roots and module.
* **2D Plotter:** Interactive plotter with support for multiple simultaneous functions, zoom, scrolling and implicit multiplication parsing.
* **Unit Converter:** Support for Length, Mass, Temperature, Time and Currencies with real-time exchange rate updates.

### Gamified Educational System
* **Exercise Mode:** Customizable sessions by topic and difficulty (Easy, Medium, Difficult, Expert) with a penalty system for errors.
* **Daily Challenge:** Unique math problem every 24 hours with special score rewards.
* **Profile Management:** Avatar customization, performance statistics and rank system (Novice, Apprentice, Expert, Master, Legend).

### Administration Panel
* Control of registered users.
* Daily challenges editor.
* Creator and manager of exercise banks by categories.

---

## Technological Stack

<div align="center">

![Provider](https://img.shields.io/badge/Provider-02569B?style=flat-square&logo=flutter&logoColor=white)
![Latex](https://img.shields.io/badge/LaTeX-008080?style=flat-square&logo=latex&logoColor=white)
![Lottie](https://img.shields.io/badge/Lottie-00D1B2?style=flat-square&logo=lottie&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)

</div>

* **Status:** Provider Pattern with ChangeNotifier.
* **Rendered:** LaTeX using flutter_math_fork.
* **Animations:** Lottie and flutter_animate.
* **Persistence:** Shared Preferences for local settings and themes.

---

## Directory Architecture

```text
lib/
├── main.dart             # MultiProvider and Routes configuration
├── firebase_options.dart # Cross-platform Firebase configuration
├── auth/                 # Registration and login
├── screens/              # Main system views
├── challenge/            # Daily Challenge logic
├── options/
│   ├── convertidor/      # Unit conversion module
│   ├── exercises/        # Exercise engine and results
│   ├── explorador/       # Tool finder/search
│   └── graficadora/      # Function graphing engine
├── perfil/               # User management and achievements
├── admin/                # Database management tools
├── models/               # Data models (User, Exercise, Challenge)
├── services/             # Firebase integration and external APIs
└── providers/            # State management (ThemeProvider)
```

---

## Installation and Deployment

### Requirements

* Flutter SDK v3.11.0 or higher.
* Firebase account with Realtime Database active.

### Instructions

1. **Repository cloning:**
```bash
git clone https://github.com/Gab-Cupe/MathTools.git
cd MathTools

```


2. **Package installation:**
```bash
flutter pub get

```


3. **Firebase configuration:**
Use FlutterFire CLI to generate the automatic configuration:
```bash
flutterfire configure

```


4. **Execution:**
```bash
flutter run

```



---

## Official Color Palette

| Purpose | Color | Hexadecimal |
| --- | --- | --- |
| Primary |  | `#0924AA` |
| Secondary |  | `#0380FB` |
| Sky Blue |  | `#A8EFFA` |
| Accent |  | `#FFCB87` |

---

## License

This project is distributed as open source software. It can be used for educational purposes and personal projects.

---

<div align="center">

**Made with ❤️ using flutter**

</div>
