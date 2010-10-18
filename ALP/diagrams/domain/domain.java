/*
 * Schema model
 * UML User Guide p. 112
 */

/**
 * @opt attributes
 * @hidden
 */
class UMLOptions {}

class ОбщПотребител {
  String име;
  String парола;
}

/**
 * @navassoc * ръководи 0..1 Отдел
 * */
class Ръководител extends ОбщПотребител {
}

class Администратор extends ОбщПотребител {
}

/**
 * @navassoc 1 е-автор-на * Коментар
 * @navassoc * участва-в * Събитие
 * */
class Потребител extends ОбщПотребител {
  String личниДанни;
}

/**
 * @navassoc 1 принадлежи-на 1 Клиент
 * @navassoc 1 е-относно * Обект
 * @navassoc 1 е-по 1 ШаблонЗаДоговор
 * */
class Договор {
   String началнаДата;
   String срок;
}

class ШаблонЗаДоговор {
  String съдържание;
}


/**
 * @navassoc * има * Право
 * @has 1 има * Потребител
 * */
class Отдел {
  String име;
}

/**
 * @composed 1 има-прикачен * Файл
 * */
class Коментар {
  String съдържание;
  String заглавие;
}

class Файл {
  String име;
}

/**
 * @navassoc * се-води-към 1 Отдел
 * @navassoc * е-относно 0..1 Обект
 * @composed 1 има-прикачен * Файл
 * @navassoc * е-създаден-от 1 Потребител
 * @navassoc * се-притежава-от 0..1 Потребител
 * @navassoc 1 има * Коментар
 * */
class Тикет {
  String описание;
  String заглавие;
  Integer статус;
  Integer приоритет;
}

/**
 * потребител на с-мата
 * @has 1 има 1 КлиентскиСтатус
 * @has 1 има * Обект
 * */
class Клиент {
  String име;
  String телефон;
}


/**
 * @composed 1 съдържа * Събитие
 * @composed 1 съдържа * Бележка
 * */
class КлиентскиСтатус {
}
/**
 * @navassoc 1 е-от-даден 1 ВидСъбитие
 * */
class Събитие {
  Integer дата;
  String описание;
}

class ВидСъбитие {
  String име;
}

class Бележка {
  String съдържание;
}

class Право {
  Integer идентификатор;
}

/**
 * @navassoc 1 има-монтирано 1 Устройство
 * */
class Обект {
  String описание;
}

/**
 * @navassoc * има 1 ОписаниеНаУстройство
 * @navassoc 1 има 1 SIMКарта
 * @composed 1 има * Част
 * */
class Устройство {
 Integer сериенНомер;
}

/**
 * @composed 1 описва-наличието-на * Функция
 * */
class ОписаниеНаУстройство {
  String текстoвоОписание;
}

class SIMКарта {
  Integer номер;
}

/**
 * @navassoc 1 има * SIMКарта
 * */
class МобиленОператор {
  String име;
}

/**
 * @navassoc * има 1 ОписаниеНаЧаст
 * */
class Част {
  Integer сериенНомер;
}

class ОписаниеНаЧаст {
  String съдържание;
}

class Функция {
  String име;
}
