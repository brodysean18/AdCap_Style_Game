class Upgrade {
    int upgrade;
    Value cost;  
    int business_vs_angels;
    int speed_vs_profit;
    double multiplier;
    
    Upgrade(int u, double cb, int ce, int bva, int svp, double m) {
        this.upgrade = u;
        this.cost = new Value(cb, ce);
        this.business_vs_angels = bva;
        this.speed_vs_profit = svp;
        this.multiplier = m;
    }
    
    Upgrade() {
        this.upgrade = 0;
        this.cost = new Value(0, 0);
        this.business_vs_angels = -2;
        this.speed_vs_profit = -1;
        this.multiplier = 0;
    }
    
    void PrintInfo(float x, float y) {
        if(this.business_vs_angels == -1) {
            if(speed_vs_profit == 0) {
                text("Angel effectiveness +" + multiplier + "%", x, y);
            }
            else {
                text("Angel effectiveness x" + multiplier, x, y);
            }
        }
        else if(this.business_vs_angels == NUM_BUSINESSES) {
            if(speed_vs_profit == 0) {
                text("Speed of all businesses x" + multiplier, x, y);
            }
            else {
                text("Profit of all businesses x" + multiplier, x, y);
            }
        }
        else {
            if(speed_vs_profit == 0) {
                text("Speed of business " + (this.business_vs_angels + 1) + " x" + multiplier, x, y);
            }
            else {
                text("Profit of business " + (this.business_vs_angels + 1) + " x" + multiplier, x, y);
            }
        }
        
        Value dummy = this.cost.Format();
        dummy.Print("$", x, y + 18);
    }
    
    void ApplyUpgrade(Player p1) {
        if(p1.cash.exp > this.cost.exp) {
            p1.cash.base -= this.cost.base * Math.pow(10, this.cost.exp - p1.cash.exp);
        }
        else {
            p1.cash.base -= this.cost.base;
        }

        if(p1.cash.base < 0.009) {
            p1.cash.base = 0.0;
            p1.cash.exp = 0;
        }

        this.upgrade = 1;        

        p1.Adjust();
      
        if(this.business_vs_angels == -1) {
            if(speed_vs_profit == 0) {
                p1.angel_profit_bonus += multiplier;
            }
            else {
                p1.angel_profit_bonus *= multiplier;
            }
        }
        else if(this.business_vs_angels == NUM_BUSINESSES) {
            if(speed_vs_profit == 0) {
                for(int i = 0; i < NUM_BUSINESSES; ++i) {
                    p1.businesses[i].recharge_speed_sec /= multiplier;
                }                    
            }
            else {
                for(int i = 0; i < NUM_BUSINESSES; ++i) {
                    p1.businesses[i].profit.base *= multiplier;
                    p1.businesses[i].AdjustProfit();
                }
            }
        }
        else {
            if(speed_vs_profit == 0) {
                p1.businesses[business_vs_angels].recharge_speed_sec /= multiplier;
            }
            else {
                p1.businesses[business_vs_angels].profit.base *= multiplier;
                p1.businesses[business_vs_angels].AdjustProfit();
            }
        }
        
        p1.upgrades_remaining -= 1;
    }
}
