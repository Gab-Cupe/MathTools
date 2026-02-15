
# MathTools

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)


**Plataforma de aprendizaje matemático y herramientas avanzadas construida con Flutter y Firebase.**

[Ver Demo en Vivo](https://mathtools-psy.netlify.app/)

[![Invitame un cafe](https://img.shields.io/badge/Invitame_un_cafe-FFDD00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/gabcupe)

</div>

---

## Vista Previa del Sistema

| Panel Principal | Graficadora de Funciones | Calculadora Cientifica |
| :---: | :---: | :---: |
| ![Dashboard](https://i.ibb.co/3Ymw1vx1/image.png) | ![Grapher](https://i.ibb.co/FqLMB5TR/image.png) | ![Calculator](https://i.ibb.co/67f9FhQ2/image.pngt) |

| Sistema de Ejercicios | Perfil y Logros | Modo Oscuro |
| :---: | :---: | :---: |
| ![Exercises](https://i.ibb.co/MHyhxyx/image.png) | ![Profile](https://i.ibb.co/ccq17S4C/image.png) | ![DarkMode](https://i.ibb.co/xK0m5MSY/image.png) |

---

## Caracteristicas Detalladas

### Herramientas Matematicas
* **Calculadora Cientifica:** Funciones trigonometricas (seno, coseno, tangente e inversas), logaritmos, factoriales mediante funcion Gamma, potencias, raices y modulo.
* **Graficadora 2D:** Plotter interactivo con soporte para multiples funciones simultaneas, zoom, desplazamiento y parseo de multiplicacion implicita.
* **Conversor de Unidades:** Soporte para Longitud, Masa, Temperatura, Tiempo y Divisas con actualizacion de tasas de cambio en tiempo real.

### Sistema Educativo Gamificado
* **Modo de Ejercicios:** Sesiones personalizables por tema y dificultad (Facil, Medio, Dificil, Experto) con sistema de penalizacion por errores.
* **Reto Diario:** Problema matematico unico cada 24 horas con recompensas especiales de puntaje.
* **Gestion de Perfil:** Personalizacion de avatar, estadisticas de rendimiento y sistema de rangos (Novato, Aprendiz, Experto, Maestro, Leyenda).

### Panel de Administracion
* Control de usuarios registrados.
* Editor de retos diarios.
* Creador y gestor de bancos de ejercicios por categorias.

---

## Stack Tecnologico

<div align="center">

![Provider](https://img.shields.io/badge/Provider-02569B?style=flat-square&logo=flutter&logoColor=white)
![Latex](https://img.shields.io/badge/LaTeX-008080?style=flat-square&logo=latex&logoColor=white)
![Lottie](https://img.shields.io/badge/Lottie-00D1B2?style=flat-square&logo=lottie&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)

</div>

* **Estado:** Provider Pattern con ChangeNotifier.
* **Renderizado:** LaTeX mediante flutter_math_fork.
* **Animaciones:** Lottie y flutter_animate.
* **Persistencia:** Shared Preferences para configuraciones locales y temas.

---

## Arquitectura de Directorios

```text
lib/
├── main.dart             # Configuracion de MultiProvider y Rutas
├── firebase_options.dart # Configuracion multiplataforma de Firebase
├── auth/                 # Registro e inicio de sesion
├── screens/              # Vistas principales del sistema
├── challenge/            # Logica del Reto Diario
├── options/
│   ├── convertidor/      # Modulo de conversion de unidades
│   ├── exercises/        # Motor de ejercicios y resultados
│   ├── explorador/       # Buscador de herramientas
│   └── graficadora/      # Motor grafico de funciones
├── perfil/               # Gestion de usuarios y logros
├── admin/                # Herramientas de gestion de base de datos
├── models/               # Modelos de datos (User, Exercise, Reto)
├── services/             # Integracion con Firebase y APIs externas
└── providers/            # Manejo de estado (ThemeProvider)

```

---

## Instalacion y Despliegue

### Requisitos

* Flutter SDK v3.11.0 o superior.
* Cuenta de Firebase con Realtime Database activo.

### Instrucciones

1. **Clonacion del repositorio:**
```bash
git clone https://github.com/Gab-Cupe/MathTools.git
cd MathTools

```


2. **Instalacion de paquetes:**
```bash
flutter pub get

```


3. **Configuracion de Firebase:**
Utilice FlutterFire CLI para generar la configuracion automatica:
```bash
flutterfire configure

```


4. **Ejecucion:**
```bash
flutter run

```



---

## Paleta de Colores Oficial

| Proposito | Color | Hexadecimal |
| --- | --- | --- |
| Primario |  | `#0924AA` |
| Secundario |  | `#0380FB` |
| Sky Blue |  | `#A8EFFA` |
| Accent |  | `#FFCB87` |

---

## Licencia

Este proyecto se distribuye como software de codigo abierto. Puede ser utilizado para fines educativos y proyectos personales.

```

```