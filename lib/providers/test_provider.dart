import '../models/test_model.dart';
import '../models/question_model.dart';

class TestProvider {
  static List<Test> getTests() {
    return [
      Test(
    title: "Математика",
    category: "Предметные",
    questions: [
      Question(
        text: "Чему равно 2 + 2?",
        answers: ["3", "4", "5", "6"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "Корень из 16 равен?",
        answers: ["2", "3", "4", "5"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Чему равно 10 / 2?",
        answers: ["3", "4", "5", "6"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Чему равно 5 * 5?",
        answers: ["20", "25", "30", "35"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "Сколько градусов в прямом угле?",
        answers: ["45", "60", "90", "180"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Чему равна сумма углов треугольника?",
        answers: ["90", "120", "180", "360"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Чему равно 3^2?",
        answers: ["6", "8", "9", "12"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Чему равно 7 + 3 * 2?",
        answers: ["20", "17", "13", "10"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Чему равен логарифм 100 по основанию 10?",
        answers: ["1", "2", "10", "100"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "Чему равно 0 в степени 0?",
        answers: ["1", "0", "Бесконечность", "Не определено"],
        correctAnswerIndex: 3,
      ),
    ],
  ),
  Test(
    title: "Биология",
    category: "Предметные",
    questions: [
      Question(
        text: "Какая молекула является носителем генетической информации?",
        answers: ["Белок", "РНК", "ДНК", "Липиды"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Какой орган отвечает за фильтрацию крови?",
        answers: ["Легкие", "Сердце", "Почки", "Печень"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Сколько хромосом у человека?",
        answers: ["23", "32", "44", "46"],
        correctAnswerIndex: 3,
      ),
      Question(
        text: "Как называется наука о растениях?",
        answers: ["Зоология", "Ботаника", "Экология", "Генетика"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "Как называется основной пигмент в хлоропластах?",
        answers: ["Гемоглобин", "Хлорофилл", "Кератин", "Меланин"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "Как называется процесс деления клетки?",
        answers: ["Мейоз", "Митоз", "Фагоцитоз", "Осмос"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "Какой витамин необходим для свертывания крови?",
        answers: ["A", "B", "K", "D"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Где в клетке хранится наследственная информация?",
        answers: ["Рибосомы", "Митохондрии", "Ядро", "Цитоплазма"],
        correctAnswerIndex: 2,
      ),
      Question(
        text: "Как называется наука о животных?",
        answers: ["Ботаника", "Зоология", "Генетика", "Экология"],
        correctAnswerIndex: 1,
      ),
      Question(
        text: "Какой орган регулирует работу всего организма?",
        answers: ["Сердце", "Печень", "Мозг", "Легкие"],
        correctAnswerIndex: 2,
      ),
    ],
  ),

  // Тесты по химии, географии, физике
  Test(
    title: "Химия",
    category: "Предметные",
    questions: [
      Question(text: "Какой элемент обозначается как 'O'?", answers: ["Кислород", "Водород", "Углерод", "Азот"], correctAnswerIndex: 0),
      Question(text: "Формула воды?", answers: ["H2O", "CO2", "O2", "CH4"], correctAnswerIndex: 0),
      Question(text: "Какая кислота содержится в лимоне?", answers: ["Азотная", "Серная", "Лимонная", "Соляная"], correctAnswerIndex: 2),
      Question(text: "Какой газ выделяют растения?", answers: ["Кислород", "Углекислый газ", "Азот", "Водород"], correctAnswerIndex: 0),
      Question(text: "Какой металл жидкий при комнатной температуре?", answers: ["Железо", "Медь", "Ртуть", "Алюминий"], correctAnswerIndex: 2),
    ],
  ),

  Test(
    title: "География",
    category: "Предметные",
    questions: [
      Question(text: "Какой океан самый большой?", answers: ["Атлантический", "Тихий", "Индийский", "Северный Ледовитый"], correctAnswerIndex: 1),
      Question(text: "Столица Канады?", answers: ["Торонто", "Оттава", "Монреаль", "Ванкувер"], correctAnswerIndex: 1),
      Question(text: "Как называется самая длинная река?", answers: ["Амазонка", "Нил", "Волга", "Янцзы"], correctAnswerIndex: 1),
    ],
  ),

  Test(
    title: "Физика",
    category: "Предметные",
    questions: [
      Question(text: "Какова скорость света в вакууме?", answers: ["300 000 км/с", "150 000 км/с", "450 000 км/с", "600 000 км/с"], correctAnswerIndex: 0),
      Question(text: "Как называется закон 'действие равно противодействию'?", answers: ["Закон Ома", "Второй закон Ньютона", "Третий закон Ньютона", "Закон Архимеда"], correctAnswerIndex: 2),
    ],
  ),

  // 5 тестов на кругозор
  Test(title: "Космос", category: "Кругозор", questions: [Question(text: "Первая планета от Солнца?", answers: ["Земля", "Марс", "Меркурий", "Юпитер"], correctAnswerIndex: 2)]),
  Test(title: "История", category: "Кругозор", questions: [Question(text: "В каком году началась Вторая мировая война?", answers: ["1914", "1939", "1945", "1812"], correctAnswerIndex: 1)]),
  Test(title: "Искусство", category: "Кругозор", questions: [Question(text: "Какой художник отрезал себе ухо?", answers: ["Пикассо", "Да Винчи", "Ван Гог", "Моне"], correctAnswerIndex: 2)]),
  Test(title: "Музыка", category: "Кругозор", questions: [Question(text: "Как зовут композитора 'Лунной сонаты'?", answers: ["Бетховен", "Моцарт", "Бах", "Шопен"], correctAnswerIndex: 0)]),
  Test(title: "Литература", category: "Кругозор", questions: [Question(text: "Автор 'Преступления и наказания'?", answers: ["Толстой", "Достоевский", "Пушкин", "Чехов"], correctAnswerIndex: 1)]),
];
  
  }
}
