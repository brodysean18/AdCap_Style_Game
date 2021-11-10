final int BUSINESS_SPACING = 120;

void DrawMainScreen() {  
    for(int i = 0; i < NUM_BUSINESSES; ++i) {
        if(p1.businesses[i].business == 1) {
            DrawProgressBars(i);
            DrawProgressBarOutlines(i);
            DrawProfitAmounts(i);
            DrawPurchaseButtons(i);
            DrawNumBusinesses(i);
            DrawBusinessButtons(i);
            DrawTimeRemaining(i);            
        }
        else {
            DrawUnpurchasedBusiness(i);
        }
    }
    rectMode(CORNER);
    stroke(100);
    fill(25);
    rect(-1, -1, 501, 110);
    rect(-1, 820, 501, 80);
    noStroke();
    
    PrintCash();
    DrawPurchaseAmountFlag();
}

void PrintCash() {
    textAlign(CORNER);
    textSize(46);
    fill(255);
    
    Value dummy = p1.cash.Format();
    dummy.Print("$", 20, 70);
}

void DrawProgressBars(int i) {
    if(p1.businesses[i].running == 1) {      
      float percentDone = CheckBusiness(i);
      
      fill(#1BC130);
      rectMode(CORNER);
      rect(100, (i * BUSINESS_SPACING) + 142 + main_scroll_amount, (percentDone * 365), 30);
    }
}

void DrawProgressBarOutlines(int i) {
    stroke(255);
    strokeWeight(1);
    noFill();
    rectMode(CORNER);
    rect(100, (i * BUSINESS_SPACING) + 142 + main_scroll_amount, 365, 30);
    noStroke();
}

void DrawProfitAmounts(int i) {         
    fill(255);
    textAlign(CENTER);
    textSize(32);
    
    Value dummy = new Value(p1.businesses[i].profit.base, p1.businesses[i].profit.exp);
    dummy.base *= p1.businesses[i].num_businesses;
    dummy.Adjust();
    dummy = dummy.Format();
    dummy.Print("$", 275, (i * BUSINESS_SPACING) + 168 + main_scroll_amount);
}

void DrawPurchaseButtons(int i) {
    int fill_1 = 0;
    int fill_2 = 0;
  
    int purchase_amount = GetPurchaseAmount(i);    
    if(purchase_amount == -1) { purchase_amount = p1.CheckNumBusinessesPurchasable(i); }
    
    if(p1.CheckNumBusinessesPurchasable(i) >= purchase_amount && purchase_amount > 0) {
      fill_1 = #1BC130;
      fill_2 = 255;
    }
    else {
      fill_1 = 50;
      fill_2 = 85;
    }
    
    rectMode(CORNER);
    noStroke();
    fill(fill_1);
    rect(100, (i * BUSINESS_SPACING) + 177 + main_scroll_amount, 275, 31, 7);
    
    fill(fill_2);
    textSize(26);
    textAlign(CORNER);
    
    Value p = p1.CalculatePrice(i, purchase_amount);    
    p = p.Format();
    
    if(purchase_amount == 0) {purchase_amount++;}
    
    p.Print("x" + purchase_amount + ": $", 110, (i * BUSINESS_SPACING) + 200 + main_scroll_amount);
}

// CHANGE THIS
void DrawNumBusinesses(int i) {
    rectMode(CORNER);
    noFill();
    stroke(#1BC130);
    rect(30, (i * BUSINESS_SPACING) + 146 + main_scroll_amount, 59, 63, 5);
    noStroke();
  
    fill(255);
    textAlign(CENTER);
    textSize(24);
    text("x" + p1.businesses[i].num_businesses, 59, (i * BUSINESS_SPACING) + 202 + main_scroll_amount);
}

// CHANGE THIS
void DrawBusinessButtons(int i) {
    if(p1.businesses[i].running == 0) { fill(#1BC130); }
    else { fill(120); }
    rectMode(CORNER);
    rect(30, (i * BUSINESS_SPACING) + 139 + main_scroll_amount, 60, 40, 7, 7, 0, 0);
    textAlign(CORNER);
    if(p1.businesses[i].running == 0) { fill(255); }
    else { fill(0); }
    textSize(22);
    text("Run", 46, (i * BUSINESS_SPACING) + 167 + main_scroll_amount);
}

void DrawTimeRemaining(int i) {
    rectMode(CORNER);
    fill(85);
    stroke(255);
    strokeWeight(1);
    
    rect(380, (i * BUSINESS_SPACING) + 177 + main_scroll_amount, 85, 31, 7);
    
    noStroke();
  
    if(p1.businesses[i].running == 0) {return;}
    
    int hours = 0;
    int minutes = 0;
    int seconds = 0;
  
    float elapsed = (float)(TimeUnit.NANOSECONDS.toMillis(curr - p1.businesses[i].last_run) / 1000f);
    int remaining = (int)p1.businesses[i].recharge_speed_sec - (int)elapsed;
    
    if(remaining >= 60) {
        minutes = remaining / 60;
        seconds = remaining % 60;
    }
    if(minutes >= 60) {
        hours = minutes / 60;
        minutes = minutes % 60;
    }
    
    textAlign(CENTER);
    textSize(20);
    fill(255);
    noStroke();
    
    if(hours > 0) {
        text(hours + "h " + minutes + "m " + seconds + "s", 422.5, (i * BUSINESS_SPACING) + 199 + main_scroll_amount);
    }
    else if(minutes > 0) {
        text(minutes + "m " + seconds + "s", 422.5, (i * BUSINESS_SPACING) + 199 + main_scroll_amount);
    }
    else {    
        text(remaining + "s", 422.5, (i * BUSINESS_SPACING) + 199 + main_scroll_amount);
    }
}

void DrawUnpurchasedBusiness(int i) {  
    int fill_1 = 0;
    int fill_2 = 0;
  
    int purchase_amount = GetPurchaseAmount(i);    
    if(purchase_amount == -1) { purchase_amount = p1.CheckNumBusinessesPurchasable(i); }
    
    if(p1.CheckNumBusinessesPurchasable(i) >= purchase_amount && purchase_amount > 0) {
      fill_1 = #1BC130;
      fill_2 = 255;
    }
    else {
      fill_1 = 50;
      fill_2 = 85;
    }
    
    rectMode(CORNER);
    fill(fill_1);
    rect(30, (i * BUSINESS_SPACING) + 120 + main_scroll_amount, 435, 65, 10);
    
    fill(fill_2);
    textSize(36);
    textAlign(CENTER);
    
    Value p = p1.CalculatePrice(i, purchase_amount);    
    p = p.Format();
    p.Print("Business " + (i + 1) + ": $", 250, (i * BUSINESS_SPACING) + 163 + main_scroll_amount);
}

void DrawPurchaseAmountFlag() {
    fill(#C4341E);
    rectMode(CENTER);
    rect(430, 55, 85, 50, 15);
    fill(255);
    textAlign(CENTER);
    textSize(28);
    switch(purchase_flag) {
        case ONE:
            text("x1", 428, 64);
            break;
        case TEN:
            text("x10", 431, 64);
            break;
        case HUNDRED:
            text("x100", 431, 64);
            break;
        case NEXT:
            text("NEXT", 431, 64);
            break;
        case MAX:
            text("MAX", 431, 64);
            break;
    }
}

float CheckBusiness(int i) {
    curr = System.nanoTime();
    if((float)(TimeUnit.NANOSECONDS.toMillis(curr - p1.businesses[i].last_run) / 1000f) >= p1.businesses[i].recharge_speed_sec) {
        Profit(i);
        return 0;
    }
    
    float elapsed = (float)(TimeUnit.NANOSECONDS.toMillis(curr - p1.businesses[i].last_run) / 1000f);    
    float percentDone = elapsed / (float)p1.businesses[i].recharge_speed_sec;
    
    return percentDone;
}

void RunBusiness(int i) {
    p1.businesses[i].running = 1;
    p1.businesses[i].last_run = System.nanoTime();
}

void Profit(int i) {
    p1.Profit(i);
              
    if(p1.businesses[i].manager == 0) {
        p1.businesses[i].running = 0;
    }
    else {
        p1.businesses[i].last_run = System.nanoTime();
    }
}

void PurchaseBusiness(int i) {
    int purchase_amount = GetPurchaseAmount(i);
    
    if(purchase_amount == -1) { purchase_amount = p1.CheckNumBusinessesPurchasable(i); }
    
    
  
    if(p1.CheckNumBusinessesPurchasable(i) >= purchase_amount && purchase_amount > 0) {
        p1.PurchaseBusiness(i, purchase_amount);
    }
    if(p1.businesses[i].manager == 1) {
        p1.businesses[i].running = 1;
    }
}

// CHANGE THIS
void HandleMainScreenEvent() {
    if(mouseX >= 387.5 && mouseX <= 472.5 && mouseY >= 30 && mouseY <= 80) {
        ScrollPurchaseFlag();
    }
    
    for(int i = 0; i < NUM_BUSINESSES; ++i) {
        if(p1.businesses[i].manager == 0) {
            if(p1.businesses[i].business == 1   &&
               p1.businesses[i].running == 0    &&
               mouseX >= 30                     &&
               mouseX <= 90                     &&
               mouseY >= (i * BUSINESS_SPACING) + 146.5 + main_scroll_amount       &&
               mouseY <= (i * BUSINESS_SPACING) + 146.5 + 40 + main_scroll_amount) {
                  RunBusiness(i);
            }
        }
        if(p1.businesses[i].business == 0 &&
           mouseX >= 30                   &&
           mouseX <= 465                  &&
           mouseY >= (i * BUSINESS_SPACING) + 137.5 + main_scroll_amount     &&
           mouseY <= (i * BUSINESS_SPACING) + 202.5 + main_scroll_amount)    {
              PurchaseBusiness(i);
        }
        else if(mouseX >= 100                           &&
                mouseX <= 465                           &&
                mouseY >= (i * BUSINESS_SPACING) + 177 + main_scroll_amount  &&
                mouseY <= (i * BUSINESS_SPACING) + 208 + main_scroll_amount) {
            PurchaseBusiness(i);
        }
    }
}
