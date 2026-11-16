package com.ebill;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/calculate")
public class ElectricityBillServlet extends HttpServlet {
    private static final BigDecimal FIFTY = new BigDecimal("50");
    private static final BigDecimal ONE_HUNDRED = new BigDecimal("100");
    private static final BigDecimal RATE_1 = new BigDecimal("3.50");
    private static final BigDecimal RATE_2 = new BigDecimal("4.00");
    private static final BigDecimal RATE_3 = new BigDecimal("5.20");
    private static final BigDecimal RATE_4 = new BigDecimal("6.50");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String rawUnits = request.getParameter("units");
        String error = validate(rawUnits);
        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
            return;
        }

        BigDecimal units = new BigDecimal(rawUnits.trim());
        List<SlabCharge> charges = new ArrayList<>();
        BigDecimal remaining = units;
        BigDecimal first = remaining.min(FIFTY);
        addCharge(charges, "First 50 units", first, RATE_1);
        remaining = remaining.subtract(first);

        BigDecimal second = remaining.min(ONE_HUNDRED);
        addCharge(charges, "Next 100 units (51–150)", second, RATE_2);
        remaining = remaining.subtract(second);

        BigDecimal third = remaining.min(ONE_HUNDRED);
        addCharge(charges, "Next 100 units (151–250)", third, RATE_3);
        remaining = remaining.subtract(third);

        addCharge(charges, "Above 250 units", remaining, RATE_4);
        BigDecimal total = charges.stream().map(SlabCharge::getAmount)
                .reduce(BigDecimal.ZERO, BigDecimal::add).setScale(2, RoundingMode.HALF_UP);

        request.setAttribute("units", units.stripTrailingZeros().toPlainString());
        request.setAttribute("charges", charges);
        request.setAttribute("total", total);
        request.getRequestDispatcher("/result.jsp").forward(request, response);
    }

    private String validate(String raw) {
        if (raw == null || raw.trim().isEmpty()) return "Enter your electricity consumption to continue.";
        String value = raw.trim();
        if (!value.matches("\\d+(\\.\\d+)?")) {
            return "Enter a valid number using digits and an optional decimal point.";
        }
        try {
            new BigDecimal(value);
        } catch (NumberFormatException exception) {
            return "Enter a valid electricity consumption value.";
        }
        return null;
    }

    private void addCharge(List<SlabCharge> charges, String name, BigDecimal slabUnits, BigDecimal rate) {
        BigDecimal amount = slabUnits.multiply(rate).setScale(2, RoundingMode.HALF_UP);
        charges.add(new SlabCharge(name, slabUnits, rate, amount));
    }

    public static final class SlabCharge {
        private final String name;
        private final BigDecimal units;
        private final BigDecimal rate;
        private final BigDecimal amount;

        SlabCharge(String name, BigDecimal units, BigDecimal rate, BigDecimal amount) {
            this.name = name; this.units = units; this.rate = rate; this.amount = amount;
        }
        public String getName() { return name; }
        public BigDecimal getUnits() { return units; }
        public BigDecimal getRate() { return rate; }
        public BigDecimal getAmount() { return amount; }
    }
}
