use actix_web::{web, App, HttpResponse, HttpServer, Responder};
use std::env;

#[macro_use] extern crate diesel_migrations;
extern crate diesel;
extern crate dotenv;

use diesel::prelude::*;
use diesel::pg::PgConnection;
use dotenv::dotenv;

embed_migrations!("./migrations");

fn index() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

pub fn establish_connection() -> PgConnection {
    dotenv().ok();

    let database_url = env::var("DATABASE_URL")
        .expect("DATABASE_URL must be set");
    PgConnection::establish(&database_url)
        .expect(&format!("Error connecting to {}", database_url))
}

fn main() {
    let connection = establish_connection();
    embedded_migrations::run(&connection)
    .unwrap();

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