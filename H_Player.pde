import java.lang.Math;

public static final int NUM_BUSINESSES = 10;
public static final int NUM_UPGRADES = 10;

public class Player {
    Value net_worth;
    Value cash;
    Value num_angels;
    Value num_pros_angels;

    double angel_profit_bonus;
    
    int upgrades_remaining;
    int managers_remaining;

    Business[] businesses = new Business[NUM_BUSINESSES];
    Upgrade[] upgrades = new Upgrade[NUM_UPGRADES];

    Player() {
        this.net_worth = new Value(0.0, 0);        
        this.cash = new Value(0, 0);
        this.num_angels = new Value(0.0, 0);
        this.num_pros_angels = new Value(0.0, 0);

        this.angel_profit_bonus = 0.03;
        
        this.upgrades_remaining = NUM_UPGRADES;
        this.managers_remaining = NUM_BUSINESSES;

        this.businesses[0] = new Business(1, 0, 1, 1.0, 0, 0, 2, 0, 0, 5.0, 0, 1.38, 0, 1.0, 2);
        this.businesses[1] = new Business(0, 0, 0, 1.0, 1, 0, 10, 0, 0, 1.5, 1, 1.45, 0, 5.0, 2);
        this.businesses[2] = new Business(0, 0, 0, 1.5, 2, 0, 30, 0, 0, 2.0, 2, 1.2, 0, 1.0, 4);
        this.businesses[3] = new Business(0, 0, 0, 5.0, 3, 0, 90, 0, 0, 5.5, 3, 1.323, 0, 5.0, 5);
        this.businesses[4] = new Business(0, 0, 0, 2.5, 5, 0, 900, 0, 0, 5.0, 5, 1.1632, 0, 2.5, 7);
        this.businesses[5] = new Business(0, 0, 0, 1.25, 7, 0, 2400, 0, 0, 5.0, 7, 1.5, 0, 3.0, 10);
        this.businesses[6] = new Business(0, 0, 0, 1.5, 9, 0, 5400, 0, 0, 2.0, 10, 1.35, 0, 4.0, 13);
        this.businesses[7] = new Business(0, 0, 0, 3.0, 12, 0, 11700, 0, 0, 2.5, 14, 1.26, 0, 5.0, 17);
        this.businesses[8] = new Business(0, 0, 0, 5.0, 15, 0, 25200, 0, 0, 2.0, 18, 1.2, 0, 5.0, 22);
        this.businesses[9] = new Business(0, 0, 0, 1.0, 20, 0, 55800, 0, 0, 5.0, 25, 1.198, 0, 8.0, 30);
        
        this.upgrades[0] = new Upgrade(0, 1.0, 2, 0, 1, 5);
        this.upgrades[1] = new Upgrade(0, 5.0, 2, 1, 0, 2);
        this.upgrades[2] = new Upgrade(0, 1.0, 3, 2, 1, 10);
        this.upgrades[3] = new Upgrade(0, 2.5, 3, 3, 0, 5);
        this.upgrades[4] = new Upgrade(0, 2.5, 3, 4, 1, 1.5);
        this.upgrades[5] = new Upgrade(0, 2.5, 3, 5, 0, 10);
        this.upgrades[6] = new Upgrade(0, 5.0, 3, 4, 0, 10);
        this.upgrades[7] = new Upgrade(0, 1.0, 4, 3, 1, 2);
        this.upgrades[8] = new Upgrade(0, 1.2, 4, 2, 0, 1.5);
        this.upgrades[9] = new Upgrade(0, 1.5, 4, 1, 1, 10);        
    }

    void Profit(int business) {
        double total_profit_base = this.businesses[business].profit.base * this.businesses[business].num_businesses;
        int total_profit_exp = this.businesses[business].profit.exp;      
        
        while((total_profit_base / 10) >= 1) {
            total_profit_base /= 10;
            total_profit_exp += 1;
        }
      
        if(this.cash.exp > total_profit_exp) {
            this.cash.base += (total_profit_base * pow(10, total_profit_exp - this.cash.exp));
        }
        else if (this.cash.exp < total_profit_exp){
            this.cash.base = total_profit_base + (this.cash.base * Math.pow(10, this.cash.exp - total_profit_exp));
            this.cash.exp = total_profit_exp;
        }
        else {
            this.cash.base += total_profit_base;
        }

        Adjust();
    }
    
    Value CalculatePrice(int business, int num_businesses) {
        Value dummy_cost = new Value(this.businesses[business].cost.base, this.businesses[business].cost.exp);
        Value dummy_total = new Value(0, 0);
        
        if(num_businesses == 0) { num_businesses = 1; }
        
        for(int i = 0; i < num_businesses; ++i) {          
            dummy_total.Plus(dummy_cost);
            dummy_cost.base *= this.businesses[business].cost_multiplier;
            dummy_cost.Adjust();
            dummy_total.Adjust();
        }
        
        return dummy_total;
    }
    
    int CheckNumBusinessesPurchasable(int business) {
        Value dummy_cash = new Value(this.cash.base, this.cash.exp);
        Value dummy_cost = new Value(this.businesses[business].cost.base, this.businesses[business].cost.exp);
        Value dummy_total = new Value(0, 0);
        int num_businesses = 0;
        
        while(dummy_cash.GTET(dummy_total)) {
            dummy_total.Plus(dummy_cost);
            dummy_cost.base *= this.businesses[business].cost_multiplier;
            dummy_cost.Adjust();
            num_businesses++;
        }
        
        return num_businesses - 1;
    }

    void PurchaseBusiness(int business, int num_businesses) {
        for(int i = 0; i < num_businesses; ++i) {
            if(this.cash.exp > this.businesses[business].cost.exp) {
                this.cash.base -= (this.businesses[business].cost.base * pow(10, this.businesses[business].cost.exp - this.cash.exp));
            }
            else {
                this.cash.base -= this.businesses[business].cost.base;
            }
            
            this.businesses[business].cost.base *= this.businesses[business].cost_multiplier;
            
            while((this.businesses[business].cost.base / 10) >= 1) {
                this.businesses[business].cost.base /= 10;
                this.businesses[business].cost.exp += 1;
            }
            
            while(this.cash.base < 1 && this.cash.base > 0.009)  {
                this.cash.base *= 10;
                this.cash.exp -= 1;
            }
            
            if(this.businesses[business].business == 0) {
                this.businesses[business].business = 1;
            }
            this.businesses[business].num_businesses++;
        }
    }
    
    void PurchaseManager(int business) {
        if(this.cash.exp > this.businesses[business].manager_cost.exp) {
            this.cash.base -= this.businesses[business].manager_cost.base * Math.pow(10, this.businesses[business].manager_cost.exp - this.cash.exp);
        }
        else {
            this.cash.base -= this.businesses[business].manager_cost.base;
        }

        if(this.cash.base < 0.009) {
            this.cash.base = 0.0;
            this.cash.exp = 0;
        }

        this.businesses[business].manager = 1;
        
        if(this.businesses[business].business == 1) {
            this.businesses[business].running = 1;
            this.businesses[business].last_run = System.nanoTime();
        }

        Adjust();
        
        managers_remaining -= 1;
    }

    void Adjust() {
        double ToBeTruncated = this.cash.base;
        double TruncatedDouble = BigDecimal.valueOf(ToBeTruncated)
            .setScale(6, RoundingMode.HALF_UP)
            .doubleValue();
              
        this.cash.base = TruncatedDouble;
      
        while((this.cash.base / 10) >= 1) {
            this.cash.base /= 10;
            this.cash.exp += 1;
        }

        while(this.cash.base < 1 && this.cash.base > 0.009)  {
            this.cash.base *= 10;
            this.cash.exp -= 1;
        }
    }
}
