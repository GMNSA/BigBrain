/* testgame2048.hpp */

#ifndef TESTGAME2048_HPP
#define TESTGAME2048_HPP

#include <QtTest>

#include "modelgame2048.hpp"

class TestGame2048 : public QObject
{
  Q_OBJECT

public:
  TestGame2048();
  ~TestGame2048();

private slots:
  void test_randomNumber();
  void test_rowAndCol();
  void test_moveUp();

private:
  ModelGame2048 m_model2048;
};

#endif // TESTGAME2048_HPP
