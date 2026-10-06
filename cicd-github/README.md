# CI/CD Demo

This project demonstrates a GitHub Actions pipeline for a small Node.js application.

## Local checks

```powershell
npm test
npm run build
docker build -t cicd-demo .
docker run --rm -p 3000:3000 cicd-demo
```

Open `http://localhost:3000` to see:

```text
Hello from CI/CD demo!
```

## Pipeline

The workflow in `.github/workflows/ci-cd.yml` runs the test, builds and uploads the `dist` artifact, and builds and pushes the Docker image on pushes to `main`.

## Required GitHub secrets

Add these repository secrets under **Settings > Secrets and variables > Actions**:

- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`