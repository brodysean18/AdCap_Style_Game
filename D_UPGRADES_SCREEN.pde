void DrawUpgradeScreen() {
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
    
    DrawUpgradeButtons();
    
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
    text("UPGRADES", 250, 160);
    
    image(back_arrow, 80, 130, 100.7 / 2.5, 89.1 / 2.5);
    
    DrawMenuButton();
}

void DrawUpgradeButtons() {
    int offset = 0;
    int fill_1 = 0;
    int fill_2 = 0;
    for(int i = 0; i < p1.upgrades_remaining; ++i) {
        while(p1.upgrades[i + offset].upgrade == 1) { offset += 1; }
        if((i * 100) + 230 + menu_scroll_amount <= 720 && (i * 100) + 230 + menu_scroll_amount >= 160) {
          
            if(p1.cash.exp > p1.upgrades[i + offset].cost.exp ||
              (p1.cash.exp == p1.upgrades[i + offset].cost.exp &&
               p1.cash.base >= p1.upgrades[i + offset].cost.base)) {
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
            textSize(16);
            
            p1.upgrades[i + offset].PrintInfo(250, (i * 100) + 227 + menu_scroll_amount);
        }
    }
}

void PurchaseUpgrade(int i) {
    if(p1.upgrades[i].upgrade == 0 &&
       p1.cash.exp > p1.upgrades[i].cost.exp ||
      (p1.cash.exp == p1.upgrades[i].cost.exp &&
       p1.cash.base >= p1.upgrades[i].cost.base)) {
        p1.upgrades[i].ApplyUpgrade(p1);
    }
}

void HandleUpgradeScreenEvent() {
    int offset = 0;
    if(mouseX >= 80 && mouseX <= 120 && mouseY >= 130 && mouseY <= 165.5) {
        UPGRADE_SCREEN = 0;
        MENU_SCREEN = 1;
        menu_scroll_amount = 0;
    }
    for(int i = 0; i < p1.upgrades_remaining; ++i) {
        while(p1.upgrades[i + offset].upgrade == 1) { offset += 1; }
        if(mouseX >= 125                                && 
           mouseX <= 375                                && 
           mouseY >= (i * 100) + 205 + menu_scroll_amount    && 
           mouseY <= (i * 100) + 255 + menu_scroll_amount    && 
           mouseY >= 160                                && 
           mouseY <= 720                                &&
           System.nanoTime() - buffer_time > 500000000) {
              PurchaseUpgrade(i + offset);
        }
    }
}
