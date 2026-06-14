#!/bin/sh

echo "🎬 entrypoint.sh: [$(whoami)] [PHP $(php -r 'echo phpversion();')]"

composer dump-autoload --no-interaction --no-dev --optimize

echo "🎬 artisan commands"
# 💡 Group into a custom command e.g. php artisan app:on-deploy
php artisan storage:link --no-interaction
php artisan migrate --no-interaction --force

echo "🎬 generate swagger"
php artisan l5-swagger:generate

echo "🎬 optimize"
php artisan optimize --no-interaction

echo "🎬 start supervisord"
supervisord -c $LARAVEL_PATH/.deploy/config/supervisor.conf
