<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Electricity Bill Calculator</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/styles.css" rel="stylesheet">
</head>
<body>
<main class="container app-shell">
    <header class="brand-row">
        <div class="brand-mark" aria-hidden="true">ϟ</div>
        <span class="brand-name">WATTWISE <span class="brand-dot">·</span> HOME ENERGY</span>
    </header>

    <section class="hero-card" aria-labelledby="page-title">
        <div class="hero-copy">
            <div class="eyebrow"><span class="eyebrow-line"></span> SIMPLE. CLEAR. POWERFUL.</div>
            <h1 id="page-title">Electricity Bill<br><span>Calculator</span></h1>
            <p class="intro">A clearer picture of your energy costs starts here. Enter your monthly usage to see an instant estimate.</p>

            <div class="rate-note">
                <span class="rate-icon" aria-hidden="true">↗</span>
                <div><strong>Progressive slab billing</strong><small>Each unit is charged at the rate for its slab.</small></div>
            </div>
        </div>

        <div class="form-panel">
            <div class="panel-heading">
                <div class="panel-icon" aria-hidden="true">⚡</div>
                <div><h2>Estimate your bill</h2><p>For your current billing period</p></div>
            </div>
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger form-error" role="alert"><strong>We need one more try.</strong><br><%= request.getAttribute("error") %></div>
            <% } %>
            <form action="${pageContext.request.contextPath}/calculate" method="post">
                <label for="units" class="form-label">Electricity consumed</label>
                <div class="input-wrap">
                    <input class="form-control units-input" type="number" id="units" name="units" min="0" step="any" placeholder="e.g. 240" required aria-describedby="units-help">
                    <span class="input-unit">UNITS</span>
                </div>
                <div id="units-help" class="form-text">Your usage in kilowatt-hours (kWh)</div>
                <button type="submit" class="btn calculate-btn">Calculate my bill <span aria-hidden="true">→</span></button>
                <p class="privacy-note"><span aria-hidden="true">●</span> Your estimate is calculated instantly</p>
            </form>
            <div class="mini-divider"></div>
            <div class="slab-preview">
                <div><span class="slab-range">01</span><span>First 50 units</span><strong>₹3.50</strong></div>
                <div><span class="slab-range">02</span><span>Next 100 units</span><strong>₹4.00</strong></div>
                <div><span class="slab-range">03</span><span>Next 100 units</span><strong>₹5.20</strong></div>
                <div><span class="slab-range">04</span><span>Above 250 units</span><strong>₹6.50</strong></div>
                <small>Rate per unit <span>(₹)</span></small>
            </div>
        </div>
    </section>

    <footer class="page-footer"><span>POWERING BETTER EVERYDAY DECISIONS</span><span>ESTIMATES BASED ON SLAB RATES</span></footer>
</main>
</body>
</html>
