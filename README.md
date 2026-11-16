# Electricity Bill Calculator

A beginner-friendly Java Servlet and JSP application that estimates an electricity bill using progressive tariff slabs.

## Tariff

| Consumption slab | Rate per unit |
| --- | ---: |
| First 50 units | ₹3.50 |
| Next 100 units (51–150) | ₹4.00 |
| Next 100 units (151–250) | ₹5.20 |
| Above 250 units | ₹6.50 |

Each slab is charged progressively. For example, 200 units means 50 units at ₹3.50, 100 at ₹4.00, and 50 at ₹5.20.

## Requirements

- JDK 11 or newer
- Maven 3.6 or newer
- Apache Tomcat 9 (the app uses the `javax.servlet` API)
- Internet access in the browser for the Bootstrap 5.3.3 CDN stylesheet and Google Fonts (the application logic runs locally)

## Build and run

1. Build the WAR from the project root:

   ```sh
   mvn clean package
   ```

2. Copy `target/electricity-bill-calculator.war` into Tomcat's `webapps` directory and start Tomcat.
3. Open `http://localhost:8080/electricity-bill-calculator/`.

In an IDE, import the folder as a Maven project and deploy the generated WAR to a local Tomcat 9 server.

## Input behavior

The calculator accepts non-negative whole or decimal unit values. Blank, negative, and malformed values are rejected with an error message. Use **Calculate another bill** to reset and start a fresh calculation.

## Project layout

```text
src/main/java/com/ebill/ElectricityBillServlet.java  # validation, slab calculations, controller
src/main/webapp/index.jsp                            # calculator form
src/main/webapp/result.jsp                           # calculation summary and breakdown
src/main/webapp/css/styles.css                       # responsive application styling
```
