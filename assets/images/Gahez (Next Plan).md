### Fraud & Cheat Detection
- **Large Fake orders:** If the orders is large (more than a threshold price or number of items).
- **Fake contact**: The customer checkout with a random phone number or name.
- **Using Bots**: Ordering unstoppable till the system fails (ex:- DDOS).
- **Ordering without showing up**: The customer places an order with cash payment, but does not show up to pay or pick up.
- **Cancelling order**: Customer needs to cancel & refund his order.
- **Unlimited discounts with fake accounts**: Customer creates new fake accounts to earn unlimited discounts.
- **Fake ready orders**: The chief pings the item to be ready, but he doesn't actually prepare it.
- **Fake pricing**
- **Fake deliver request**: The pick-up man checks orders as picked by the customer, but the customer did not actually receive it
- **Non deliver Lie**: The customer actually receives his order but denies it on the form.
### User Experience
- Localization: Support Arabic language
- Provide maps
- Item customization
- Add customer service and complaints
### Restaurant Management
- Analytics
- Manual ordering: If the customer can't ordering via his phone, They can order the traditional way.
### Extra Features
- **Meal plan:** Customer can subscribe on restaurants that provide this feature, They pick-up their order without waiting on a static time periodically.
- **Delivery**: Customer can order a delivery if the restaurant supports internal delivery.
- **Offline support (Too advanced)**: Customer can order without even having an internet connection.
- **QR Order Handoff:** Customer can generate a QR code with their order, Friend can scan it and pick it up instead of them.
- **Budget Mode:** Customer can set their budget, and we show the best restaurants or items for them.
- **Silent Mode**: When restaurants reaches full capacity of orders and new orders would wait so long, ordering pause.
- **Augmented reality:** Show items in 3D.
- **Mood-Based Recommendation**: Suggest items or restaurants based on customer mood description (They don't know what to eat but wanting something spicy for example).
### Optimizations
- Use Kafka for real-time streaming data processing.
- Add a Redis layer for caching menus, locations, etc.
- Use GraphQL for multi-shaped responses.
- Use gRPC for services communications.
- Handle multi requests by using DB transactions.
- Clean DTOs to have a clean response and reduce data waste.
### Business
- **Collaborate with indie chiefs:** Support indie chiefs