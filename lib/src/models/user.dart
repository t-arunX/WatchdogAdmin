enum UserRole {
  admin,
  editor,
  viewer,
}

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.isActive = true,
  });

  String get roleName {
    switch (role) {
      case UserRole.admin:
        return 'Administrator';
      case UserRole.editor:
        return 'Editor';
      case UserRole.viewer:
        return 'Viewer';
    }
  }
}
