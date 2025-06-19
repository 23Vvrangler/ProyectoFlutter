import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._(); // Constructor privado para evitar instanciación

  // =========================================================================
  // 1. Controladores Globales del Tema
  // =========================================================================
  static bool useMaterial3 = true; // Siempre true para aprovechar M3
  static bool useLightMode = true; // Determina si la app usa el modo claro
  static int colorSelected = 0; // Índice del esquema de color seleccionado

  // =========================================================================
  // 2. Definición de Semillas de Color para los Esquemas de Color
  //    Estos son los puntos de partida para generar los ColorScheme.
  //    Las tonalidades azules formales serán la primera opción.
  // =========================================================================

  // Color semilla para las tonalidades azules formales
  static const Color formalBlueSeed = Color(0xFF0D47A1); // Azul oscuro, muy formal

  // Tus otras semillas de color
  static const Color brightGreenSeed = Color(0xFF1DCD9F); // Verde azulado brillante
  static const Color darkEmeraldSeed = Color(0xFF169976); // Verde esmeralda oscuro
  static const Color standardBlueSeed = Colors.blue; // El azul estándar de Material
  static const Color standardGreenSeed = Colors.green; // El verde estándar de Material
  static const Color standardTealSeed = Colors.teal; // Añadido Teal para completar tus opciones
  static const Color standardYellowSeed = Colors.yellow; // Añadido Yellow
  static const Color standardOrangeSeed = Colors.orange; // Añadido Orange
  static const Color standardPinkSeed = Colors.pink; // Añadido Pink

  // Lista de todas las semillas de color disponibles
  static List<Color> seedColors = [
    formalBlueSeed,     // 0: Azul Formal (por defecto)
    brightGreenSeed,    // 1: Verde Brillante
    darkEmeraldSeed,    // 2: Verde Esmeralda
    standardBlueSeed,   // 3: Azul Estándar
    standardGreenSeed,  // 4: Verde Estándar
    standardTealSeed,   // 5: Teal
    standardYellowSeed, // 6: Amarillo
    standardOrangeSeed, // 7: Naranja
    standardPinkSeed,   // 8: Rosa
  ];

  // Nombres descriptivos para cada semilla de color
  static List<String> seedColorNames = <String>[
    "Azul Formal",
    "Verde Brillante",
    "Verde Esmeralda",
    "Azul Estándar",
    "Verde Estándar",
    "Teal",
    "Amarillo",
    "Naranja",
    "Rosa",
  ];

  // =========================================================================
  // 3. Generación Dinámica de ColorScheme
  //    Utiliza fromSeed para la generación base, lo cual es más robusto.
  //    Si necesitas un control muy específico, puedes anular propiedades.
  // =========================================================================

  // Genera el ColorScheme claro para la semilla seleccionada
  static ColorScheme get _selectedLightColorScheme {
    // Si necesitas sobreescribir colores específicos después de fromSeed, hazlo aquí.
    // Ejemplo:
    // ColorScheme baseScheme = ColorScheme.fromSeed(seedColor: seedColors[colorSelected], brightness: Brightness.light);
    // return baseScheme.copyWith(surface: MyCustomColor.lightSurface);
    return ColorScheme.fromSeed(
      seedColor: seedColors[colorSelected],
      brightness: Brightness.light,
    );
  }


  // Genera el ColorScheme oscuro para la semilla seleccionada
  static ColorScheme get _selectedDarkColorScheme {
    return ColorScheme.fromSeed(
      seedColor: seedColors[colorSelected],
      brightness: Brightness.dark,
    );
  }


  // =========================================================================
  // 4. Definición de Propiedades Comunes del Tema
  //    Colores genéricos o constantes que no cambian con el esquema.
  // =========================================================================
  static const Color grey = Color(0xFF3A5160);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static Color colorMenu = const Color(0xFF3A5160); // Ejemplo de color específico

  // =========================================================================
  // 5. Definición de Tipografía para el Tema
  // =========================================================================
  // Asegúrate de que la fuente 'Roboto' esté en tu pubspec.yaml si la usas.
  // fonts:
  //   - family: Roboto
  //     fonts:
  //       - asset: assets/fonts/Roboto-Regular.ttf
  //       - asset: assets/fonts/Roboto-Bold.ttf
  //         weight: 700
  static const TextTheme _appTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
    displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
    headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, fontFamily: 'Roboto'),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Roboto'),
  );

  // =========================================================================
  // 6. Temas Claros y Oscuros Completos (aplican el ColorScheme generado)
  // =========================================================================

  // Tema CLARO completo
  static ThemeData get themeDataLight => ThemeData(
    useMaterial3: useMaterial3,
    colorScheme: _selectedLightColorScheme, // Usa el ColorScheme generado
    textTheme: _appTextTheme, // Aplica la tipografía definida

    appBarTheme: AppBarTheme(
      backgroundColor: _selectedLightColorScheme.primary,
      foregroundColor: _selectedLightColorScheme.onPrimary,
      elevation: 4, // Un poco de elevación para formalidad
      centerTitle: true,
      titleTextStyle: _appTextTheme.titleLarge!.copyWith(
        color: _selectedLightColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: _selectedLightColorScheme.surface, // CORREGIDO: 'surface' o 'surfaceVariant'
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8.0), // Margen por defecto para tarjetas
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedLightColorScheme.primary,
        foregroundColor: _selectedLightColorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: _appTextTheme.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _selectedLightColorScheme.primary,
        side: BorderSide(color: _selectedLightColorScheme.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: _appTextTheme.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _selectedLightColorScheme.primary,
        textStyle: _appTextTheme.labelLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _selectedLightColorScheme.surfaceVariant.withOpacity(0.3),
      hintStyle: _appTextTheme.bodyLarge!.copyWith(color: _selectedLightColorScheme.onSurfaceVariant),
      labelStyle: _appTextTheme.bodyLarge!.copyWith(color: _selectedLightColorScheme.onSurface),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none, // Sin borde visible si filled es true
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _selectedLightColorScheme.outlineVariant, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _selectedLightColorScheme.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _selectedLightColorScheme.error, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _selectedLightColorScheme.error, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _selectedLightColorScheme.secondary,
      foregroundColor: _selectedLightColorScheme.onSecondary,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _selectedLightColorScheme.surface,
      selectedItemColor: _selectedLightColorScheme.primary,
      unselectedItemColor: _selectedLightColorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: _appTextTheme.labelSmall,
      unselectedLabelStyle: _appTextTheme.labelSmall,
    ),

    // Puedes añadir más temas para otros widgets aquí (Dialog, TabBar, etc.)
  );

  // Tema OSCURO completo
  static ThemeData get themeDataDark => ThemeData(
    useMaterial3: useMaterial3,
    colorScheme: _selectedDarkColorScheme, // Usa el ColorScheme generado
    textTheme: _appTextTheme, // Aplica la tipografía definida

    appBarTheme: AppBarTheme(
      backgroundColor: _selectedDarkColorScheme.primary,
      foregroundColor: _selectedDarkColorScheme.onPrimary,
      elevation: 4,
      centerTitle: true,
      titleTextStyle: _appTextTheme.titleLarge!.copyWith(
        color: _selectedDarkColorScheme.onPrimary,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: _selectedDarkColorScheme.surface, // CORREGIDO: 'surface' o 'surfaceVariant'
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(8.0),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _selectedDarkColorScheme.primary,
        foregroundColor: _selectedDarkColorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: _appTextTheme.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _selectedDarkColorScheme.primary,
        side: BorderSide(color: _selectedDarkColorScheme.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        textStyle: _appTextTheme.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _selectedDarkColorScheme.primary,
        textStyle: _appTextTheme.labelLarge,
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _selectedDarkColorScheme.surfaceVariant.withOpacity(0.3),
      hintStyle: _appTextTheme.bodyLarge!.copyWith(color: _selectedDarkColorScheme.onSurfaceVariant),
      labelStyle: _appTextTheme.bodyLarge!.copyWith(color: _selectedDarkColorScheme.onSurface),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _selectedDarkColorScheme.outlineVariant, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _selectedDarkColorScheme.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _selectedDarkColorScheme.error, width: 2.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _selectedDarkColorScheme.error, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _selectedDarkColorScheme.secondary,
      foregroundColor: _selectedDarkColorScheme.onSecondary,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _selectedDarkColorScheme.surface,
      selectedItemColor: _selectedDarkColorScheme.primary,
      unselectedItemColor: _selectedDarkColorScheme.onSurfaceVariant,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: _appTextTheme.labelSmall,
      unselectedLabelStyle: _appTextTheme.labelSmall,
    ),

    // Agrega más temas para otros widgets aquí (Dialog, TabBar, etc.)
  );

  // =========================================================================
  // 7. Color Schemes Estáticos Originales (mantengo solo por referencia visual)
  //    Estos ya no son usados directamente por `themeDataLight`/`Dark` si usas `fromSeed`.
  //    Puedes eliminarlos si estás seguro de que no los necesitas para nada.
  // =========================================================================

  // Color Scheme para #1DCD9F (Verde Azulado Brillante) - Light
  static const lightColorSchemeBrightGreen = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006B5D),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF70F8E1),
    onPrimaryContainer: Color(0xFF00201B),
    secondary: Color(0xFF4A635E),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFCDE8E1),
    onSecondaryContainer: Color(0xFF06201B),
    tertiary: Color(0xFF43627A),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFC7E7FF),
    onTertiaryContainer: Color(0xFF001E32),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFBFBFB),
    onBackground: Color(0xFF191C1B),
    surface: Color(0xFFFBFBFB), // AGREGADO/CONFIRMADO
    onSurface: Color(0xFF191C1B), // AGREGADO/CONFIRMADO
    surfaceVariant: Color(0xFFDBE5E0), // AGREGADO/CONFIRMADO
    onSurfaceVariant: Color(0xFF3F4946), // AGREGADO/CONFIRMADO
    outline: Color(0xFF6F7976),
    onInverseSurface: Color(0xFFF0F1EF),
    inverseSurface: Color(0xFF2E3130),
    inversePrimary: Color(0xFF4FDBCA),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006B5D),
    outlineVariant: Color(0xFFBFC9C4),
    scrim: Color(0xFF000000),
  );

  // Color Scheme para #1DCD9F (Verde Azulado Brillante) - Dark
  static const darkColorSchemeBrightGreen = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF4FDBCA),
    onPrimary: Color(0xFF00372F),
    primaryContainer: Color(0xFF005046),
    onPrimaryContainer: Color(0xFF70F8E1),
    secondary: Color(0xFFB1CCC5),
    onSecondary: Color(0xFF1C3530),
    secondaryContainer: Color(0xFF334B46),
    onSecondaryContainer: Color(0xFFCDE8E1),
    tertiary: Color(0xFFABCBE6),
    onTertiary: Color(0xFF12334A),
    tertiaryContainer: Color(0xFF2B4A62),
    onTertiaryContainer: Color(0xFFC7E7FF),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF191C1B),
    onBackground: Color(0xFFE0E3E1),
    surface: Color(0xFF191C1B), // AGREGADO/CONFIRMADO
    onSurface: Color(0xFFE0E3E1), // AGREGADO/CONFIRMADO
    surfaceVariant: Color(0xFF3F4946), // AGREGADO/CONFIRMADO
    onSurfaceVariant: Color(0xFFBFC9C4), // AGREGADO/CONFIRMADO
    outline: Color(0xFF88938F),
    onInverseSurface: Color(0xFF191C1B),
    inverseSurface: Color(0xFFE0E3E1),
    inversePrimary: Color(0xFF006B5D),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF4FDBCA),
    outlineVariant: Color(0xFF3F4946),
    scrim: Color(0xFF000000),
  );

  // Color Scheme para #169976 (Verde Esmeralda Oscuro) - Light
  static const lightColorSchemeDarkEmerald = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF006C4C),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF8CF8C9),
    onPrimaryContainer: Color(0xFF002114),
    secondary: Color(0xFF4E6359),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD0E8DA),
    onSecondaryContainer: Color(0xFF0C1F17),
    tertiary: Color(0xFF3E6375),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFC1E8FD),
    onTertiaryContainer: Color(0xFF001E2B),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFBFDF8),
    onBackground: Color(0xFF191C1A),
    surface: Color(0xFFFBFDF8), // AGREGADO/CONFIRMADO
    onSurface: Color(0xFF191C1A), // AGREGADO/CONFIRMADO
    surfaceVariant: Color(0xFFDCE5DD), // AGREGADO/CONFIRMADO
    onSurfaceVariant: Color(0xFF414942), // AGREGADO/CONFIRMADO
    outline: Color(0xFF717972),
    onInverseSurface: Color(0xFFF0F1EC),
    inverseSurface: Color(0xFF2E312E),
    inversePrimary: Color(0xFF6FDBAD),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF006C4C),
    outlineVariant: Color(0xFFC0C9C1),
    scrim: Color(0xFF000000),
  );

  // Color Scheme para #169976 (Verde Esmeralda Oscuro) - Dark
  static const darkColorSchemeDarkEmerald = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF6FDBAD),
    onPrimary: Color(0xFF003826),
    primaryContainer: Color(0xFF005238),
    onPrimaryContainer: Color(0xFF8CF8C9),
    secondary: Color(0xFFB4CCBE),
    onSecondary: Color(0xFF21342D),
    secondaryContainer: Color(0xFF374B42),
    onSecondaryContainer: Color(0xFFD0E8DA),
    tertiary: Color(0xFFA5CCE6),
    onTertiary: Color(0xFF073546),
    tertiaryContainer: Color(0xFF254B5D),
    onTertiaryContainer: Color(0xFFC1E8FD),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF191C1A),
    onBackground: Color(0xFFE1E3DE),
    surface: Color(0xFF191C1A), // AGREGADO/CONFIRMADO
    onSurface: Color(0xFFE1E3DE), // AGREGADO/CONFIRMADO
    surfaceVariant: Color(0xFF414942), // AGREGADO/CONFIRMADO
    onSurfaceVariant: Color(0xFFC0C9C1), // AGREGADO/CONFIRMADO
    outline: Color(0xFF8A938C),
    onInverseSurface: Color(0xFF191C1A),
    inverseSurface: Color(0xFFE1E3DE),
    inversePrimary: Color(0xFF006C4C),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF6FDBAD),
    outlineVariant: Color(0xFF414942),
    scrim: Color(0xFF000000),
  );

  static const lightColorSchemeGreen = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF146E00),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFF9EF981),
    onPrimaryContainer: Color(0xFF022100),
    secondary: Color(0xFF54624D),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD7E8CC),
    onSecondaryContainer: Color(0xFF121F0E),
    tertiary: Color(0xFF386668),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBCEBED),
    onTertiaryContainer: Color(0xFF002021),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFDFDF6),
    onBackground: Color(0xFF1A1C18),
    surface: Color(0xFFFDFDF6), // AGREGADO/CONFIRMADO
    onSurface: Color(0xFF1A1C18), // AGREGADO/CONFIRMADO
    surfaceVariant: Color(0xFFDFE4D7), // AGREGADO/CONFIRMADO
    onSurfaceVariant: Color(0xFF43483F), // AGREGADO/CONFIRMADO
    outline: Color(0xFF73796E),
    onInverseSurface: Color(0xFFF1F1EA),
    inverseSurface: Color(0xFF2F312D),
    inversePrimary: Color(0xFF83DB68),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF146E00),
    outlineVariant: Color(0xFFC3C8BC),
    scrim: Color(0xFF000000),
  );

  static const darkColorSchemeGreen = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF83DB68),
    onPrimary: Color(0xFF063900),
    primaryContainer: Color(0xFF0D5300),
    onPrimaryContainer: Color(0xFF9EF981),
    secondary: Color(0xFFBBCBB1),
    onSecondary: Color(0xFF273421),
    secondaryContainer: Color(0xFF3D4B36),
    onSecondaryContainer: Color(0xFFD7E8CC),
    tertiary: Color(0xFFA0CFD1),
    onTertiary: Color(0xFF003739),
    tertiaryContainer: Color(0xFF1E4E50),
    onTertiaryContainer: Color(0xFFBCEBED),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C18),
    onBackground: Color(0xFFE2E3DC),
    surface: Color(0xFF1A1C18), // AGREGADO/CONFIRMADO
    onSurface: Color(0xFFE2E3DC), // AGREGADO/CONFIRMADO
    surfaceVariant: Color(0xFF43483F), // AGREGADO/CONFIRMADO
    onSurfaceVariant: Color(0xFFC3C8BC), // AGREGADO/CONFIRMADO
    outline: Color(0xFF8D9387),
    onInverseSurface: Color(0xFF1A1C18),
    inverseSurface: Color(0xFFE2E3DC),
    inversePrimary: Color(0xFF146E00),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF83DB68),
    outlineVariant: Color(0xFF43483F),
    scrim: Color(0xFF000000),
  );


  static const lightColorSchemeBlue = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF0062A1),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFD0E4FF),
    onPrimaryContainer: Color(0xFF001D35),
    secondary: Color(0xFF525F70),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD6E4F7),
    onSecondaryContainer: Color(0xFF0F1D2A),
    tertiary: Color(0xFF2E5DA8),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFD7E2FF),
    onTertiaryContainer: Color(0xFF001A40),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFDFCFF),
    onBackground: Color(0xFF1A1C1E),
    surface: Color(0xFFFDFCFF), // AGREGADO/CONFIRMADO
    onSurface: Color(0xFF1A1C1E), // AGREGADO/CONFIRMADO
    surfaceVariant: Color(0xFFDFE3EB), // AGREGADO/CONFIRMADO
    onSurfaceVariant: Color(0xFF42474E), // AGREGADO/CONFIRMADO
    outline: Color(0xFF73777F),
    onInverseSurface: Color(0xFFF1F0F4),
    inverseSurface: Color(0xFF2F3033),
    inversePrimary: Color(0xFF9CCAFF),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF0062A1),
    outlineVariant: Color(0xFFC2C7CF),
    scrim: Color(0xFF000000),
  );

  static const darkColorSchemeBlue = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF9CCAFF),
    onPrimary: Color(0xFF003256),
    primaryContainer: Color(0xFF00497B),
    onPrimaryContainer: Color(0xFFD0E4FF),
    secondary: Color(0xFFBAC8DB),
    onSecondary: Color(0xFF243140),
    secondaryContainer: Color(0xFF3B4857),
    onSecondaryContainer: Color(0xFFD6E4F7),
    tertiary: Color(0xFFACC7FF),
    onTertiary: Color(0xFF002F67),
    tertiaryContainer: Color(0xFF08458E),
    onTertiaryContainer: Color(0xFFD7E2FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C1E),
    onBackground: Color(0xFFE2E2E6),
    surface: Color(0xFF1A1C1E), // AGREGADO/CONFIRMADO
    onSurface: Color(0xFFE2E2E6), // AGREGADO/CONFIRMADO
    surfaceVariant: Color(0xFF42474E), // AGREGADO/CONFIRMADO
    onSurfaceVariant: Color(0xFFC2C7CF), // AGREGADO/CONFIRMADO
    outline: Color(0xFF8C9199),
    onInverseSurface: Color(0xFF1A1C1E),
    inverseSurface: Color(0xFFE2E2E6),
    inversePrimary: Color(0xFF0062A1),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF9CCAFF),
    outlineVariant: Color(0xFF42474E),
    scrim: Color(0xFF000000),
  );
}