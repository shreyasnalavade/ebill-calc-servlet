<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List,com.ebill.ElectricityBillServlet.SlabCharge" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Your Electricity Bill Estimate</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">
</head>
<body>
<main class="container app-shell">
    <header class="brand-row">
        <div class="brand-mark" aria-hidden="true">ϟ</div>
        <span class="brand-name">WATTWISE <span class="brand-dot">·</span> HOME ENERGY</span>
    </header>
    <section class="result-card" aria-labelledby="result-title">
        <div class="result-topline"><span class="status-dot"></span> YOUR ESTIMATE IS READY</div>
        <h1 id="result-title">Your electricity<br><span>at a glance.</span></h1>
        <div class="result-summary">
            <div><span class="summary-label">TOTAL CONSUMPTION</span><strong><%= request.getAttribute("units") %><small> units</small></strong></div>
            <div class="summary-divider"></div>
            <div><span class="summary-label">TOTAL PAYABLE</span><strong class="total-amount">₹<%= request.getAttribute("total") %></strong></div>
        </div>
        <div class="breakdown-heading"><div><h2>Charge breakdown</h2><p>Progressive rates applied to each slab</p></div><span class="breakdown-icon" aria-hidden="true">▤</span></div>
        <div class="table-responsive">
            <table class="table breakdown-table">
                <thead><tr><th scope="col">TARIFF SLAB</th><th scope="col">UNITS</th><th scope="col">RATE / UNIT</th><th scope="col" class="text-end">AMOUNT</th></tr></thead>
                <tbody>
                <% List<SlabCharge> charges = (List<SlabCharge>) request.getAttribute("charges");
                   for (SlabCharge charge : charges) { %>
                    <tr><td><%= charge.getName() %></td><td><%= charge.getUnits().stripTrailingZeros().toPlainString() %></td><td>₹<%= charge.getRate().setScale(2) %></td><td class="text-end">₹<%= charge.getAmount().setScale(2) %></td></tr>
                <% } %>
                </tbody>
                <tfoot><tr><td colspan="3">Total estimated bill</td><td class="text-end">₹<%= request.getAttribute("total") %></td></tr></tfoot>
            </table>
        </div>
        <div class="estimate-note"><span aria-hidden="true">ⓘ</span> This estimate uses progressive slab rates and may not include taxes or fixed charges.</div>
        <a class="btn calculate-btn reset-btn" href="${pageContext.request.contextPath}/">Calculate another bill <span aria-hidden="true">↻</span></a>
    </section>
    <footer class="page-footer"><span>POWERING BETTER EVERYDAY DECISIONS</span><span>ESTIMATES BASED ON SLAB RATES</span></footer>
</main>
</body>
</html>
