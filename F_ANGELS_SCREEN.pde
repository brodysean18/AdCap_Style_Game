void DrawAngelScreen() {
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
    
    textAlign(CENTER);
    textSize(40);
    fill(0);
    text("INVESTORS", 250, 160);
    
    
    
    DrawMenuButton();
}

void HandleAngelScreenEvent() {
    
}
