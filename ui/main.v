module main

// A very minimal desktop/mobile prototype of the Fuwü app using the V UI library.
// This program displays a list of providers and updates a label when a provider
// is selected. It serves as a starting point for building the full app.

import ui

struct App {
    mut:
        window  &ui.Window = unsafe { nil }
        selected int      // index of the selected provider
}

struct Provider {
    id   int
    name string
}

// sample provider list; in a real app this would be fetched from the backend.
const providers = [
    Provider{ id: 1, name: 'Fresh Fades' },
    Provider{ id: 2, name: 'Zen Hands Spa' },
]

// Builds a column of buttons for each provider.
fn (mut app App) build_provider_list() ui.WindowChild {
    mut btns := []ui.WindowChild{}
    for i, p in providers {
        // capture i for closure
        idx := i
        btns << ui.button(
            text: p.name
            on_click: fn [mut app, idx] (b &ui.Button) {
                app.selected = idx
                // trigger a redraw by updating window children
                app.window.set_children(app.build_ui().children)
            }
        )
    }
    return ui.column(
        spacing: 10
        children: btns
    )
}

// Constructs the main UI layout.
fn (mut app App) build_ui() ui.Window {
    return ui.window(
        width: 400
        height: 600
        title: 'Fuwü'
        children: [
            ui.column(
                spacing: 20
                margin: ui.Margin{10, 10, 10, 10}
                children: [
                    ui.label(text: 'Select a provider:'),
                    app.build_provider_list(),
                    ui.label(text: 'Selected: ' + providers[app.selected].name),
                ]
            )
        ]
    )
}

fn main() {
    mut app := &App{}
    app.selected = 0
    app.window = app.build_ui()
    ui.run(app.window)
}
