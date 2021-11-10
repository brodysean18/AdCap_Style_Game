class Value {
    double base;
    int exp;
    String amount;
    
    Value(double b, int e) {
        this.base = b;
        this.exp = e;
        this.amount = "";
    }
    
    Value(double b, int e, String a) {
        this.base = b;
        this.exp = e;
        this.amount = a;
    }
    
    void Adjust() {
        double ToBeTruncated = this.base;
        double TruncatedDouble = BigDecimal.valueOf(ToBeTruncated)
            .setScale(6, RoundingMode.HALF_UP)
            .doubleValue();
              
        this.base = TruncatedDouble;
      
        while((this.base / 10) >= 1) {
            this.base /= 10;
            this.exp += 1;
        }

        while(this.base < 1)  {
            this.base *= 10;
            this.exp -= 1;
        }
    }
    
    Value Format() {
        Value dummy = new Value(this.base, this.exp);
      
        if(dummy.exp < 6) {
            return dummy;
        }
        else if(dummy.exp < 9) {
            dummy.exp -= 6;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "million";
        }
        else if(dummy.exp < 12) {
            dummy.exp -= 9;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "billion";
        }
        else if(dummy.exp < 15) {
            dummy.exp -= 12;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "trillion";
        }
        else if(dummy.exp < 18) {
            dummy.exp -= 15;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "quadrillion";
        }
        else if(dummy.exp < 21) {
            dummy.exp -= 18;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "quintillion";
        }
        else if(dummy.exp < 24) {
            dummy.exp -= 21;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "sextillion";
        }
        else if(dummy.exp < 27) {
            dummy.exp -= 24;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "septillion";
        }
        else if(dummy.exp < 30) {
            dummy.exp -= 27;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "octillion";
        }
        else if(dummy.exp < 33) {
            dummy.exp -= 30;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "nonillion";
        }
        else if(dummy.exp < 36) {
            dummy.exp -= 33;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "decillion";
        }
        else if(dummy.exp < 39) {
            dummy.exp -= 36;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "undecillion";
        }
        else if(dummy.exp < 42) {
            dummy.exp -= 39;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "duodecillion";
        }
        else if(dummy.exp < 45) {
            dummy.exp -= 42;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "tredecillion";
        }
        else if(dummy.exp < 48) {
            dummy.exp -= 45;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "quattordecillion";
        }
        else if(dummy.exp < 51) {
            dummy.exp -= 48;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "quindecillion";
        }
        else if(dummy.exp < 54) {
            dummy.exp -= 51;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "sexdecillion";
        }
        else if(dummy.exp < 57) {
            dummy.exp -= 54;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "septendecillion";
        }
        else if(dummy.exp < 60) {
            dummy.exp -= 57;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "octodecillion";
        }
        else if(dummy.exp < 63) {
            dummy.exp -= 60;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "novemdecillion";
        }
        else if(dummy.exp < 66) {
            dummy.exp -= 63;
            dummy.base *= Math.pow(10, dummy.exp);
            dummy.amount = "vigintillion";
        }
        
        return dummy;
    }
    
    boolean GTET(Value v) {
        if(this.exp > v.exp || (this.exp == v.exp && this.base >= v.base)) { return true; }
        else { return false; }
    }
    
    Value Plus(Value v) {
        if(this.GTET(v)) {
            this.base += v.base * pow(10, -(abs(this.exp - v.exp)));
        }
        else {
            this.base = v.base + (this.base * pow(10, -(abs(this.exp - v.exp))));
        }
        this.exp = max(this.exp, v.exp);
        Adjust();
        return this;
    }
    
    void Print(String s, float x, float y) {
        if(this.amount == "") {
            double ToBeTruncated = this.base * pow(10, this.exp);
            double TruncatedDouble = BigDecimal.valueOf(ToBeTruncated)
                .setScale(3, RoundingMode.HALF_UP)
                .doubleValue();
          
            if((double)(int)TruncatedDouble == TruncatedDouble) {
                text(s + (int)TruncatedDouble, x, y);
            }
            else {
                text(s + TruncatedDouble, x, y);
            }
        }
        
        else {
            double ToBeTruncated = this.base;
            double TruncatedDouble = BigDecimal.valueOf(ToBeTruncated)
                .setScale(3, RoundingMode.HALF_UP)
                .doubleValue();
          
            if((double)(int)TruncatedDouble == TruncatedDouble) {
                text(s + (int)TruncatedDouble + " " + this.amount, x, y);
            }
            else {
                text(s + TruncatedDouble + " " + this.amount, x, y);
            }
        }
    }
}
