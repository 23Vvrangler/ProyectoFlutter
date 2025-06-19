import 'package:flutter/material.dart';
// Las API y el modelo podrían no ser necesarios si los datos ya están en TokenUtil
// import 'package:app_capac/apis/usuario_api.dart';
// import 'package:app_capac/modelo/UsuarioModelo.dart';
import 'package:app_capac/theme/AppTheme.dart';
import 'package:app_capac/login/login_user.dart';
import 'package:app_capac/util/TokenUtil.dart'; // Asegúrate de la ruta correcta

// ===========================================================================
// ¡SUGERENCIA IMPORTANTE!
// Mueve DrawerIndex y DrawerList a un archivo separado, por ejemplo:
// lib/models/drawer_data.dart o lib/utils/app_enums.dart
// Esto evita duplicidad si tienes otros drawers o necesitas usar estos enums/clases
// en otros lugares.
// ===========================================================================

enum DrawerIndex {
  HOME,
  PLACE_CATEGORY,
  LOCATIONS,
  PROFILE,
  RESERVATIONS,
  // NOTIFICATIONS, // Si agregaste Notificaciones al enum en setDrawerListArray
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    required this.index,
    this.imageName = '',
  });

  String labelName;
  Icon? icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}

// ===========================================================================

class UserDrawuser extends StatefulWidget {
  const UserDrawuser({
    super.key,
    required this.screenIndex,
    required this.iconAnimationController,
    required this.callBackIndex,
  });

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  _UserDrawuserState createState() => _UserDrawuserState();
}

class _UserDrawuserState extends State<UserDrawuser> {
  List<DrawerList>? drawerList;
  String estudianteNombre = 'Invitado'; // Valor predeterminado si no hay datos
  String estudianteApellido = '';
  String estudianteApellidoU = '';
  bool isLoading = false; // Ya no hay una carga asíncrona pesada aquí

  // Si UsuarioApi y UsuarioModelo no se usan para obtener datos aquí, puedes quitarlas
  // final UsuarioApi usuarioApi = UsuarioApi(); // No necesario si los datos vienen de TokenUtil

  @override
  void initState() {
    super.initState();
    setDrawerListArray();
    _loadUserDataFromTokenUtil(); // Usar el nuevo método
  }

  void _loadUserDataFromTokenUtil() {
    // Si TokenUtil.localx es true, significa que el usuario NO está logueado o el token es inválido
    if (TokenUtil.localx == false && TokenUtil.TOKEN.isNotEmpty) {
      // Asumo que TokenUtil.userName ya contiene el nombre completo o solo el nombre
      // Si TokenUtil.userName contiene el nombre completo, no necesitas apellidoP y apellidoM aquí
      // Si TokenUtil.userName solo es el nombre, necesitarías cargar los apellidos de algún lugar
      // Por simplicidad, asumiré que userName es el nombre principal o completo si no tienes apellidos.
      final parts = TokenUtil.userName.split(' ');
      setState(() {
        estudianteNombre = parts.isNotEmpty ? parts[0] : 'Usuario';
        estudianteApellido = parts.length > 1 ? parts[1] : '';
        estudianteApellidoU = parts.length > 2 ? parts[2] : '';
        // Si tienes TokenUtil.role, puedes usarlo aquí también
        // estudianteNombre = TokenUtil.userName;
        // estudianteApellido = ''; // O cargar de TokenUtil si existe
        // estudianteApellidoU = ''; // O cargar de TokenUtil si existe
      });
    } else {
      // Si no hay token o localx es true (no logueado)
      setState(() {
        estudianteNombre = 'Invitado';
        estudianteApellido = '';
        estudianteApellidoU = '';
      });
    }
    // No hay isLoading real en este caso, ya que los datos están en memoria
    isLoading = false;
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Principal',
        icon: const Icon(Icons.home_outlined),
      ),
      DrawerList(
        index: DrawerIndex.PLACE_CATEGORY,
        labelName: 'Categoría Lugar',
        icon: const Icon(Icons.category_outlined),
      ),
      DrawerList(
        index: DrawerIndex.LOCATIONS,
        labelName: 'Lugares',
        icon: const Icon(Icons.location_on_outlined),
      ),
      DrawerList(
        index: DrawerIndex.PROFILE,
        labelName: 'Perfil',
        icon: const Icon(Icons.person_outline),
      ),
      DrawerList(
        index: DrawerIndex.RESERVATIONS,
        labelName: 'Reservaciones',
        icon: const Icon(Icons.book_online_outlined),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.only(top: 40.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AnimatedBuilder(
                  animation: widget.iconAnimationController,
                  builder: (BuildContext context, Widget? child) {
                    return ScaleTransition(
                      scale: AlwaysStoppedAnimation<double>(
                          1.0 - (widget.iconAnimationController.value) * 0.2),
                      child: RotationTransition(
                        turns: AlwaysStoppedAnimation<double>(Tween<double>(
                            begin: 0.0, end: 24.0)
                            .animate(CurvedAnimation(
                            parent: widget.iconAnimationController,
                            curve: Curves.fastOutSlowIn))
                            .value /
                            360),
                        child: CircleAvatar(
                          backgroundImage: const AssetImage('assets/imagen/perfil.png'),
                          radius: 40,
                          backgroundColor: colorScheme.onPrimary,
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 4, right: 4),
                  child: isLoading // isLoading ahora será siempre false aquí
                      ? CircularProgressIndicator(
                    color: colorScheme.onPrimary,
                  )
                      : Text(
                    // Mostrar nombre completo o usar solo userName si es lo que TokenUtil tiene
                    "${estudianteNombre} ${estudianteApellido} ${estudianteApellidoU} (Usuario)",
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colorScheme.outlineVariant),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList?.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildDrawerItem(drawerList![index], colorScheme, textTheme);
              },
            ),
          ),
          Divider(height: 1, color: colorScheme.outlineVariant),
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  'Salir',
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.error,
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(
                  Icons.power_settings_new,
                  color: colorScheme.error,
                ),
                onTap: () {
                  _onLogoutTapped();
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ],
      ),
    );
  }

  void _onLogoutTapped() {
    // Aquí es donde ajustamos para el TokenUtil que has definido
    setState(() {
      TokenUtil.localx = true; // Indicar que no hay token o sesión activa
      TokenUtil.TOKEN = ""; // Limpiar el token
      TokenUtil.userName = ""; // Limpiar el nombre de usuario
      TokenUtil.role = ""; // Limpiar el rol
      // Reiniciar los datos mostrados en el drawer
      estudianteNombre = 'Invitado';
      estudianteApellido = '';
      estudianteApellidoU = '';
    });

    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) {
        return LoginPage();
      }),
          (Route<dynamic> route) => false,
    );
  }

  Widget _buildDrawerItem(DrawerList listData, ColorScheme colorScheme, TextTheme textTheme) {
    bool isSelected = widget.screenIndex == listData.index;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: colorScheme.primary.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          _navigationToScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: isSelected ? colorScheme.primary : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(28),
                        bottomRight: Radius.circular(28),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  listData.isAssetsImage
                      ? Container(
                    width: 24,
                    height: 24,
                    child: Image.asset(
                      listData.imageName,
                      color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                    ),
                  )
                      : Icon(
                    listData.icon?.icon,
                    color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  ),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Text(
                    listData.labelName,
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 16,
                      color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            isSelected
                ? AnimatedBuilder(
              animation: widget.iconAnimationController,
              builder: (BuildContext context, Widget? child) {
                return Transform(
                  transform: Matrix4.translationValues(
                      (MediaQuery.of(context).size.width * 0.75 - 64) *
                          (1.0 -
                              widget.iconAnimationController.value -
                              1.0),
                      0.0,
                      0.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75 - 64,
                      height: 46,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(28),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(28),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Future<void> _navigationToScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}