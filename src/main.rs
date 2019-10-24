use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use std::env;

fn index() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

fn main() {
    // Get the port number to listen on.
    let port = env::var("PORT")
        .unwrap_or_else(|_| "3000".to_string())
        .parse()
        .expect("PORT must be a number");

    // Start a server, configuring the resources to serve.
    HttpServer::new(|| {
        App::new()
            .route("/", web::get().to(index))
    })
    .bind(("0.0.0.0", port))
    .unwrap()
    .run()
    .unwrap();
}