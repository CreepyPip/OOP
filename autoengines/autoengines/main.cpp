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
    
    double a = 31;
    double b = 13;
    
    
    ICE i1(4, 1, 30 , 1100, 5, 98);
    electric e1(1, 31 , 1900, 2, 102);
    hybrid h1("parallel");
    
    e1.refuel(b);
    i1.refuelFull();
    h1.setDisplacement(a);
    
    cout << i1.getLevelString() << endl;
    cout << e1.getLevelString() << endl << h1.getDisplacementString() << endl;
    cout << h1.getType() << endl;
}
