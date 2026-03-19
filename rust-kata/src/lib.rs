#[derive(Debug, Clone)]
pub struct Order {
    pub customer_type: String,
    pub subtotal_cents: i32,
    pub country: String,
    pub coupon_code: String,
    pub black_friday: bool,
}

pub fn calculate_total_cents(order: &Order) -> i32 {
    let subtotal = order.subtotal_cents;
    let customer_type = safe(&order.customer_type);
    let country = safe(&order.country);
    let coupon = safe(&order.coupon_code);

    let mut discount_percent = 0;

    if customer_type == "vip" {
        discount_percent += 15;
    } else if customer_type == "premium" {
        if subtotal >= 10000 {
            discount_percent += 10;
        } else {
            discount_percent += 5;
        }
    } else if customer_type == "employee" {
        discount_percent += 30;
    } else if customer_type == "regular" || customer_type == "new" {
        discount_percent += 0;
    } else {
        discount_percent += 0;
    }

    if coupon == "SAVE10" {
        if subtotal >= 5000 {
            discount_percent += 10;
        }
    } else if coupon == "VIPONLY" {
        if customer_type == "vip" {
            discount_percent += 5;
        }
    } else if coupon == "BULK" {
        if subtotal >= 20000 {
            discount_percent += 7;
        }
    }

    if order.black_friday {
        if customer_type != "employee" {
            discount_percent += 5;
        }
    }

    if discount_percent > 40 {
        discount_percent = 40;
    }

    let discounted_subtotal = subtotal * (100 - discount_percent) / 100;

    let mut shipping_cents = if country == "IT" {
        700
    } else if country == "DE" {
        900
    } else if country == "US" {
        1500
    } else {
        2500
    };

    if order.black_friday && country == "US" {
        shipping_cents += 300;
    }

    if coupon == "FREESHIP" && discounted_subtotal >= 8000 {
        shipping_cents = 0;
    }

    if customer_type == "vip" && discounted_subtotal >= 15000 {
        shipping_cents = 0;
    }

    if customer_type == "premium" && discounted_subtotal >= 20000 {
        shipping_cents = 0;
    }

    if customer_type == "employee" && country != "IT" {
        shipping_cents += 500;
    }

    let mut tax_percent = if country == "IT" {
        22
    } else if country == "DE" {
        19
    } else if country == "US" {
        7
    } else {
        0
    };

    if customer_type == "vip" && country == "IT" {
        tax_percent = 20;
    }

    if coupon == "TAXFREE" && country != "IT" {
        tax_percent = 0;
    }

    let tax_cents = discounted_subtotal * tax_percent / 100;
    let total = discounted_subtotal + shipping_cents + tax_cents;

    if total < 0 { 0 } else { total }
}

fn safe(value: &str) -> String {
    value.trim().to_string()
}
