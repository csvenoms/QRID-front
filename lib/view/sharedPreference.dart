import 'package:shared_preferences/shared_preferences.dart';
class AuthTokenSave{
  
static Future<void> saveAuthenticationData(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

static Future<String?> getFullName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('fullname');
}
static Future<String?> getId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('id');
}
static Future<String?> getbatch() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('batch');
}
static Future<String?> getDept() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('dept');
}
static Future<String?> getAuthenticationToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
static Future<void> saveBatch(String batch) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('batch', batch);
}
static Future<void> saveId(String id) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', id);
}
static Future<void> saveDepartment(String dept) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('dept', dept);
}
static Future<void> saveFullName(String fullname) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('fullname', fullname);
}
static Future<void> clearAuthenticationData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('id');
  await prefs.remove('dept');
  await prefs.remove('batch');
  await prefs.remove('fullname');
}
}