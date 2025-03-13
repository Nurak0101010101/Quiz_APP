import '../models/test_model.dart';

class TestProvider {
  static List<Test> getTests() {
    return [
      Test(
        title: "Математика",
        category: "Предметные",
        questions: [
          Question(
            questionText: "Чему равно 2 + 2?",
            options: ["3", "4", "5", "6"],
            correctAnswer: "4",
          ),
          Question(
            questionText: "Сколько градусов в прямом угле?",
            options: ["45", "90", "180", "360"],
            correctAnswer: "90",
          ),
        ],
      ),
      Test(
        title: "География",
        category: "Предметные",
        questions: [
          Question(
            questionText: "Какая столица Франции?",
            options: ["Лондон", "Берлин", "Париж", "Рим"],
            correctAnswer: "Париж",
          ),
        ],
      ),
      Test(
        title: "Общий кругозор",
        category: "Кругозор",
        questions: [
          Question(
            questionText: "Какой самый большой океан на Земле?",
            options: ["Атлантический", "Индийский", "Тихий", "Северный Ледовитый"],
            correctAnswer: "Тихий",
          ),
        ],
      ),
      Test(
        title: "IT",
        category: "Кругозор",
        questions: [
          Question(
            questionText: "Гениально?",
            options: ["да", "нет", "может быть", "аааааа"],
            correctAnswer: "нет",
          ),
        ],
      ),
    ];
  }
}
