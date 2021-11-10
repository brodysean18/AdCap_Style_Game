class Business {
    int business;
    int running;
    int num_businesses;
    
    Value profit;
    Value profit_per_sec;
    Value cost;
    Value manager_cost;
    
    long last_run;
    double recharge_speed_sec;
    double cost_multiplier;
    int manager;

    Business(int b, int r, int nb, double pb, int pe, long lr, double rss, double ppsb, int ppse, double cb, int ce, double cm, int m, double mcb, int mce) {
        this.business = b;
        this.running = r;
        this.num_businesses = nb;

        this.profit = new Value(pb, pe);
        this.profit_per_sec = new Value(ppsb, ppse);
        this.cost = new Value(cb, ce);
        this.manager_cost = new Value(mcb, mce);
        
        this.last_run = lr;
        this.recharge_speed_sec = rss;
        this.cost_multiplier = cm;
        this.manager = m;
    }

    Business() {
        this.business = 0;
        this.running = 0;
        this.num_businesses = 0;
        
        this.profit = new Value(0, 0);
        this.profit_per_sec = new Value(0, 0);
        this.cost = new Value(0, 0);
        this.manager_cost = new Value(0, 0);
        
        this.last_run = 0;
        this.recharge_speed_sec = 0;
        this.cost_multiplier = 0;
        this.manager = 0;
    }
    
    void AdjustProfit() {
        while((this.profit.base / 10) >= 1) {
            this.profit.base /= 10;
            this.profit.exp += 1;
        }

        while(this.profit.base < 1 && this.profit.base > 0.009)  {
            this.profit.base *= 10;
            this.profit.exp -= 1;
        }
    }
    
    void AdjustCost() {
        while((this.cost.base / 10) >= 1) {
            this.cost.base /= 10;
            this.cost.exp += 1;
        }

        while(this.cost.base < 1 && this.cost.base > 0.009)  {
            this.cost.base *= 10;
            this.cost.exp -= 1;
        }
    }
}
