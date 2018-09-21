public class Red {
    /**
     * 生成红包金额
     *
     */
    public static BigDecimal generateRedValue(BigDecimal total, int count) {
        if (count == 1) {
            return total;
        }
        Random r = new Random();
        // TODO 向下取整取到0怎么办？向上取整取到大于余额怎么办？
        BigDecimal max = total.divide(BigDecimal.valueOf(count), 4, BigDecimal.ROUND_DOWN).multiply(BigDecimal.valueOf(2));

        BigDecimal money = BigDecimal.valueOf(r.nextDouble()).multiply(max).setScale(4, BigDecimal.ROUND_DOWN);
        while ((money.compareTo(BigDecimal.valueOf(0))) == 0) {
            money = BigDecimal.valueOf(r.nextDouble()).multiply(max).setScale(4, BigDecimal.ROUND_DOWN);
        }
        return money;
    }
}