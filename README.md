# Base for quick dev start for Laravel (and lumen i hope) and postgesql

### ENV
Copy `.env.example` and rename it to .env
`cp .env.example .env`



### MAILHOG
Laravel `.env` config
```dotenv
MAIL_MAILER=smtp
MAIL_HOST=${PREFIX}-mailhog <--- change due to your .env file
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS=null
MAIL_FROM_NAME="${APP_NAME}"
```