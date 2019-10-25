FROM rust:latest
RUN addgroup --gid 10001 app && adduser --gid 10001 --uid 10001 --home /app --shell /sbin/nologin --disabled-password app
ADD src/ /app/bare-necessities/src/
ADD migrations/ /app/bare-necessities/migrations/
ADD Cargo.toml Cargo.lock /app/bare-necessities/
RUN chown app /app -R
USER app
WORKDIR /app/bare-necessities
RUN cargo build --release
CMD cargo run --release
