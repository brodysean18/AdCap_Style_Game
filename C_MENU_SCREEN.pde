void DrawMenuScreen() {  
    DrawMenuBackground();
    DrawUpgradesButton();
    DrawManagersButton();
    DrawInvestorsButton();
    DrawMenuButton();
}

void DrawMenuBackground() {
    rectMode(CORNER);
    noStroke();
    fill(0, 127);
    rect(0, 0, 500, 900);

    fill(0, 80);
    rect(110, 288, 300, 300, 35);

    fill(255);
    rect(100, 278, 300, 300, 35);
}

void DrawUpgradesButton() {
    int fill_1 = 0;
    int fill_2 = 0;
  
    if(CheckAvailableUpgrade()) {
        fill_1 = #1BC130;
        fill_2 = 255;
    }
    else {
        fill_1 = 120;
        fill_2 = 180;
    }
    
    rectMode(CENTER);
    fill(fill_1);
    rect(250, 340, 250, 75, 50);
    textAlign(CENTER);
    textSize(28);
    fill(fill_2);
    text("UPGRADES", 250, 350);
}

void DrawManagersButton() {
    int fill_1 = 0;
    int fill_2 = 0;
    
    if(CheckAvailableManager()) {
        fill_1 = #1BC130;
        fill_2 = 255;
    }
    else {
        fill_1 = 120;
        fill_2 = 180;
    }
    
    rectMode(CENTER);
    fill(fill_1);
    rect(250, 340 + 90, 250, 75, 50);
    textAlign(CENTER);
    textSize(28);
    fill(fill_2);
    text("MANAGERS", 250, 350 + 90);
}
void DrawInvestorsButton() {
    int fill_1 = 0;
    int fill_2 = 0;
    
    if(CheckAvailableInvestor()) {
        fill_1 = #1BC130;
        fill_2 = 255;
    }
    else {
        fill_1 = 120;
        fill_2 = 180;
    }
    
    rectMode(CENTER);
    fill(fill_1);
    rect(250, 340 + 180, 250, 75, 50);
    textAlign(CENTER);
    textSize(28);
    fill(fill_2);
    text("INVESTORS", 250, 350 + (90 * 2));
}

void ToggleMenu() {
    if(MENU_SCREEN == 1 || UPGRADE_SCREEN == 1 || MANAGER_SCREEN == 1 || ANGEL_SCREEN == 1) {
        MENU_SCREEN = 0;
        UPGRADE_SCREEN = 0;
        MANAGER_SCREEN = 0;
        ANGEL_SCREEN = 0;            
        MAIN_SCREEN = 1;
        menu_scroll_amount = 0;
    }
    else {
        MENU_SCREEN = 1;
    }
}

boolean CheckAvailableUpgrade() {
    boolean upgrade_available = false;
    for(int i = 0; i < NUM_UPGRADES; ++i) {
        if(p1.upgrades[i].upgrade == 0 && (p1.cash.exp > p1.upgrades[i].cost.exp || (p1.cash.exp == p1.upgrades[i].cost.exp && p1.cash.base >= p1.upgrades[i].cost.base))) {
            upgrade_available = true;
            break;
        }
    }
    return upgrade_available;
}

boolean CheckAvailableManager() {
    boolean manager_available = false;
    for(int i = 0; i < NUM_BUSINESSES; ++i) {
        if(p1.businesses[i].manager == 0 && (p1.cash.exp > p1.businesses[i].manager_cost.exp || (p1.cash.exp == p1.businesses[i].manager_cost.exp && p1.cash.base >= p1.businesses[i].manager_cost.base))) {
            manager_available = true;
            break;
        }
    }
    return manager_available;
}

boolean CheckAvailableInvestor() {
    return false;
}

void HandleMenuEvent() {
    buffer_time = System.nanoTime();
    if(mouseX >= 125 && mouseX <= 375 && mouseY >= 302.5 && mouseY <= 377.5) {
        UPGRADE_SCREEN = 1;
        MENU_SCREEN = 0;
    }
    else if(mouseX >= 125 && mouseX <= 375 && mouseY >= 302.5 + 90 && mouseY <= 377.5 + 90) {
        MANAGER_SCREEN = 1;
        MENU_SCREEN = 0;
    }
    else if(mouseX >= 125 && mouseX <= 375 && mouseY >= 302.5 + (90 * 2) && mouseY <= 377.5 + (90 * 2)) {
        ANGEL_SCREEN = 1;
        MENU_SCREEN = 0;
    }
}
