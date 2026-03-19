package kata;

public class LegacyCheckoutCalculator {

    public int calculateTotalCents(Order order) {
        int subtotal = order.subtotalCents();
        int discountPercent = 0;
        String customerType = safe(order.customerType());
        String country = safe(order.country());
        String coupon = safe(order.couponCode());

        if (customerType.equals("vip")) {
            discountPercent = discountPercent + 15;
        } else if (customerType.equals("premium")) {
            if (subtotal >= 10000) {
                discountPercent = discountPercent + 10;
            } else {
                discountPercent = discountPercent + 5;
            }
        } else if (customerType.equals("employee")) {
            discountPercent = discountPercent + 30;
        } else if (customerType.equals("regular") || customerType.equals("new")) {
            discountPercent = discountPercent + 0;
        } else {
            discountPercent = discountPercent + 0;
        }

        if (coupon.equals("SAVE10")) {
            if (subtotal >= 5000) {
                discountPercent = discountPercent + 10;
            }
        } else if (coupon.equals("VIPONLY")) {
            if (customerType.equals("vip")) {
                discountPercent = discountPercent + 5;
            }
        } else if (coupon.equals("BULK")) {
            if (subtotal >= 20000) {
                discountPercent = discountPercent + 7;
            }
        }

        if (order.blackFriday()) {
            if (!customerType.equals("employee")) {
                discountPercent = discountPercent + 5;
            }
        }

        if (discountPercent > 40) {
            discountPercent = 40;
        }

        int discountedSubtotal = subtotal * (100 - discountPercent) / 100;

        int shippingCents;
        if (country.equals("IT")) {
            shippingCents = 700;
        } else if (country.equals("DE")) {
            shippingCents = 900;
        } else if (country.equals("US")) {
            shippingCents = 1500;
        } else {
            shippingCents = 2500;
        }

        if (order.blackFriday() && country.equals("US")) {
            shippingCents = shippingCents + 300;
        }

        if (coupon.equals("FREESHIP") && discountedSubtotal >= 8000) {
            shippingCents = 0;
        }

        if (customerType.equals("vip") && discountedSubtotal >= 15000) {
            shippingCents = 0;
        }

        if (customerType.equals("premium") && discountedSubtotal >= 20000) {
            shippingCents = 0;
        }

        if (customerType.equals("employee") && !country.equals("IT")) {
            shippingCents = shippingCents + 500;
        }

        int taxPercent;
        if (country.equals("IT")) {
            taxPercent = 22;
        } else if (country.equals("DE")) {
            taxPercent = 19;
        } else if (country.equals("US")) {
            taxPercent = 7;
        } else {
            taxPercent = 0;
        }

        if (customerType.equals("vip") && country.equals("IT")) {
            taxPercent = 20;
        }

        if (coupon.equals("TAXFREE") && !country.equals("IT")) {
            taxPercent = 0;
        }

        int taxCents = discountedSubtotal * taxPercent / 100;
        int total = discountedSubtotal + shippingCents + taxCents;

        if (total < 0) {
            return 0;
        }

        return total;
    }

    private String safe(String value) {
        return value == null ? "" : value.trim();
    }
}
