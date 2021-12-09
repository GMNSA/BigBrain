/* modelgame2048.cpp */

#include "modelgame2048.hpp"
#include "datatype2048.hpp"
#include <QDebug>
#include <QTimerEvent>
#include <random>

ModelGame2048::ModelGame2048(QObject* parent)
  : QAbstractListModel(parent)
  , m_isNewNum(false)
  , m_isStep(false)
  , m_isLock(false)
  , m_nMove(0)
  , m_score(0)
  , m_highScore(0)
{
  m_data.resize(SIZE_DATA);

  restart();

  startTimer(1000 / 60);
}

ModelGame2048::~ModelGame2048()
{
  // dtor
}

int
ModelGame2048::rowCount(const QModelIndex& parent) const
{
  Q_UNUSED(parent);

  return (m_data.size());
}

QVariant
ModelGame2048::data(const QModelIndex& index, int role) const
{
  if (!index.isValid() || role != Qt::DisplayRole ||
      index.row() > m_data.size())
    return {};

  return (QVariant::fromValue(m_data.at(index.row())));
}

qintptr
ModelGame2048::randomNumber(qintptr begin_, qintptr end_)
{
  std::uniform_int_distribution<qintptr> distribution(begin_, end_);
  std::random_device rd;
  std::default_random_engine random(rd());

  return distribution(random);
}

void
ModelGame2048::startGame()
{
  m_data.clear();
  m_data.resize(SIZE_DATA);

  qintptr num = randomNumber(0, SIZE_DATA - 1);
  m_data[num] = (int)eGameType2048::TYPE_2;
  qintptr num2{ 0 };

  do {
    num2 = randomNumber(0, SIZE_DATA - 1);
    if (num2 != num)
      m_data[num2] = (int)eGameType2048::TYPE_2;
  } while (num2 == num);
}

qintptr
ModelGame2048::row(qintptr num_) const
{
  return (num_ / DEPTH_DATA);
}

qintptr
ModelGame2048::col(qintptr num_) const
{
  return (num_ % DEPTH_DATA);
}

bool
ModelGame2048::moveUp()
{
  qDebug("MOVE UP CPP");

  if (m_isLock)
    return (false);

  bool isChange{ false };

  m_isNewNum = loopUp(SIZE_DATA, isChange);

  return (true);
}

bool
ModelGame2048::moveDown()
{
  qDebug("MOVE DOWN CPP");
  if (m_isLock)
    return (false);

  bool isChange{ false };

  m_isNewNum = loopDown(SIZE_DATA, isChange);

  if (isChange)
    m_isStep = true;

  return (true);
}

bool
ModelGame2048::moveRight()
{
  qDebug("MOVE RIGHT");
  if (m_isLock)
    return (false);

  bool isChange{ false };

  m_isNewNum = loopRight(SIZE_DATA, isChange);

  if (isChange)
    m_isStep = true;

  return (true);
}

bool
ModelGame2048::moveLeft()
{
  qDebug("MOVE LEFT");
  if (m_isLock)
    return (false);

  bool isChange{ false };

  m_isNewNum = loopLeft(SIZE_DATA, isChange);

  if (isChange)
    m_isStep = true;

  return (true);
}

bool
ModelGame2048::restart()
{
  beginResetModel();

  m_data.clear();
  m_score = 0;
  startGame();

  endResetModel();
  return (true);
}

void
ModelGame2048::timerEvent(QTimerEvent* event)
{
  Q_UNUSED(event);
  update();
}

bool
ModelGame2048::isCheckEndGame()
{
  bool lock{ true };
  for (auto i : m_data)
    if (isZero(i))
      lock = false;

  return lock;
}

bool

ModelGame2048::isNumber(qintptr num_)
{
  return (num_ != 0);
}

bool
ModelGame2048::isZero(qintptr num_)
{
  return (num_ == 0);
}

void
ModelGame2048::reloadData(qintptr from_, qintptr to_)
{
  if (m_isLock)
    return;

  beginMoveRows(QModelIndex(), from_, from_, QModelIndex(), to_);
  std::swap(m_data[from_], m_data[to_]);
  endResetModel();
}

void
ModelGame2048::newNumber()
{
  if (m_isLock)
    return;

  qintptr num{ 0 };

  bool isTwo = randomNumber(0, 1);

  while (true) {
    num = randomNumber(0, SIZE_DATA - 1);
    if (isZero(m_data[num])) {
      m_data[num] = (isTwo == true ? (qintptr)eGameType2048::TYPE_2
                                   : (qintptr)eGameType2048::TYPE_4);
      reloadData(num, num);
      return;
    }
  };
}

bool
ModelGame2048::loopUp(int i_, bool isChange_)
{
  int step{ 4 };
  if (i_ < 0)
    return isChange_;

  for (qintptr i{ 1 }; i < SIZE_DATA; ++i) {
    if (row(i) <= (DEPTH_DATA) && row(i) > 0 && isNumber(m_data.at(i))) {

      if (m_data[i] == m_data[i - step]) {
        qDebug("+");
        m_data[i - step] = 0;
        m_data[i] = m_data[i] * 2;
        reloadData(i, i - step);
        isChange_ = true;
      }
      if (isZero(m_data[i - step])) {
        qDebug(">");
        reloadData(i, i - step);
        isChange_ = true;
      }
    }
  }

  return loopUp(--i_, isChange_);
}

bool
ModelGame2048::loopDown(int i_, bool isChange_)
{
  int step{ 4 };

  if (i_ < 0)
    return isChange_;

  for (qintptr i{ SIZE_DATA - 1 }; i >= 0; --i) {
    if (row(i) < (DEPTH_DATA - 1) && row(i) >= 0 && isNumber(m_data.at(i))) {

      if (m_data[i] == m_data[i + step]) {
        qDebug("+");
        m_data[i + step] = 0;
        m_data[i] = m_data[i] * 2;
        reloadData(i, i + step);
        isChange_ = true;
      }
      if (isZero(m_data[i + step])) {
        qDebug(">");
        reloadData(i, i + step);
        isChange_ = true;
      }
    }
  }

  return loopDown(--i_, isChange_);
}

bool
ModelGame2048::loopRight(int i_, bool isChange_)
{
  int step{ 1 };

  if (i_ < 0)
    return isChange_;

  for (qintptr i{ SIZE_DATA - 1 }; i >= 0; --i) {
    if (col(i) < (DEPTH_DATA - 1) && col(i) >= 0 && isNumber(m_data.at(i))) {

      if (m_data[i] == m_data[i + step]) {
        m_data[i + step] = 0;
        m_data[i] = m_data[i] * 2;
        reloadData(i, i + step);
        isChange_ = true;
      }
      if (isZero(m_data[i + step])) {
        reloadData(i, i + step);
        isChange_ = true;
      }
    }
  }

  return loopRight(--i_, isChange_);
}

bool
ModelGame2048::loopLeft(int i_, bool isChange_)
{
  int step{ 1 };

  if (i_ < 0)
    return isChange_;

  for (qintptr i{ 1 }; i < SIZE_DATA; ++i) {
    if (col(i) <= (DEPTH_DATA) && col(i) > 0 && isNumber(m_data.at(i))) {

      if (m_data[i] == m_data[i - step]) {
        m_data[i - step] = 0;
        m_data[i] = m_data[i] * 2;
        reloadData(i, i - step);
        isChange_ = true;
      }
      if (isZero(m_data[i - step])) {
        qDebug(">");
        reloadData(i, i - step);
        isChange_ = true;
      }
    }
  }

  return loopLeft(--i_, isChange_);
}

void
ModelGame2048::loopMove(int i_, eMove pointer_)
{
  if (i_ < 0)
    return;

  auto stateLeft = [&](int i) {
    return (col(i) <= (DEPTH_DATA) && col(i) > 0 && isNumber(m_data.at(i)));
  };
  auto stateRight = [&](int i) {
    return (col(i) < (DEPTH_DATA - 1) && col(i) >= 0 && isNumber(m_data.at(i)));
  };

  auto stateUp = [&](int i) {
    return (row(i) <= (DEPTH_DATA) && row(i) > 0 && isNumber(m_data.at(i)));
  };

  auto stateDown = [&](int i) {
    return (row(i) < (DEPTH_DATA - 1) && row(i) >= 0 && isNumber(m_data.at(i)));
  };

  int step{ 0 };

  switch (pointer_) {
    case eMove::MOVE_DOWN:
      step = DEPTH_DATA;
      break;
    case eMove::MOVE_LEFT:
      step = 1;
      break;
    case eMove::MOVE_RIGHT:
      step = 1;
      break;
    case eMove::MOVE_UP:
      step = DEPTH_DATA;
      break;
    default:
      return;
  }

  if (pointer_ == eMove::MOVE_LEFT || pointer_ == eMove::MOVE_UP) {
    for (qintptr i{ 1 }; i < SIZE_DATA; ++i) {
      if ((pointer_ == eMove::MOVE_LEFT) ? (stateLeft(i)) : (stateUp(i))) {
        if (m_data[i] == m_data[i - step]) {
          m_data[i - step] = 0;
          m_data[i] = m_data[i] * 2;
          reloadData(i, i - step);
        }
        if (isZero(m_data[i - step])) {
          reloadData(i, i - step);
        }
      }
    }
  } else {
    // Right or Down
    for (qintptr i{ SIZE_DATA - 1 }; i >= 0; --i) {
      if ((pointer_ == eMove::MOVE_RIGHT) ? (stateRight(i)) : (stateDown(i))) {
        if (m_data[i] == m_data[i + step]) {
          m_data[i + step] = 0;
          m_data[i] = m_data[i] * 2;
          reloadData(i, i + step);
        }
        if (isZero(m_data[i + step])) {
          reloadData(i, i + step);
        }
      }
    }
  }

  return loopMove(--i_, pointer_);
}

void
ModelGame2048::update()
{
  if (m_isNewNum) {
    newNumber();
    m_isNewNum = false;
  }

  if (m_isStep) {
    // reloadData();
    qDebug("RELOAD");
    m_isStep = false;
  }

  if (isCheckEndGame()) {
    m_isLock = true;
    qDebug("LOCK");
  } else
    m_isLock = false;
}
