//사용자가 편집하길 원하는 모든 데이터를 가지고 있어야 함.
// 뷰가 필요한 데이터를 모델에 담아야 함.
class ExistedItemModel extends Object {
  final int id; //물품 id
  final String name; //물품명
  late int count;
  late int bundle; //개수
  final int isNeeded; //필요물품인지, 구비물품인지 구분하는 변수
  final int isExpendables; // 소모품인지 비품인지 구분하는 변수
  final String sort; //물품의 종류(식품, 생필품, 공구 등)
  final String broadLocation; //넓은 범위 위치(의료과학관)
  final String narrowLocation; // 좁은 범위 위치(1521호)
  final String detailLocation; // 디테일한 위치(누구 책상 위)
  final note; //비고
  late int isUsing; //사용 중인지 아닌지 상태를 구분하는 변수
  final countPerSet = 10;

  ExistedItemModel({
    required this.id,
    required this.name,
    required this.count,
    this.bundle = 1,
    this.isNeeded = 0,
    this.isExpendables = 1,
    this.sort = '기타',
    this.broadLocation = '불명', //
    this.narrowLocation = '불명', //
    this.detailLocation = '불명', //
    this.note = '없음',
    this.isUsing = 0, //
  });

  //toMap()은 Spec을 map 타입으로 변환주는 함수
  // DB에 실제로 insert할 땐 map 타입이어야 함.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'count': count,
      'sort': sort,
      'bundle': bundle,
      'isNeeded': isNeeded,
      'isExpendables': isExpendables,
      'broadLocation': broadLocation,
      'narrowLocation': narrowLocation,
      'detailLocation': detailLocation,
      'note': note,
      'isUsing': isUsing,
    };
  }
}
