import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_de_tarefas/providers/task_provider.dart';

void main(){

  group('Task Provider',(){
    test('Test Task Provider', (){
      final provider = TasksProvider();
      final qtyItems = provider.countItens();
      expect(qtyItems, 3);
    });
  });
}