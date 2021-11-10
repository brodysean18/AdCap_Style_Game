void DrawManagerScreen() {
    rectMode(CORNER);
    noStroke();
    fill(0, 127);
    rect(0, 0, 500, 900);
  
    rectMode(CORNER);
    noStroke();
    fill(0, 80);
    rect(60, 110, 400, 650, 35);
    fill(255);
    rect(50, 100, 400, 650, 35);
    rectMode(CENTER);
    fill(255);
    strokeWeight(2);
    noStroke();
    
    DrawManagerButtons();
    
    rectMode(CENTER);
    noStroke();
    fill(255);
    rect(250, 160, 300, 60);    
    rect(250, 720, 300, 60);   
    
    stroke(0);
    strokeWeight(1);
    line(50, 190, 450, 190);
    line(50, 690, 450, 690);
    
    textAlign(CENTER);
    textSize(40);
    fill(0);
    text("MANAGERS", 250, 160);
    
    image(back_arrow, 80, 130, 100.7 / 2.5, 89.1 / 2.5);
    
    DrawMenuButton();
}

void DrawManagerButtons() {
    int offset = 0;
    int fill_1 = 0;
    int fill_2 = 0;
  
    for(int i = 0; i < p1.managers_remaining; ++i) {
        while(p1.businesses[i + offset].manager == 1) { offset += 1; }
        if((i * 100) + 230 + menu_scroll_amount <= 720 && (i * 100) + 230 + menu_scroll_amount >= 160) {
          
            if(p1.cash.exp > p1.businesses[i + offset].manager_cost.exp || (p1.cash.exp == p1.businesses[i + offset].manager_cost.exp && p1.cash.base >= p1.businesses[i + offset].manager_cost.base)) {
                fill_1 = #1BC130;
                fill_2 = 255;
            }
            else {
                fill_1 = 50;
                fill_2 = 85;
            }
          
            fill(fill_1);
            rectMode(CENTER);
            stroke(2);
            rect(250, ((i * 100) + 230 + menu_scroll_amount), 250, 50, 7);
            textAlign(CENTER);
            fill(fill_2);
            textSize(24);
            
            Value dummy = p1.businesses[i + offset].manager_cost.Format();
            dummy.Print("Manager " + (i + 1 + offset) + ": $", 250, (i * 100) + 240 + menu_scroll_amount);
            
            //text("Manager " + (i + 1 + offset) + ":", 200, (i * 100) + 240 + menu_scroll_amount);
            //text("$" + p1.businesses[i + offset].manager_cost.base * Math.pow(10, p1.businesses[i + offset].manager_cost.exp), 295, (i * 100) + 240 + menu_scroll_amount);
        }
    }
    noStroke();
}

void HandleManagerScreenEvent() {
    int offset = 0;
    if(mouseX >= 80 && mouseX <= 120 && mouseY >= 130 && mouseY <= 165.5) {
        MANAGER_SCREEN = 0;
        MENU_SCREEN = 1;
        menu_scroll_amount = 0;
    }
    for(int i = 0; i < p1.managers_remaining; ++i) {
        while(p1.businesses[i + offset].manager == 1) { offset += 1; }
        if(mouseX >= 125                                && 
           mouseX <= 375                                && 
           mouseY >= (i * 100) + 205 + menu_scroll_amount    && 
           mouseY <= (i * 100) + 255 + menu_scroll_amount    && 
           mouseY >= 160                                && 
           mouseY <= 720                                &&
           System.nanoTime() - buffer_time > 500000000) {
              if(p1.cash.base * Math.pow(10, p1.cash.exp)                                              >=
                 p1.businesses[i + offset].manager_cost.base * Math.pow(10, p1.businesses[i + offset].manager_cost.exp)) {
                    p1.PurchaseManager(i + offset);
              }
        }
    }
}
