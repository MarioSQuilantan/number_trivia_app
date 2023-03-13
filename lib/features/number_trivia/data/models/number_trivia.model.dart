import '../../domain/entities/number_trivia.entity.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required super.text,
    required super.number,
  });

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) => NumberTriviaModel(
        text: json["text"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "number": number,
      };

  NumberTrivia toEntity() => NumberTrivia(
        text: text,
        number: number,
      );
}
