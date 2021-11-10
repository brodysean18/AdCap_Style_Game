import java.math.RoundingMode;
import java.math.BigDecimal;
import java.util.concurrent.TimeUnit;

// REWORK THIS //
    PImage bg;
    PImage splash_screen;
    PImage back_arrow;
    
    Player p1 = new Player();
    
    long begin = System.nanoTime();
    long curr = begin;
    
    int MAIN_SCREEN = 1;
    int MENU_SCREEN = 0;
    int MANAGER_SCREEN = 0;
    int UPGRADE_SCREEN = 0;
    int ANGEL_SCREEN = 0;
    
    enum PURCHASE_AMOUNTS {
        ONE,
        TEN,
        HUNDRED,
        NEXT,
        MAX
    }
    
    PURCHASE_AMOUNTS purchase_flag = PURCHASE_AMOUNTS.ONE;
    
    float main_scroll_amount = 0;
    float menu_scroll_amount = 0;
    boolean scrollable = true;
    
    long buffer_time = 0;
    
    int splash = 255;
    
    int circle_fill = 1;
    int update_circle_fill = 10;
// REWORK THIS //

void setup() {
    splash_screen = loadImage("splash.jpg");
    back_arrow = loadImage("back_arrow.png");
  
    PFont font;
    font = createFont("PatrickHand-Regular.ttf", 32);
    textFont(font);
    size(500, 900);
    noStroke();
    fill(0);
    textSize(32);
    textAlign(CENTER);
    bg = loadImage("slate-texture-background.jpg");
}

void draw() {
    if(splash > 0) {
        background(splash_screen);
        fill(0, splash);
        rect(0, 0, 500, 900);
        splash -= 2;
    }
    
    else if(splash == -1) {
        delay(3000);
        splash = 0;
    }
    
    else {
        background(bg);
        
        //MISC
        //PrintMouse();
        PrintCash();
        for(int i = 0; i < NUM_BUSINESSES; ++i) {
            if(p1.businesses[i].running == 1) {
                CheckBusiness(i);
            }
        }
        
        //MAIN SCREEN
        if(MAIN_SCREEN == 1) {
            DrawMainScreen();
            
            if(MENU_SCREEN == 0 && UPGRADE_SCREEN == 0 && MANAGER_SCREEN == 0 && ANGEL_SCREEN == 0) {
                HandleMainScrolling(-2);
            }
        }
        
        DrawMenuButton();
        
        //UPGRADES SCREEN
        if(UPGRADE_SCREEN == 1) {
            DrawUpgradeScreen();
            HandleUpgradeScrolling(-2);
        }
        
        //MANAGERS SCREEN
        if(MANAGER_SCREEN == 1) {
            DrawManagerScreen();
            HandleManagerScrolling(-2);
        }
        
        //ANGELS SCREEN
        if(ANGEL_SCREEN == 1) {
            DrawAngelScreen();
        }
        
        //MENU SCREEN
        if(MENU_SCREEN == 1) {
            DrawMenuScreen();
        }
    }
}

void mousePressed() {
    //NAVIGATION   
    if(mouseX >= 235 && mouseX <= 265 && mouseY >= 850 && mouseY <= 870) {
        ToggleMenu();
    }
        
    //MENU SCREEN
    if(MENU_SCREEN == 1) {
        HandleMenuEvent();
    }
  
    //MAIN SCREEN
    if(MAIN_SCREEN == 1 && MENU_SCREEN == 0 && UPGRADE_SCREEN == 0 && MANAGER_SCREEN == 0 && ANGEL_SCREEN == 0) {
        HandleMainScreenEvent();
    }
    
    //UPGRADES SCREEN
    if(UPGRADE_SCREEN == 1) {
        HandleUpgradeScreenEvent();
    }
    
    //MANAGERS SCREEN
    if(MANAGER_SCREEN == 1) {
        HandleManagerScreenEvent();
    }
    
    //ANGELS SCREEN
    if(ANGEL_SCREEN == 1) {
        HandleAngelScreenEvent();
    }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(UPGRADE_SCREEN == 1) {
    HandleUpgradeScrolling(e);
  }
  else if(MANAGER_SCREEN == 1) {
      HandleManagerScrolling(e);
  }
  if(MAIN_SCREEN == 1 && UPGRADE_SCREEN == 0 && MANAGER_SCREEN == 0 && ANGEL_SCREEN == 0 && MENU_SCREEN == 0) {
      HandleMainScrolling(e);
  }
}
