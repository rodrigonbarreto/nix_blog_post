# Nix Dev Environment — Laravel + React + MySQL

This is a companion repository for the blog post **[Add Nix to Your Project: One File, Zero Setup Drama](#)**.

The code here is intentionally simple — a Laravel API with a product CRUD and a React frontend that lists them. The focus is **not** the application code, but the `flake.nix` that manages the entire development environment.

## Quick Start

```bash
# Install Nix (one-time)
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Clone and enter the environment
git clone <this-repo>
cd workspace
nix develop

# Start MySQL
mysqld --datadir=$MYSQL_DATADIR --socket=$MYSQL_UNIX_PORT --port=$MYSQL_TCP_PORT &

# Backend
cd product-api
composer install
php artisan migrate:fresh --seed
php artisan serve

# Frontend (new terminal, nix develop first)
cd product-frontend
npm install
npm run dev
```

Open http://localhost:5173.

## What Nix Gives You

One command (`nix develop`) and you get PHP 8.3, Node 22, MySQL, Composer — all pinned to exact versions, isolated from your system. No `brew install`, no `apt-get`, no version conflicts.

## License

MIT