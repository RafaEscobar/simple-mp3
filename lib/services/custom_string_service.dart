
class CustomStringService {
  static String cropTitle({required String data, required int length}){
    if (data.length<length) return data;
    return "${data.substring(0, length)}...";
  }
}