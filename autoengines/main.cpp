//
//  main.cpp
//  autoengines
//
//  Created by Семён on 21.02.2026.
//  Copyright © 2026 Семён. All rights reserved.
//

#include <iostream>
#include "autoengines.h"

using namespace std;

int main() {
    
    double a = 0;
    
    engines e1(0, 0, 0, 0, 0);
    
    e1.setHP(a);
    
    cout << e1.getHP() << endl;
}
