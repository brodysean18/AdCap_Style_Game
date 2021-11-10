void PrintMouse() {
    System.out.println("X: " + mouseX + ", Y: " + mouseY);
}

void DrawMenuButton() {
    if(MENU_SCREEN == 1 || UPGRADE_SCREEN == 1 || MANAGER_SCREEN == 1 || ANGEL_SCREEN == 1) {
        stroke(255);
        strokeWeight(4);
        line(235, 845, 265, 875);
        line(235, 875, 265, 845);
        strokeWeight(1);
        noStroke();
    }
    else {
        stroke(255);
        strokeWeight(4);
        line(235, 850, 265, 850);
        line(235, 860, 265, 860);
        line(235, 870, 265, 870);
        strokeWeight(1);
        noStroke();
        
        if(CheckAvailableUpgrade() || CheckAvailableManager() || CheckAvailableInvestor()) {
            fill(#FF784B, circle_fill);
            ellipse(287, 862, 20, 20);
            if(circle_fill >= 255 || circle_fill <= 0) {
                update_circle_fill *= -1;
            }
            circle_fill += update_circle_fill;
        }
    }
    
    
}

void HandleUpgradeScrolling(float scroll_wheel) {
    float max_scroll = -500 + (100 * (NUM_UPGRADES - p1.upgrades_remaining));
    if(max_scroll > 0) {
        max_scroll = 0;
    }
  
    if(scroll_wheel == -2) {    
        if(mousePressed && scrollable) {            
            if(menu_scroll_amount > 0) {
                menu_scroll_amount -= (pmouseY - mouseY) / (menu_scroll_amount / 5);
            }
            else if(menu_scroll_amount < max_scroll) {
                menu_scroll_amount -= (pmouseY - mouseY) / (Math.abs(menu_scroll_amount - max_scroll) / 5);
            }
            else {
                menu_scroll_amount -= pmouseY - mouseY;
            }
            
        }
        else if(!mousePressed) {
            if(menu_scroll_amount > 0) {
                scrollable = false;
                if(menu_scroll_amount > 0.1) {
                    menu_scroll_amount -= 1.2 * (menu_scroll_amount / 5);
                }
                else {
                    menu_scroll_amount = 0;
                    scrollable = true;
                }
            }
            else if(menu_scroll_amount < max_scroll) {
                scrollable = false;
                if(menu_scroll_amount < max_scroll - 0.1) {
                    menu_scroll_amount += 1.2 * (Math.abs(menu_scroll_amount - max_scroll) / 5);
                }
                else {
                    menu_scroll_amount = max_scroll;
                    scrollable = true;
                }
            }
        }
    }
    
    else if(menu_scroll_amount <= 0 && menu_scroll_amount >= max_scroll) {
        menu_scroll_amount -= scroll_wheel * 20;
    }
}

void HandleManagerScrolling(float scroll_wheel) {
    float max_scroll = -500 + (100 * (NUM_BUSINESSES - p1.managers_remaining));
    if(max_scroll > 0) {
        max_scroll = 0;
    }
  
    if(scroll_wheel == -2) {    
        if(mousePressed && scrollable) {            
            if(menu_scroll_amount > 0) {
                menu_scroll_amount -= (pmouseY - mouseY) / (menu_scroll_amount / 5);
            }
            else if(menu_scroll_amount < max_scroll) {
                menu_scroll_amount -= (pmouseY - mouseY) / (Math.abs(menu_scroll_amount - max_scroll) / 5);
            }
            else {
                menu_scroll_amount -= pmouseY - mouseY;
            }
            
        }
        else if(!mousePressed) {
            if(menu_scroll_amount > 0) {
                scrollable = false;
                if(menu_scroll_amount > 0.1) {
                    menu_scroll_amount -= 1.2 * (menu_scroll_amount / 5);
                }
                else {
                    menu_scroll_amount = 0;
                    scrollable = true;
                }
            }
            else if(menu_scroll_amount < max_scroll) {
                scrollable = false;
                if(menu_scroll_amount < max_scroll - 0.1) {
                    menu_scroll_amount += 1.2 * (Math.abs(menu_scroll_amount - max_scroll) / 5);
                }
                else {
                    menu_scroll_amount = max_scroll;
                    scrollable = true;
                }
            }
        }
    }
    
    else if(menu_scroll_amount <= 0 && menu_scroll_amount >= max_scroll) {
        menu_scroll_amount -= scroll_wheel * 20;
    }
}

void HandleMainScrolling(float scroll_wheel) {
    float max_scroll = -1475 + (100 * (NUM_BUSINESSES));
    
    if(max_scroll > 0) {
        max_scroll = 0;
    }
  
    if(scroll_wheel == -2) {    
        if(mousePressed && scrollable) {            
            if(main_scroll_amount > 0) {
                main_scroll_amount -= (pmouseY - mouseY) / (main_scroll_amount / 5);
            }
            else if(main_scroll_amount < max_scroll) {
                main_scroll_amount -= (pmouseY - mouseY) / (Math.abs(main_scroll_amount - max_scroll) / 5);
            }
            else {
                main_scroll_amount -= pmouseY - mouseY;
            }
            
        }
        else if(!mousePressed) {
            if(main_scroll_amount > 0) {
                scrollable = false;
                if(main_scroll_amount > 0.1) {
                    main_scroll_amount -= 1.2 * (main_scroll_amount / 5);
                }
                else {
                    main_scroll_amount = 0;
                    scrollable = true;
                }
            }
            else if(main_scroll_amount < max_scroll) {
                scrollable = false;
                if(main_scroll_amount < max_scroll - 0.1) {
                    main_scroll_amount += 1.2 * (Math.abs(main_scroll_amount - max_scroll) / 5);
                }
                else {
                    main_scroll_amount = max_scroll;
                    scrollable = true;
                }
            }
        }
    }
    
    else if(main_scroll_amount <= 0 && main_scroll_amount >= max_scroll) {
        main_scroll_amount -= scroll_wheel * 20;
    }
}

int GetPurchaseAmount(int i) {
    if(purchase_flag == PURCHASE_AMOUNTS.ONE || purchase_flag == PURCHASE_AMOUNTS.NEXT) { return 1; }
    else if(purchase_flag == PURCHASE_AMOUNTS.TEN) { return 10; }
    else if(purchase_flag == PURCHASE_AMOUNTS.HUNDRED) { return 100; }
    else { return -1; }
}

void ScrollPurchaseFlag() {
    switch(purchase_flag) {
        case ONE:
            purchase_flag = PURCHASE_AMOUNTS.TEN;
            break;
        case TEN:
            purchase_flag = PURCHASE_AMOUNTS.HUNDRED;
            break;
        case HUNDRED:
            purchase_flag = PURCHASE_AMOUNTS.NEXT;
            break;
        case NEXT:
            purchase_flag = PURCHASE_AMOUNTS.MAX;
            break;
        case MAX:
            purchase_flag = PURCHASE_AMOUNTS.ONE;
            break;
    }
}
