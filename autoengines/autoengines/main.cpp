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
    double b = 66;
    
    
    ICE i1(4, 1, 30 , 1100, 5, 98);
    electric e1(89, 1, 31, 1900, 2, 102);
    hybrid h1("parallel");
    
    h1.setDisplacement(a);
    e1.setDisplacement(54);
    h1.setWear(77);
    e1.refuel(b);
    i1.refuelFull();
    
    
    cout << i1.getLevelString() << endl;
    cout << e1.getLevelString() << endl << h1.getDisplacementString() << endl;
    cout << h1.getType() << endl << e1.getDisplacementString() << endl;
}
