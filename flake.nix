{
  description = "Dev environment — PHP, Node, MySQL";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        php = pkgs.php83.buildEnv {
          extensions = { all, ... }: with all; [
            mbstring
            iconv
            pdo_mysql
            mysqlnd
            openssl
            tokenizer
            xml
            xmlwriter
            xmlreader
            ctype
            fileinfo
            bcmath
            curl
            dom
            filter
            pdo
            session
            simplexml
            zip
          ];
        };

      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            php
            php.packages.composer

            pkgs.nodejs_22
            pkgs.mariadb

            pkgs.git
            pkgs.curl
            pkgs.unzip
          ];

          shellHook = ''
            unset PHP_INI_SCAN_DIR
            unset PHPRC

            export MYSQL_HOME="$PWD/.nix-mysql"
            export MYSQL_DATADIR="$MYSQL_HOME/data"
            export MYSQL_UNIX_PORT="$MYSQL_HOME/mysql.sock"
            export MYSQL_TCP_PORT="3307"

            if [ ! -d "$MYSQL_DATADIR" ]; then
              echo "Initializing MySQL..."
              mkdir -p "$MYSQL_HOME"
              mysql_install_db --datadir="$MYSQL_DATADIR" --auth-root-authentication-method=normal > /dev/null 2>&1
            fi

            echo ""
            echo "=========================================="
            echo "  Dev Environment Ready"
            echo "=========================================="
            echo "  PHP:    $(php -r 'echo PHP_VERSION;')"
            echo "  Node:   $(node --version)"
            echo "  MySQL:  port $MYSQL_TCP_PORT"
            echo "=========================================="
            echo ""
            echo "  Start MySQL:"
            echo "    mysqld --datadir=\$MYSQL_DATADIR --socket=\$MYSQL_UNIX_PORT --port=\$MYSQL_TCP_PORT &"
            echo ""
          '';
        };
      }
    );
}