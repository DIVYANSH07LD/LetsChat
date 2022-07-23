import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/feature/selectContact/repository/select_contactRepository.dart';

final getContactProvider = FutureProvider((ref) {
final selectContactRepository= ref.watch(selectContactRepositoryProvider);
return selectContactRepository;
});