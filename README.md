# Fuwü V Starter

This starter includes a basic backend and a simple desktop/mobile prototype built with the **V programming language**. Use it as a foundation for developing the full Fuwü app with V.

## Prerequisites

1. **Install V:** Follow the instructions on the official site (https://vlang.io). After installation run `v up` to update to the latest compiler.
2. **Install the UI module** (required only for the desktop/mobile prototype): `v install ui`.

## Backend

The backend uses V's built‑in web framework `vweb` to expose a small REST API with mock data. To run it:

```bash
cd backend
v run main.v
```

This starts a server on port `8080` with the following endpoints:

- `GET /get_providers` – returns a list of providers.
- `GET /get_provider/:id` – returns details for a single provider.
- `GET /get_services/:provider_id` – returns services offered by the provider.
- `GET /get_bookings` – returns a list of bookings.
- `POST /book` – accepts a JSON object representing a new booking and returns it back as confirmation.

All data is hard‑coded; replace the sample functions with real database queries to persist providers, services and bookings.

## Desktop/mobile prototype

The `ui` folder contains a minimal prototype using **V UI**, the cross‑platform UI library for V. Run it with:

```bash
cd ui
v run main.v
```

The program displays a list of providers and updates the selected provider when you click a button. V UI provides a declarative API similar to SwiftUI and React Native and supports Windows, Linux, macOS and Android, with iOS support planned【172222123824995†L542-L552】. According to the V UI README, the library is currently pre‑alpha and uses native widgets on Windows and macOS while drawing its own widgets on other platforms【336012686400495†L76-L85】. Therefore this example serves only as a starting point; you should expand it to implement the full Fuwü flows (search, service details, date & time picker, checkout, bookings, provider dashboard, etc.).

## Next steps

- **Extend the backend:** Add a database layer (e.g., SQLite via V's ORM) and implement CRUD operations for users, providers, services and bookings.
- **Build out the UI:** Create additional screens to match the Fuwü designs (home/discover, search results, service detail, calendar selection, checkout, bookings history, chat, provider dashboard, etc.).
- **Integrate front‑end and backend:** If you choose to build the front‑end in another framework (e.g., Vue or React), this backend can serve as the API. Alternatively, continue with V UI to build native apps, keeping in mind its early stage of development.

This starter illustrates how to approach development with V and should be customized and expanded significantly for production use.
