#ifndef EXAMPLE_H
#define EXAMPLE_H

// Example class
struct Example {
    const char* name;
    int hp; // Character's health
    void spawn();
    // Substracts damage from hp
    void takeDamage(int damage);
};

struct Example2 {
    int ammount = 0; // Ammount of stuff
    Example2();
    // Returns true if ammount is even
    bool isEven();
};

#endif //EXAMPLE_H
