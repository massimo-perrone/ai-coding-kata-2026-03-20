package kata;

public record Order(
        String customerType,
        int subtotalCents,
        String country,
        String couponCode,
        boolean blackFriday
) {
}
