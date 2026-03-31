# README
# Spina CMS Developer Environment Docker

## Overview 

This project provides a way for developers to run a Ruby on Rails development environment using Spina CMS.

The goal here was to create something simple, repeatable, and easy to use. A developer should be able to clone the repo and get a working application running locally with minimal setup.

---

## Requirements
- Docker
- Docker Compose 

---

## Quick Start

Start the application:

```bash
docker compose up
```
Then open:
http://127.0.0.1:3000
http://127.0.0.1:3000/admin

This will also work on localhost:3000

## First Time Setup
If starting from a clean environment (first time or after removing volumes):

```bash 
docker compose run --rm web bin/rails spina:install
```
This step will prompt for:
- site name
- theme
- admin email and password

After completing that, start the app:
```bash
docker compose up
```

## Developer Workflows
If doing something outside of the normal startup flow:

Install dependencies: 
```bash
docker compose run --rm web bundle install
```

Update dependencies:
```bash
docker compose run --rm web bundle update
```

Run database setup manually:
```bash
docker compose run --rm web bin/rails db:prepare
```

Opening the Rails console: 
```bash
docker compose run --rm web bin/rails console
```

## Design Choices
I focused on keeping the local dev experience simple and consistent rather than trying to recreate a full production environment. 
- Docker Compose separates the app and database so the environment is reproducible across machines
- I added an entrypoint script to handle common setup tasks like installing dependencies and preparing the database
- I used a persistent volume for Ruby gems so developers can install or update dependencies without rebuilding the container.

## Known Callouts
- This is intended for local development only 
- HTTP is used instead of HTTPS
- Database credentials are simplified for local use
- If volumes are removed, Spina must be re-initialized.

## Resources Referenced 
- Docker documentation: https://docs.docker.com  
- Docker Compose documentation: https://docs.docker.com/compose/  
- Ruby on Rails Guides: https://guides.rubyonrails.org  
- Spina CMS documentation: https://spinacms.com/docs  

I also used general online resources when troubleshooting Docker behavior and application setup.

## Next Steps To Get This To Production
- Build a dedicated application image instead of using the base Ruby image
- Push images to ECR
- Run the application in ECS or EKS
- Use RDS for PostgreSQL
- Store any assets inside of S3
- Manage secrets properly using either parameter store or Secrets Manager
- Add CI/CD to build and push images, then deploy to the appropriate environment
