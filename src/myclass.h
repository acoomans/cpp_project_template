#ifndef MYCLASS_H
#define MYCLASS_H

#include <iostream>
#include <initializer_list>


template <typename T>
class Myclass {

protected:
    int s;
    T *elements;

public:
    using value_type = T;

    Myclass(int size) : s {size}, elements {new T[s]} {};

    Myclass(std::initializer_list<T> list) :
            s {static_cast<T>(list.size())},
            elements {new T[s]}
    { std::copy(list.begin(), list.end(), elements); };

    ~Myclass() { delete [] elements; };

    // copy constructor
    Myclass(const Myclass& m) : s {m.s} {
        for (int i = 0; i < m.s; i++) {
            elements[i] = m.elements[i];
        }
    };

    // copy assignment
    Myclass& operator=(const Myclass& m) {

        // copy as new
        int *new_elements = new int[m.s];
        for (int i = 0; i < m.s; i++) {
            new_elements[i] = m.elements[i];
        }

        // delete old
        delete [] elements;

        // assign
        this->s = m.s;
        this->elements = new_elements;

        return *this;
    }

    // move constructor
    Myclass(Myclass&& m) : s {m.s}, elements {m.elements} {
        m.s = 0;
        m.elements = nullptr;
    };

    // move assignment
    Myclass& operator=(Myclass&& m) {
        this->s = m.s;
        this->elements = m.elements;

        m.s = 0;
        m.elements = nullptr;

        return *this;
    };

    // read subscripting
    const T& operator[](int idx) const { return elements[idx]; };

    // write subscripting
    T& operator[](int idx) { return elements[idx]; };

    // for-loop
    T* begin(Myclass<T>& t) {
        return t.size() ? &t[0] : nullptr;
    };

    T* end(Myclass<T>& t) {
        return begin(t) + t.size();
    };

    int size() { return s; };
};

template <typename T>
std::ostream& operator<<(std::ostream &os, Myclass<T>& m) {
    return os << "M(" << m.size() << ")";
}

#endif // MYCLASS_H