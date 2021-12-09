/* testgame2048.cpp */

#include "testgame2048.hpp"
#include <QDebug>

TestGame2048::TestGame2048()
{
  // ctor
}

TestGame2048::~TestGame2048()
{
  // dtor
}

void
TestGame2048::test_randomNumber()
{
  auto res = m_model2048.randomNumber(1, 10);
  QVERIFY(res >= 0 && res <= 10);

  res = m_model2048.randomNumber(5, 8);
  QVERIFY(res >= 5 && res <= 8);

  res = m_model2048.randomNumber(51, 62);
  QVERIFY(res >= 51 && res <= 62);

  res = m_model2048.randomNumber(1, 1);
  QVERIFY(res == 1);
}

//  0  1  2  3
//  4  5  6  7
//  8  9  10 11
//  12 13 14 15

// 0  1  2  3  4  5  6  7  8  9  10  11  12  13  14  15

void
TestGame2048::test_rowAndCol()
{
  int num{ 4 };
  auto row = m_model2048.row(num);
  auto col = m_model2048.col(num);

  qDebug() << "row: " << row;
  qDebug() << "col: " << col;
  qDebug() << "num: " << num;
  QVERIFY(row == 1 && col == 0);

  num = 9;
  row = m_model2048.row(num);
  col = m_model2048.col(num);

  qDebug() << "row: " << row;
  qDebug() << "col: " << col;
  qDebug() << "num: " << num;
  QVERIFY(row == 2 && col == 1);

  num = 7;
  row = m_model2048.row(num);
  col = m_model2048.col(num);

  qDebug() << "row: " << row;
  qDebug() << "col: " << col;
  qDebug() << "num: " << num;
  QVERIFY(row == 1 && col == 3);

  num = 11;
  row = m_model2048.row(num);
  col = m_model2048.col(num);

  qDebug() << "row: " << row;
  qDebug() << "col: " << col;
  qDebug() << "num: " << num;
  QVERIFY(row == 2 && col == 3);
}

void
TestGame2048::test_moveUp()
{}

QTEST_APPLESS_MAIN(TestGame2048)
