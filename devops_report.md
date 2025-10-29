# DevOps Report: Django Todo Application

## 1. Technologies Used

- **Framework**: Django 4.x (Python web framework)
- **Database**: PostgreSQL 15 (production-grade relational database)
- **Containerization**: Docker & Docker Compose
- **CI/CD**: GitHub Actions
- **Registry**: Docker Hub
- **Languages**: Python 3.11
- **Additional Tools**: Flake8 (linting), Bandit (security scanning), Coverage (testing)

## 2. Pipeline Design

### 5-Stage Architecture

```
┌─────────────────┐
│  Build & Install │  → Installs dependencies, sets up Python environment
└────────┬────────┘
         │
┌────────▼──────────────┐
│ Lint & Security Scan   │  → Flake8, Bandit, Safety checks for code quality
└────────┬──────────────┘
         │
┌────────▼────────────────────────┐
│ Test (with DB Service)           │  → Runs Django tests with PostgreSQL
└────────┬────────────────────────┘
         │
┌────────▼────────────────┐
│ Build Docker Image       │  → Creates Docker image
└────────┬────────────────┘
         │
┌────────▼─────────────────────────────┐
│ Deploy (Conditional - main branch)   │  → Pushes to Docker Hub only if all pass
└──────────────────────────────────────┘
```

### Stage Details

1. **Build & Install**: Installs Python dependencies from requirements.txt
2. **Lint & Security**: Runs Flake8 for code style, Bandit for security vulnerabilities
3. **Test**: Spins up PostgreSQL service, runs Django migrations, executes tests with coverage
4. **Build Docker**: Builds optimized multi-stage Docker image
5. **Deploy**: Pushes image to Docker Hub (only on main branch, only if tests pass)

## 3. Secret Management Strategy

### GitHub Secrets

- `DOCKER_USERNAME`: Docker Hub username (not stored in code)
- `DOCKER_PASSWORD`: Docker Hub authentication token (not stored in code)

### Environment Variables

- Used `.env` file for local development (not committed to Git)
- Docker Compose loads from `.env` file for local testing
- GitHub Actions uses environment variables for database configuration during tests
- DATABASE credentials passed securely through GitHub Secrets in production

### Best Practices Applied

- No hardcoded passwords in any files
- Sensitive data only in GitHub Secrets or .env
- .env file added to .gitignore to prevent accidental commits
- Docker Compose uses variable substitution for flexibility

## 4. Docker Architecture

### Services

**Database Service (PostgreSQL)**

- Image: postgres:15-alpine (lightweight, secure)
- Port: 5432
- Persistent volume: `postgres_data` (database survives container restarts)
- Health check: Ensures DB is ready before app starts
- Network: Connected to `todo_network` bridge

**Web Service (Django App)**

- Built from custom Dockerfile (multi-stage optimization)
- Port: 8000
- Depends on: Database service (waits for health check)
- Environment: Reads from .env or docker-compose.yml
- Network: Connected to `todo_network` bridge
- Volumes: Mounts source code for live development

### Networking

- Services communicate via internal Docker bridge network (`todo_network`)
- No need to expose database port to host in production
- Services reference each other by container name (`db` for database)

### Persistence

- Database data persists in `postgres_data` volume
- Survives container restarts and stop/start cycles
- Can be backed up independently

## 5. Testing Process

### Local Testing

- Django's built-in test framework
- Database: Test database created automatically during test runs
- Coverage: Generates test coverage reports

### CI/CD Testing

- GitHub Actions spins up PostgreSQL 15 service
- Waits for DB to be healthy (health check)
- Runs `python manage.py migrate` to set up test database
- Executes `python manage.py test --no-input`
- Generates coverage report for code quality metrics

### Test Artifacts

- Coverage reports show line coverage percentage
- All tests must pass for deployment to proceed
- Test failures block the pipeline automatically

## 6. Dockerfile Optimization

### Multi-Stage Build

- **Builder stage**: Compiles Python packages, reduces final image size
- **Final stage**: Contains only runtime dependencies

### Security Features

- Non-root user (`appuser`) runs the application
- Minimal base image (python:3.11-slim)
- Health check endpoint for container monitoring
- No unnecessary tools in final image

### Performance

- Caches dependencies layer (only rebuilds on requirements.txt change)
- Alpine-based PostgreSQL image (lightweight)
- Optimized layer ordering for build cache efficiency

## 7. Branching Strategy

- **main**: Production branch, automatically deployed after tests pass
- **develop**: Development branch, tested but not deployed
- Feature branches merge via pull requests
- All branches trigger CI pipeline for validation

## 8. Lessons Learned

### What Worked Well

- Docker Compose simplifies local development and testing
- GitHub Actions provides seamless integration with repository
- Multi-stage Docker builds significantly reduce image size
- Environment variables provide flexibility across environments
- Health checks prevent race conditions between services

### Challenges Overcome

- Database connection timing: Solved with health checks and depends_on conditions
- Secrets management: GitHub Secrets + environment variables prevents credential leaks
- Docker image size: Multi-stage builds reduced bloat

### Future Improvements

- Add automated deployment to Render or Railway for staging environment
- Implement database migrations in separate CI stage
- Add performance testing and load testing to pipeline
- Consider using Kubernetes for orchestration at scale
- Implement automated rollback on deployment failure
- Add Slack/email notifications for pipeline status
