abstract class DialogService {
  Future<void> showError(String message);
  Future<void> showInfo(String message);
  Future<bool> showConfirmation(String message);
  // Thêm các phương thức khác nếu cần
}
