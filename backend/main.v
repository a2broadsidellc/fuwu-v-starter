module main

// This file implements a simple REST API for the Fuwü app using V's vweb module.
// The endpoints serve mock data for providers, services and bookings. It shows
// how to structure a V application with routes and JSON responses.

import vweb
import json

// App embeds vweb.Context to gain access to request and response helpers.
struct App {
    vweb.Context
}

// Provider represents a service provider on the platform.
struct Provider {
    id       int    `json:"id"`
    name     string `json:"name"`
    category string `json:"category"`
    rating   f32    `json:"rating"`
    distance string `json:"distance"`
}

// Service represents an individual service offered by a provider.
struct Service {
    id          int     `json:"id"`
    provider_id int     `json:"provider_id"`
    name        string  `json:"name"`
    price       f32     `json:"price"`
    duration    int     `json:"duration"` // in minutes
    description string  `json:"description"`
}

// Booking holds booking information for a user.
struct Booking {
    id          int    `json:"id"`
    user        string `json:"user"`
    provider_id int    `json:"provider_id"`
    service_id  int    `json:"service_id"`
    date        string `json:"date"`
    time        string `json:"time"`
    status      string `json:"status"`
}

// GET /get_providers – returns a list of all providers.
fn (mut app App) get_providers() vweb.Result {
    providers := sample_providers()
    return app.json(providers)
}

// GET /get_provider/:id – returns a single provider by ID.
fn (mut app App) get_provider(id string) vweb.Result {
    providers := sample_providers()
    for p in providers {
        if p.id.str() == id {
            return app.json(p)
        }
    }
    return app.text('Provider not found', 404)
}

// GET /get_services/:provider_id – returns services for a provider.
fn (mut app App) get_services(provider_id string) vweb.Result {
    services := sample_services()
    mut filtered := []Service{}
    for s in services {
        if s.provider_id.str() == provider_id {
            filtered << s
        }
    }
    return app.json(filtered)
}

// GET /get_bookings – returns existing bookings. In a real app this would filter by user.
fn (mut app App) get_bookings() vweb.Result {
    bookings := sample_bookings()
    return app.json(bookings)
}

// POST /book – create a booking. This sample just echoes back the sent data.
@[post]
fn (mut app App) book() vweb.Result {
    data := app.req.data
    booking := json.decode(Booking, data) or {
        return app.text('Invalid booking data', 400)
    }
    // In a full implementation you would insert into a database here and generate an ID.
    return app.json(booking)
}

// main creates an App and starts the web server on port 8080.
fn main() {
    mut app := App{}
    vweb.run_at(&app, vweb.RunParams{
        port: 8080
    }) or { panic(err) }
}

// sample_providers returns hard-coded providers for demonstration.
fn sample_providers() []Provider {
    return [
        Provider{ id: 1, name: 'Fresh Fades', category: 'Barber', rating: 4.9, distance: '0.5 mi' },
        Provider{ id: 2, name: 'Zen Hands Spa', category: 'Massage', rating: 4.8, distance: '1.0 mi' },
    ]
}

// sample_services returns services for the sample providers.
fn sample_services() []Service {
    return [
        Service{ id: 1, provider_id: 1, name: 'Men Haircut', price: 25.0, duration: 30, description: 'Classic haircut' },
        Service{ id: 2, provider_id: 2, name: 'Full Body Massage', price: 60.0, duration: 60, description: 'Relaxing massage' },
    ]
}

// sample_bookings returns a single booking to illustrate the API.
fn sample_bookings() []Booking {
    return [
        Booking{ id: 1, user: 'John Doe', provider_id: 1, service_id: 1, date: '2025-09-15', time: '14:00', status: 'confirmed' },
    ]
}
