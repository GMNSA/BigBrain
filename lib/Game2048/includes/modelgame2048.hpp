/* modelgame2048.hpp */

#ifndef MODELGAME2048_HPP
#define MODELGAME2048_HPP

#include <QAbstractListModel>
#include <QDebug>

enum class eMove
{
  MOVE_UP = 0,
  MOVE_DOWN,
  MOVE_RIGHT,
  MOVE_LEFT
};

constexpr int
numPredicat(bool rightAndLeft)
{
  return rightAndLeft ? 1 : 4;
}

static constexpr qintptr
ct_sqrt(qintptr res, qintptr l, qintptr r)
{
  if (l == r) {
    return r;
  } else {
    const auto mid = (r + l) / 2;

    if (mid * mid >= res) {
      return ct_sqrt(res, l, mid);
    } else {
      return ct_sqrt(res, mid + 1, r);
    }
  }
}

static constexpr qintptr
ct_sqrt(qintptr res)
{
  return ct_sqrt(res, 1, res);
}

constexpr int const SIZE_DATA{ 16 };
constexpr int const DEPTH_DATA{ ct_sqrt(SIZE_DATA) };

// -----------------------------------------------------------------------------------------------

class ModelGame2048 : public QAbstractListModel
{
  Q_OBJECT
public:
  ModelGame2048(QObject* parent = nullptr);
  virtual ~ModelGame2048();
  Q_DISABLE_COPY_MOVE(ModelGame2048);

  // QAbstractItemModel interface
  virtual int rowCount(const QModelIndex& parent) const override;
  virtual QVariant data(const QModelIndex& index, int role) const override;

  Q_INVOKABLE bool moveUp();
  Q_INVOKABLE bool moveDown();
  Q_INVOKABLE bool moveRight();
  Q_INVOKABLE bool moveLeft();
  Q_INVOKABLE bool addNum()
  {
    qDebug("New number");
    newNumber();
    return (true);
  }
  Q_INVOKABLE bool restart();

  // QObject interface
protected:
  virtual void timerEvent(QTimerEvent* event) override;

private:
  QVector<qintptr> m_data;
  bool m_isNewNum;
  bool m_isStep;
  bool m_isLock;
  bool m_nMove;
  qintptr m_score;
  qintptr m_highScore;

#ifdef FOR_TEST
public:
#else
private:
#endif
  qintptr randomNumber(qintptr begin_, qintptr end_);
  void startGame();

  qintptr row(qintptr num_) const;
  qintptr col(qintptr num_) const;

  bool isCheckEndGame();
  bool isNumber(qintptr num_);
  bool isZero(qintptr num_);
  void reloadData(qintptr from_, qintptr to_);
  void newNumber();

  bool loopUp(int i_, bool isChange);
  bool loopDown(int i_, bool isChange);
  bool loopRight(int i_, bool isChange);
  bool loopLeft(int i_, bool isChange);
  void loopMove(int i_, eMove pointer_);

  void update();
};
#endif // MODELGAME2048_HPP
