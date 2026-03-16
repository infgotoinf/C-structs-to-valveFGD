#ifndef EXAMPLE_H
#define EXAMPLE_H

// Example class
struct Example {
  int hp;
  void spawn();
  // Substracts damage from hp
  void takeDamage(int damage);
};

struct Example2 {
  int ammount;
  Example2();
  // Returns true if ammount is even
  bool isEven();
};

#endif //EXAMPLE_H
