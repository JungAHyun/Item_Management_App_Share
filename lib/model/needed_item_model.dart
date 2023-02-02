//사용자가 편집하길 원하는 모든 데이터를 가지고 있어야 함.
// 뷰가 필요한 데이터를 모델에 담아야 함.
class NeededItemModel extends Object {
  final int id; //물품 id
  final String name; //물품명
  final int count; //개수
  final int bundle; //세트
  final int price; //가격
  final int isNeeded; //필요물품인지, 구비물품인지 구분하는 변수
  final int isExpendables; // 소모품인지 비품인지 구분하는 변수
  final String reason; //필요이유
  final String sort; //물품의 종류(식품, 생필품, 공구 등)

  NeededItemModel({
    required this.id,
    required this.name,
    required this.count,
    required this.price, //
    this.bundle = 1,
    this.isExpendables = 1,
    this.isNeeded = 1,
    this.reason = '필요함', //
    this.sort = '기타',
  });

  //toMap()은 Spec을 map 타입으로 변환주는 함수
  // DB에 실제로 insert할 땐 map 타입이어야 함.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'count': count,
      'bundle': bundle,
      'price': price,
      'isExpendables': isExpendables,
      'isNeeded': isNeeded,
      'reason': reason,
      'sort': sort,
    };
  }

  @override
  String toString() {
    return 'Memo{id: $id, title: $name, text: $count, createTime: $price, editTime: $isExpendables}';
  }
}
